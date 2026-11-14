# Draw a square promo tile (420x420) for deal-feed cards.
# Usage:
#   powershell -ExecutionPolicy Bypass -File deal-thumb.ps1 -Brand "iHerb Brands" -Headline "UP TO 30% OFF" -Note "Code NOV26HB" -Accent "#f97316" -OutFile "content/blog/<slug>/thumb-x.jpg"
# ASCII-only on purpose: PowerShell 5.1 mis-decodes non-ASCII scripts.
param(
    [Parameter(Mandatory = $true)][string]$Brand,
    [Parameter(Mandatory = $true)][string]$Headline,
    [string]$Note = "",
    [string]$Accent = "#f97316",
    [string]$Bg = "#FFF7ED",
    [Parameter(Mandatory = $true)][string]$OutFile,
    [int]$Size = 420
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

$accentColor = [System.Drawing.ColorTranslator]::FromHtml($Accent)
$bgColor = [System.Drawing.ColorTranslator]::FromHtml($Bg)

$bmp = New-Object System.Drawing.Bitmap $Size, $Size
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

$g.FillRectangle((New-Object System.Drawing.SolidBrush $bgColor), 0, 0, $Size, $Size)

# soft decorative circle in the corner
$halo = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(26, $accentColor))
$g.FillEllipse($halo, [int]($Size * 0.55), [int]($Size * -0.12), [int]($Size * 0.7), [int]($Size * 0.7))

# brand label
$brandFont = New-Object System.Drawing.Font "Segoe UI", 19, ([System.Drawing.FontStyle]::Bold)
$brandBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 100, 116, 139))
$g.DrawString($Brand, $brandFont, $brandBrush, 30, 30)

# headline: greedy wrap into at most two lines
$maxW = $Size - 60
$fontSize = 54
$font = New-Object System.Drawing.Font "Segoe UI", $fontSize, ([System.Drawing.FontStyle]::Bold)
$words = $Headline.Split(' ')
$lines = @()
$current = ""
foreach ($w in $words) {
    $try = if ($current) { "$current $w" } else { $w }
    if ($g.MeasureString($try, $font).Width -le $maxW) {
        $current = $try
    } else {
        if ($current) { $lines += $current }
        $current = $w
    }
}
if ($current) { $lines += $current }
if ($lines.Count -gt 2) { $lines = @($lines[0], ($lines[1..($lines.Count - 1)] -join ' ')) }

$lineH = $g.MeasureString("Ag", $font).Height
$startY = [int](($Size - ($lines.Count * $lineH)) / 2) - 18
$textBrush = New-Object System.Drawing.SolidBrush $accentColor
$y = $startY
foreach ($line in $lines) {
    $g.DrawString($line, $font, $textBrush, 28, $y)
    $y += $lineH
}

# accent rule + note
$g.FillRectangle((New-Object System.Drawing.SolidBrush $accentColor), 30, ($Size - 92), 56, 5)
if ($Note) {
    $noteFont = New-Object System.Drawing.Font "Segoe UI", 20
    $g.DrawString($Note, $noteFont, $brandBrush, 30, ($Size - 76))
}

$bmp.Save($OutFile, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$g.Dispose()
$bmp.Dispose()
Write-Output ("OK: {0} ({1} bytes)" -f $OutFile, (Get-Item $OutFile).Length)
