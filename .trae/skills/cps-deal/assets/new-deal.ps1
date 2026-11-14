# Scaffold a new /deals/ promotion post.
# Creates:
#   content/deals/<slug>/index.md          front matter + short body skeleton
#   content/deals/<slug>/card.jpg          420x420 tile for the /deals/ listing
#   content/deals/<slug>/thumb-<key>.jpg   420x420 tile for the in-post promo card
#   data/deals/<key>.yaml                  one promo entry (retailer / badge / code / link)
#   data/deals/<key>-picks.yaml            <n> placeholder product rows (3-6)
#
# Usage:
#   powershell -ExecutionPolicy Bypass -File .trae/skills/cps-deal/assets/new-deal.ps1 `
#     -Slug "iherb-brands-30-off" -Retailer "iHerb" -Badge "Up to 30% off" `
#     -Title "iHerb Brands Is Up to 30% Off Right Now" -Code "NOV26HB"
#
# ASCII-only on purpose: PowerShell 5.1 reads scripts as ANSI, so any non-ASCII
# character in comments or strings breaks parsing.
param(
    [Parameter(Mandatory = $true)][string]$Slug,
    [Parameter(Mandatory = $true)][string]$Retailer,
    [Parameter(Mandatory = $true)][string]$Badge,
    [Parameter(Mandatory = $true)][string]$Title,
    [string]$Summary = "",
    [string]$Code = "",
    [string]$Key = "",
    [string]$Headline = "",
    [int]$Products = 6,
    [string]$StoreUrl = "",
    [string]$Accent = "#f97316",
    [string]$Bg = "#FFF7ED",
    [string[]]$Tags = @("Omega-3", "Collagen", "Probiotics", "Vitamin C"),
    [string]$SidebarProducts = "coq10",
    [switch]$NoImage,
    [switch]$Force
)

$ErrorActionPreference = "Stop"

# ---------- helpers -------------------------------------------------------

# Wrap a value in double quotes so YAML keeps colons and hashes inside the string.
function ConvertTo-YamlString {
    param([string]$Value)
    return '"' + $Value.Replace('\', '\\').Replace('"', '\"') + '"'
}

# Always write UTF-8 without BOM (Hugo 0.162 in CI fails on a BOM) and use LF endings.
function Write-Utf8NoBom {
    param([string]$Path, [string]$Text)
    $utf8 = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($Path, $Text.Replace("`r`n", "`n"), $utf8)
}

# ---------- validate ------------------------------------------------------

# The slug is the URL segment: lowercase letters, digits and hyphens only.
if ($Slug -notmatch '^[a-z0-9]+(-[a-z0-9]+)*$') {
    throw "Slug must be kebab-case ASCII, e.g. iherb-brands-30-off"
}
if ($Products -lt 3 -or $Products -gt 6) {
    throw "Products must be between 3 and 6 (the picks grid is designed for 3-6 items)"
}
if (-not $Key) { $Key = $Slug }
if ($Key -notmatch '^[a-z0-9]+(-[a-z0-9]+)*$') {
    throw "Key must be kebab-case ASCII (it becomes the data file name)"
}
if (-not $Headline) { $Headline = $Badge.ToUpper() }
if (-not $Summary) {
    $Summary = "$Badge at $Retailer this week - $Products picks worth adding to the cart first."
}

# Affiliate parameters are mandatory. iHerb and Amazon get sensible defaults;
# any other retailer must pass -StoreUrl so a bare link never ships.
if (-not $StoreUrl) {
    if ($Retailer -match 'iherb') {
        $StoreUrl = 'https://www.iherb.com/c/iherb-brands?soa=true&rcode=RZK388'
    } elseif ($Retailer -match 'amazon') {
        $StoreUrl = 'https://www.amazon.com/?tag=ibetterlife-20'
    } else {
        throw "Pass -StoreUrl with the affiliate parameters for $Retailer"
    }
}

# Placeholder product links keep the same affiliate parameter as the promo link.
if ($Retailer -match 'iherb') {
    $pickUrl = "https://www.iherb.com/pr/replace-me?rcode=RZK388"
} elseif ($Retailer -match 'amazon') {
    $pickUrl = "https://www.amazon.com/dp/REPLACE?tag=ibetterlife-20"
} else {
    $pickUrl = $StoreUrl
}

# ---------- paths ---------------------------------------------------------

# This script lives in .trae/skills/cps-deal/assets/, so four levels up is the site root.
$root = (Resolve-Path (Join-Path $PSScriptRoot "..\..\..\..")).Path
if (-not (Test-Path (Join-Path $root "content"))) {
    throw "Cannot find the site root (no content folder) at $root"
}

$postDir = Join-Path $root "content\deals\$Slug"
$dataDir = Join-Path $root "data\deals"
$indexPath = Join-Path $postDir "index.md"
$cardPath = Join-Path $postDir "card.jpg"
$thumbPath = Join-Path $postDir ("thumb-{0}.jpg" -f $Key)
$promoPath = Join-Path $dataDir ("{0}.yaml" -f $Key)
$picksPath = Join-Path $dataDir ("{0}-picks.yaml" -f $Key)
$thumbScript = Join-Path $PSScriptRoot "deal-thumb.ps1"

$existing = @($indexPath, $promoPath, $picksPath) | Where-Object { Test-Path $_ }
if ($existing.Count -gt 0 -and -not $Force) {
    throw ("Already exists: {0}. Pass -Force to overwrite." -f ($existing -join ", "))
}

New-Item -ItemType Directory -Force -Path $postDir | Out-Null
New-Item -ItemType Directory -Force -Path $dataDir | Out-Null

# Format dates with the invariant culture so a Chinese Windows does not print "11yue 14".
$inv = [System.Globalization.CultureInfo]::InvariantCulture
$todayIso = (Get-Date).ToString("yyyy-MM-dd", $inv)
$todayShort = (Get-Date).ToString("MMM d", $inv)

# ---------- index.md ------------------------------------------------------

$tagLines = ($Tags | ForEach-Object { "  - " + $_.Trim() }) -join "`n"
$codeLine = ""
if ($Code) { $codeLine = "code: " + (ConvertTo-YamlString $Code) }

$frontMatter = @'
---
title: __TITLE__
summary: __SUMMARY__
date: __DATE__
authors:
  - me
tags:
__TAGS__
sidebar_products: __SIDEBAR__
# The 5 fields below drive the /deals/ row card and are not printed in the body.
badge: __BADGE__
retailer: __RETAILER__
updated: __UPDATED__
thumb: card.jpg
__CODE_LINE__
---

'@
$frontMatter = $frontMatter.Replace("__TITLE__", (ConvertTo-YamlString $Title)).
    Replace("__SUMMARY__", (ConvertTo-YamlString $Summary)).
    Replace("__DATE__", $todayIso).
    Replace("__TAGS__", $tagLines).
    Replace("__SIDEBAR__", $SidebarProducts).
    Replace("__BADGE__", (ConvertTo-YamlString $Badge)).
    Replace("__RETAILER__", (ConvertTo-YamlString $Retailer)).
    Replace("__UPDATED__", (ConvertTo-YamlString $todayShort)).
    Replace("__CODE_LINE__", $codeLine)

$body = @'
<!-- TODO: 2-3 chatty lines, Xiaohongshu tone, 3-6 emoji: what is on sale, which brands are included, and the code in bold. -->

{{< deal-feed data="__KEY__" >}}

## __COUNT__ picks I would grab first

<!-- TODO: one sentence of context, then replace the placeholder rows in data/deals/__KEY__-picks.yaml with real products. -->

{{< deal-picks data="__KEY__-picks" >}}

## How to use the code

- Shop through the __RETAILER__ promo link above.
- Paste **__CODE__** into the promo code box at checkout, then check the total before paying.
- __TODO_FINE_PRINT__
'@

$codeText = if ($Code) { $Code } else { "TODO-CODE" }
$body = $body.Replace("__KEY__", $Key).
    Replace("__COUNT__", "$Products").
    Replace("__RETAILER__", $Retailer).
    Replace("__CODE__", $codeText).
    Replace("__TODO_FINE_PRINT__", "TODO: shipping threshold or other fine print.").
    Replace("__BADGE__", $Badge)

Write-Utf8NoBom -Path $indexPath -Text ($frontMatter + "`n" + $body)

# ---------- data/deals/<key>.yaml ----------------------------------------

$promoCodeLine = ""
if ($Code) { $promoCodeLine = "  code: " + $Code }

$promo = @'
# One store promotion per post - rendered by {{< deal-feed data="__KEY__" >}}
# Only claim a discount, code or end date that the retailer itself displays.
- badge: __BADGE__
  title: __TITLE__
  desc: __DESC__
__CODE_LINE__
  retailer: __RETAILER__
  updated: __UPDATED__
  image: /deals/__SLUG__/thumb-__KEY__.jpg
  url: '__URL__'
'@
$promo = $promo.Replace("__KEY__", $Key).
    Replace("__BADGE__", (ConvertTo-YamlString $Badge)).
    Replace("__TITLE__", (ConvertTo-YamlString $Title)).
    Replace("__DESC__", (ConvertTo-YamlString $Summary)).
    Replace("__CODE_LINE__", $promoCodeLine).
    Replace("__RETAILER__", $Retailer).
    Replace("__UPDATED__", $todayShort).
    Replace("__SLUG__", $Slug).
    Replace("__URL__", $StoreUrl)

Write-Utf8NoBom -Path $promoPath -Text $promo

# ---------- data/deals/<key>-picks.yaml ----------------------------------

$rows = @()
for ($i = 1; $i -le $Products; $i++) {
    $rows += @"
- name: TODO product $i name (copy the exact title from the store)
  price: TODO price after the code is applied
  was: TODO the price the store shows today
  note: TODO discount label
  store: $Retailer
  image: /deals/$Slug/thumb-$Key.jpg
  url: '$pickUrl'
"@
}

$picks = @'
# __COUNT__ products under one promotion - rendered by {{< deal-picks data="__KEY__-picks" >}}
# Copy prices and discount labels from the retailer page. Verify each image returns 200.
# Required: name / image / url / price / store. Optional: was / note.
__ROWS__
'@
$picks = $picks.Replace("__COUNT__", "$Products").
    Replace("__KEY__", $Key).
    Replace("__ROWS__", ($rows -join "`n"))

Write-Utf8NoBom -Path $picksPath -Text $picks

# ---------- card art ------------------------------------------------------

if (-not $NoImage) {
    $note = if ($Code) { "Code $Code" } else { "While stocks last" }
    & $thumbScript -Brand $Retailer -Headline $Headline -Note $note -Accent $Accent -Bg $Bg -OutFile $cardPath
    & $thumbScript -Brand $Retailer -Headline $Headline -Note $note -Accent $Accent -Bg $Bg -OutFile $thumbPath
}

# ---------- report --------------------------------------------------------

Write-Output ""
Write-Output "Scaffolded deal post:"
Write-Output ("  content/deals/{0}/index.md" -f $Slug)
if (-not $NoImage) {
    Write-Output ("  content/deals/{0}/card.jpg" -f $Slug)
    Write-Output ("  content/deals/{0}/thumb-{1}.jpg" -f $Slug, $Key)
}
Write-Output ("  data/deals/{0}.yaml" -f $Key)
Write-Output ("  data/deals/{0}-picks.yaml" -f $Key)
Write-Output ""
Write-Output "Next:"
Write-Output "  1. Fill the TODO comments in the post and replace the placeholder picks with real products."
Write-Output "  2. Confirm every price, image and affiliate link against the retailer page."
Write-Output "  3. Run: hugo --noBuildLock --gc --minify, preview /deals/ and the post, then ask the user before pushing."
