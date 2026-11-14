# 根据提示词生成文章配图，自动重试并识别"生成中"占位图
# 用法示例：
#   powershell -File .trae/skills/cps-article/scripts/generate-image.ps1 -Prompt "fish oil capsules on counter, no text" -OutFile "content/blog/xxx/featured.jpg" -Size landscape_16_9
param(
    [Parameter(Mandatory = $true)][string]$Prompt,
    [Parameter(Mandatory = $true)][string]$OutFile,
    [ValidateSet("square_hd", "square", "portrait_4_3", "portrait_16_9", "landscape_4_3", "landscape_16_9")]
    [string]$Size = "landscape_16_9",
    [int]$MaxAttempts = 12,
    [int]$WaitSeconds = 15
)

# 图片服务返回的"生成中"占位图的 MD5，用来判断是否拿到真实图片
$PlaceholderHash = "19A0B822EDB11957055E4588C2159058"
$EncodedPrompt = [uri]::EscapeDataString($Prompt)
$Url = "https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=$EncodedPrompt&image_size=$Size"
$TempFile = Join-Path $env:TEMP ("cps-img-" + [guid]::NewGuid().ToString() + ".jpg")

for ($i = 1; $i -le $MaxAttempts; $i++) {
    try {
        Invoke-WebRequest -Uri $Url -OutFile $TempFile -TimeoutSec 120
        Start-Sleep -Milliseconds 500
        $len = (Get-Item $TempFile).Length
        $hash = (Get-FileHash $TempFile -Algorithm MD5).Hash
        # 占位图固定为 176626 字节 / 固定 MD5，两者任一命中都视为未生成成功
        if ($hash -ne $PlaceholderHash -and $len -ne 176626) {
            $dir = Split-Path -Parent $OutFile
            if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
            Copy-Item $TempFile $OutFile -Force
            Write-Output "OK: $OutFile (attempt $i, $( (Get-Item $OutFile).Length ) bytes)"
            Remove-Item $TempFile -Force -ErrorAction SilentlyContinue
            exit 0
        }
        Write-Output ("attempt {0}/{1} placeholder, waiting {2} s" -f $i, $MaxAttempts, $WaitSeconds)
    }
    catch {
        Write-Output ("attempt {0}/{1} request failed - {2}" -f $i, $MaxAttempts, $_.Exception.Message)
    }
    Start-Sleep -Seconds $WaitSeconds
}

Remove-Item $TempFile -Force -ErrorAction SilentlyContinue
Write-Output "FAILED: image generator kept returning placeholders. Do not publish placeholder images."
exit 2
