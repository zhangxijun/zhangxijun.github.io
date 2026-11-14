# Draw a wide promo header (1200x420) for deal-roundup posts.
# Usage:
#   powershell -ExecutionPolicy Bypass -File deal-header.ps1 -Title "This week's supplement deals" -Subtitle "Promo codes and sales we verified" -Tag "Updated Nov 14" -OutFile "content/blog/<slug>/image-deals-header.jpg"
# ASCII-only on purpose: PowerShell 5.1 mis-decodes non-ASCII scripts.
param(
    [Parameter(Mandatory = $true)][string]$Title,
    [string]$Subtitle = "",
    [string]$Eyebrow = "IBETTERLIFE  |  DEALS",
    [string]$Tag = "",
    [string]$Domain = "ibetterlife.com",
    [Parameter(Mandatory = $true)][string]$OutFile,
    [int]$Width = 1200,
    [int]$Height = 420
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
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

$rect = New-Object System.Drawing.Rectangle 0, 0, $Width, $Height
$grad = New-Object System.Drawing.Drawing2D.LinearGradientBrush $rect, ([System.Drawing.Color]::FromArgb(255, 4, 78, 59)), ([System.Drawing.Color]::FromArgb(255, 16, 185, 129)), 20
$g.FillRectangle($grad, $rect)

$halo = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(22, 255, 255, 255))
$g.FillEllipse($halo, 820, -140, 460, 460)
$g.FillEllipse($halo, 940, 180, 340, 340)

$white = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::White)
$soft = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(220, 255, 255, 255))

$pill = New-RoundedRectPath 64 56 320 52 26
$g.FillPath((New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(55, 255, 255, 255))), $pill)
$g.DrawString($Eyebrow, (New-Object System.Drawing.Font "Segoe UI", 17, ([System.Drawing.FontStyle]::Bold)), $white, 86, 70)

$titleSize = 58
$titleFont = New-Object System.Drawing.Font "Segoe UI", $titleSize, ([System.Drawing.FontStyle]::Bold)
while ($g.MeasureString($Title, $titleFont).Width -gt ($Width - 120) -and $titleSize -gt 34) {
    $titleSize -= 2
    $titleFont = New-Object System.Drawing.Font "Segoe UI", $titleSize, ([System.Drawing.FontStyle]::Bold)
}
$g.DrawString($Title, $titleFont, $white, 60, 146)
if ($Subtitle) {
    $g.DrawString($Subtitle, (New-Object System.Drawing.Font "Segoe UI", 26), $soft, 64, 246)
}

if ($Tag) {
    $tagPath = New-RoundedRectPath 64 302 260 56 28
    $g.FillPath((New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 249, 115, 22))), $tagPath)
    $g.DrawString($Tag, (New-Object System.Drawing.Font "Segoe UI", 21, ([System.Drawing.FontStyle]::Bold)), $white, 92, 316)
}

$g.DrawString($Domain, (New-Object System.Drawing.Font "Segoe UI", 18, ([System.Drawing.FontStyle]::Bold)), $soft, ($Width - 190), ($Height - 54))

$bmp.Save($OutFile, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$g.Dispose()
$bmp.Dispose()
Write-Output ("OK: {0} ({1} bytes)" -f $OutFile, (Get-Item $OutFile).Length)
