# Draw a brand-style cover graphic (no external image service needed).
# Usage:
#   powershell -ExecutionPolicy Bypass -File assets/cover-template.ps1 -Title "Omega-3 Buying Guide" -Subtitle "Amazon vs. iHerb picks for 2026" -OutFile "content/blog/my-post/featured.jpg"
param(
    [Parameter(Mandatory = $true)][string]$Title,
    [string]$Subtitle = "",
    [string]$Eyebrow = "IBETTERLIFE  |  REVIEWS",
    [string]$Domain = "ibetterlife.com",
    [Parameter(Mandatory = $true)][string]$OutFile,
    [int]$Width = 1600,
    [int]$Height = 900
)

Add-Type -AssemblyName System.Drawing

function New-RoundedRectPath {
    param([float]$X, [float]$Y, [float]$W, [float]$H, [float]$R)
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $d = $R * 2
    $path.AddArc($X, $Y, $d, $d, 180, 90)
    $path.AddArc($X + $W - $d, $Y, $d, $d, 270, 90)
    $path.AddArc($X + $W - $d, $Y + $H - $d, $d, $d, 0, 90)
    $path.AddArc($X, $Y + $H - $d, $d, $d, 90, 90)
    $path.CloseFigure()
    return $path
}

$outDir = Split-Path -Parent $OutFile
if ($outDir -and -not (Test-Path $outDir)) { New-Item -ItemType Directory -Force -Path $outDir | Out-Null }

$bmp = New-Object System.Drawing.Bitmap $Width, $Height
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

$rect = New-Object System.Drawing.Rectangle 0, 0, $Width, $Height
$grad = New-Object System.Drawing.Drawing2D.LinearGradientBrush $rect, ([System.Drawing.Color]::FromArgb(255, 4, 78, 59)), ([System.Drawing.Color]::FromArgb(255, 16, 185, 129)), 40
$g.FillRectangle($grad, $rect)

$halo = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(24, 255, 255, 255))
$g.FillEllipse($halo, [int]($Width * 0.68), -180, 640, 640)
$g.FillEllipse($halo, [int]($Width * 0.76), [int]($Height * 0.5), 420, 420)

$white = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::White)
$soft = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(215, 255, 255, 255))
$faint = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(165, 255, 255, 255))

$pillPath = New-RoundedRectPath 100 80 430 64 32
$g.FillPath((New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(50, 255, 255, 255))), $pillPath)
$g.DrawString($Eyebrow, (New-Object System.Drawing.Font "Segoe UI", 20, ([System.Drawing.FontStyle]::Bold)), $white, 128, 98)

$maxTextWidth = $Width - 200
$titleSize = 96
$titleFont = New-Object System.Drawing.Font "Segoe UI", $titleSize, ([System.Drawing.FontStyle]::Bold)
while ($g.MeasureString($Title, $titleFont).Width -gt $maxTextWidth -and $titleSize -gt 48) {
    $titleSize -= 4
    $titleFont = New-Object System.Drawing.Font "Segoe UI", $titleSize, ([System.Drawing.FontStyle]::Bold)
}
$g.DrawString($Title, $titleFont, $white, 96, 210)

$linePen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(120, 255, 255, 255)), 5
$g.DrawLine($linePen, 100, 520, 560, 520)

$g.DrawString($Subtitle, (New-Object System.Drawing.Font "Segoe UI", 34), $soft, 100, 566)
$g.DrawString($Domain, (New-Object System.Drawing.Font "Segoe UI", 26, ([System.Drawing.FontStyle]::Bold)), $faint, 100, ($Height - 110))

$bmp.Save($OutFile, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$g.Dispose()
$bmp.Dispose()
Write-Output ("OK: {0} ({1} bytes)" -f $OutFile, (Get-Item $OutFile).Length)
