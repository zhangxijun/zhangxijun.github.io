---
name: cps-brand
description: Write English brand profile pages for the iBetterLife /brands/ section, covering what the brand makes, how it differs from rivals, popular products and verifiable awards. Use when adding or editing a supplement brand page. Never push to GitHub without user approval.
---

# CPS Brand Page Workflow

Build one brand profile per page for the `/brands/` section. The job is not to repeat the
brand's About page. It is to answer four questions a shopper already has:

1. What does this company actually make, and on what process or sourcing does it stake its name?
2. How does it differ from the brands sitting next to it on the same shelf?
3. Which products are worth buying, and which are just catalog filler?
4. What has been independently certified or awarded, and what is only marketing?

## Site facts

- Domain `https://ibetterlife.com`, content language English (US).
- Brand pages live in `content/brands/<brand-slug>/index.md`.
- The brand index is `content/brands/_index.md`, rendered from `data/brands.yaml`.
- Templates: `layouts/brands/list.html` (index) and `layouts/brands/single.html` (profile).
- Amazon Associates tag `ibetterlife-20`, iHerb referral code `RZK388`.
- Brand palette: emerald `#059669`, deep green `#064e3b`, mint `#ecfdf5`.

## Step 1: research before writing

Never write from memory. Collect these first, and keep the source of each fact:

- **Corporate facts** — founding year, headquarters, parent company and acquisition year,
  manufacturing location. Use the brand's own history page plus one independent source.
- **Process and sourcing claims** — fermentation, plant-based calcium, organic certification,
  branded ingredients. These become the "what the brand actually is" section.
- **Awards** — name, year and issuing publication. Awards must come from the brand's product
  page or the awarding publication itself. A page that lists "multiple industry awards"
  without years is not a source.
- **Certifications** — Non-GMO Project, NSF, USP, OU Kosher, Certified Organic, TESTED by
  SuppCo. Note which ones cover the whole line and which cover selected SKUs.
- **Price position** — collect 2 or 3 comparable products and compare cost per serving
  against the closest rivals. Do not guess a "premium" tier without numbers.
- **Which products are actually popular** — iHerb rating and review count on the brand's top
  SKUs, plus Amazon review counts. Ignore a product that has no review base.
- **Internal coverage** — search `content/blog/` for anything already published on this brand,
  so the profile links to it instead of repeating it.

If a fact cannot be verified, leave it out. Do not fill the gap with a plausible sentence.

## Step 2: confirm the outline

Before writing, send the user a short outline: the four sections, roughly 15 products grouped
by category, and the awards you found with years. Wait for approval. This mirrors the
propose-first rule used for buying guides. For a smaller brand whose verified catalog cannot
support about 15 products, explain the gap and get approval for a shorter list.

## Step 3: page structure

Front matter:

```yaml
---
title: New Chapter
description: One sentence, 140-160 characters, states what the brand is known for.
show_date: false
reading_time: false
brand_slug: new-chapter
tagline: Ten words or fewer.
monogram: NC
accent: "#7c2d12"
founded: 1982
hq: Brattleboro, Vermont
parent: Procter & Gamble (since 2012)
price_tier: Premium
best_for: Bone health, turmeric blends, fermented multivitamins
amazon: https://www.amazon.com/s?k=new+chapter&i=hpc&tag=ibetterlife-20
iherb: https://www.iherb.com/c/new-chapter?rcode=RZK388
---
```

`amazon` and `iherb` must also exist in `data/brands.yaml` for that slug, with the same URLs.

Use visible hierarchical numbering on section headings. Number each H2 as `1.`, `2.`, and so
on in body order, leaving the opening unnumbered. Number H3 category headings with two-level
numbers that match their parent, such as `3.1` and `3.2`. Individual product names may remain
unnumbered H4 headings.

Body sections, in this order:

1. **Opening (2 paragraphs)** — what the company is and the one claim it rests on. No
   throat-clearing, no "in today's crowded market".
2. **What the brand actually is** — three short labeled pillars (process, ingredient form,
   sourcing). Each pillar explains the mechanism, not the marketing adjective.
3. **How it compares with other brands** — a markdown table with 3 rival brands and rows for
   focus, price tier, distinct claim and best fit, followed by one paragraph saying who
   should pick this brand over each rival.
4. **Popular products** — for a mainstream brand, cover roughly 15 products (usually 15-16)
   instead of defaulting to a short six-item list. Group them into useful H3 categories and
   give each product its own unnumbered H4 subsection, a product card and 2-4 sentences
   covering what it is, the dose that decides the pick, who it suits and the caveat. A category
   may include a comparison table when it clarifies doses, sizes or life-stage variants. The
   card comes from `{{< product-grid data="<brand>" item="N" >}}` backed by
   `data/products/<brand>.yaml`.
   
   Research both Amazon and iHerb for every selected product; an iHerb-only card is not
   complete until an exact Amazon listing has also been searched for. Add both retailer
   buttons whenever both listings are verified. An Amazon button requires an opened product
   page whose ASIN, formula, size, count and pack quantity match the card; a search-results
   page or a look-alike bottle is not verification. If only one retailer has an exact verified
   listing, keep that retailer's button and omit the other. If neither listing is verified,
   write the product in prose without a card rather than shipping a dead or look-alike link.

   **Product card `image:` field — always use local static images, never CDN URLs.**
   iHerb's Cloudinary CDN paths drift over time and Amazon CDN images require per-ASIN scraping
   that triggers bot protection. Instead, the image field in every brand YAML must point to a
   local Hugo static file using this convention:

   ```yaml
   image: /images/brands/<brand-slug>/<slugified-product-name>.jpg
   ```

   Where `<slugified-product-name>` is the full product name lowercased, stripped of punctuation,
   and spaces replaced with hyphens. Examples:
   - `California Gold Nutrition Omega 800, High Potency, 90 Softgels`
     → `california-gold-nutrition-omega-800-high-potency-90-softgels.jpg`
   - `Doctor's Best High Absorption Magnesium Lysinate Glycinate Chelated, 240 Tablets`
     → `doctors-best-high-absorption-magnesium-lysinate-glycinate-chelated-240-tablets.jpg`

   The directory `static/images/brands/<brand-slug>/` must be created before build and left empty
   (or with placeholder files) for the user to populate manually — see Step 5 for the handoff.
5. **Awards and certifications** — certifications as a bullet list; awards as
   `Year + award name + issuing publication`. Put the brand's own "#1" style claims in a
   separate sentence and label them as the company's claim.
6. **Where the brand is weaker** — 2-3 real drawbacks with numbers: cost per serving versus
   named rivals, tablet burden, thin clinical evidence, SKU gaps.
7. **Buying notes** — size variants, which retailer tends to be cheaper, what to check
   before comparing prices.

## Award and claim rules

- Never write "award-winning" without the year and the publication.
- A brand's own press page counts as a source for "Vogue.com named it X in 2026" only when
  you attribute it to the brand page, not to Vogue.
- "#1 selling" or "#1 natural calcium brand" are self-reported. State that plainly once.
- Do not convert awards into a quality score. An award is evidence of retail popularity,
  not of efficacy.

## Writing rules

- Lead with a number, a year or a concrete product. No scene-setting.
- Do not write hype adjectives: revolutionary, game-changing, cutting-edge, best-in-class.
- Do not write AI filler: "In today's world", "when it comes to", "it's important to note",
  "delve into", "unlock", "elevate".
- Do not prove your own honesty. Banned: "we verified each claim", "rather than copying the
  brand page", "our research shows". State the fact; skip the process narration.
- Do not fake hands-on testing. No "we took this for 90 days" or invented taste, smell or
  body feel. Buyer impressions must be quoted from iHerb or Amazon reviews with attribution.
- Keep claims inside what the label and certificate say. "905 mg plant calcium per 3 tablets"
  is a label fact; "builds bone density" is a claim that needs a citation or a hedge.

## Links

- Amazon brand button: brand-filtered search
  `https://www.amazon.com/s?k=<brand>&i=hpc&tag=ibetterlife-20`.
- Amazon product button: canonical `https://www.amazon.com/dp/<ASIN>?tag=ibetterlife-20`
  only after opening the page and matching the exact formula, size, count and pack quantity.
  Never substitute a different bottle size or a multipack merely to add an Amazon button.
- Amazon fallback button: when Amazon does not sell the exact bottle shown on the card (for
  example New Chapter's 72-count tablets, where Amazon lists 48-count or 96-count multipacks),
  link to an exact-name search such as
  `https://www.amazon.com/s?k=new+chapter+every+womans+one+daily+40+multivitamin&i=hpc&tag=ibetterlife-20`
  instead of a look-alike `/dp/` page. Keep the query specific to brand, formula and version.
- Every product card should carry an Amazon button; an iHerb-only card is an unfinished card,
  not a deliberate choice.
- iHerb product button: the exact verified `/pr/` URL with `?rcode=RZK388`.
- iHerb brand button: verified brand page `https://www.iherb.com/c/<slug>?rcode=RZK388`. The slug is not
  always the obvious one (`nature-s-bounty`, `nature-s-way`, `21st-century-health-care`,
  `carlson-labs`). Verify the page title before shipping; if no brand page exists, omit the
  iHerb button and keep Amazon only.
- Internal links go to the matching review or buying guide. Do not link a product to a guide
  that does not mention it.

## Language

English only for now. Other languages come later as `index.zh.md`, `index.ja.md`,
`index.ko.md`; the nav item exists only in the English menu, so do not create localized
brand pages without updating `config/_default/languages.yaml` and the index links.

## Step 4: build and hand off

Run `hugo --noBuildLock --gc --minify`. Do not start a preview server or check page layout;
the user reviews pages manually. Confirm only that:

- `/brands/<slug>/index.html` was generated
- visible H2/H3 numbering is present and the product-card count matches the approved list,
  normally about 15 for a mainstream brand
- the hero has 1 Amazon and 1 iHerb affiliate link when both exist, and each product card has
  buttons only for exact verified retailer listings
- the brand index still renders the full card count

Never commit or push without explicit approval.

## Step 5: image checklist and manual download handoff

After build passes, do **not** attempt to automate image fetching from iHerb or Amazon.
Both sites block headless browsers with Cloudflare bot protection. Image acquisition is a
manual user step. The handoff follows this exact sequence:

**5a. Create the images directory**

Before handing off, create `static/images/brands/<brand-slug>/` (PowerShell):

```powershell
New-Item -ItemType Directory -Force -Path "e:\ibetterlife\static\images\brands\<brand-slug>"
```

**5b. Generate the image checklist file**

Produce a plain-text checklist at `doc/image-checklist-<brand-slug>.txt`. The `doc/` directory
is gitignored, so it is safe to leave locally without committing. Use PowerShell to generate
it from the YAML product list:

```powershell
$dataDir  = "e:\ibetterlife\data\products"
$slug     = "<brand-slug>"          # e.g. "california-gold-nutrition"
$yamlFile = "<brand-yaml>"           # e.g. "california-gold-nutrition.yaml"
$docDir   = "e:\ibetterlife\doc"
New-Item -ItemType Directory -Force -Path $docDir | Out-Null

function Convert-ToSlug([string]$t) {
  $s = $t.ToLower() -replace '[^a-z0-9\s-]','' -replace '\s+','-' -replace '-+','-'
  return $s.Trim('-')
}

$raw = Get-Content "$dataDir\$yamlFile" -Raw
$raw = $raw -replace "`r`n", "`n"
$products = @()
foreach ($line in ($raw -split "`n")) {
  if ($line -match '^- name:\s*(.+)$') { $products += $Matches[1].Trim() }
}

$out = @()
$out += "Image checklist for $slug"
$out += "Place each file in: static/images/brands/$slug/"
$out += "Recommended size: 800x800 JPG"
$out += "---------------------------------------------------"
for ($i = 0; $i -lt $products.Count; $i++) {
  $fn = "$(Convert-ToSlug $products[$i]).jpg"
  $out += ("{0,2}. {1}" -f ($i+1), $products[$i])
  $out += ("     -> {0}" -f $fn)
}
$out += "---------------------------------------------------"
$out += "Total: $($products.Count) images needed"
$out | Out-File -Encoding utf8 "$docDir\image-checklist-$slug.txt"
```

This script parses the brand YAML `name:` lines, slugifies each, and produces a numbered
list of product name → expected filename pairs. Run it once per brand.

**5c. Tell the user, do not wait**

In the final handoff message, include all of these:
1. **The directory path** where images go (clickable absolute path, e.g.
   `E:\ibetterlife\static\images\brands\california-gold-nutrition\`)
2. **The checklist file path** (clickable, e.g. `doc/image-checklist-california-gold-nutrition.txt`)
3. **Total count** of images needed
4. **Source hint**: "Right-click → Save image from the iHerb or Amazon product page is fine"
5. **Recommended size**: "800x800 JPG works well, any similar square product photo is fine"

Do **not** start a preview server and do **not** commit the placeholder images directory to git.
Wait for the user to place images and confirm before build, preview, and push.
