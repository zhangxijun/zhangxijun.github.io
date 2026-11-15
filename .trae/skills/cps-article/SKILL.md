---
name: cps-article
description: Write Amazon and iHerb affiliate buying guides with design-style graphics for the iBetterLife Hugo site. Use when adding or editing CPS review posts in this repo. Never push to GitHub without user approval.
---

# CPS Article Workflow

Produce English review / buying-guide posts for US shoppers on this HugoBlox blog.
Follow the steps in order. Do not skip the image and build checks.

## Site facts

- Domain `https://ibetterlife.com`, content language English (US).
- Posts live in `content/blog/<kebab-slug>/index.md` (page bundle, images sit next to the file).
- Author key is `me` (iBetterLife Editorial) from `data/authors/me.yaml`.
- Amazon Associates tag `ibetterlife-20`, iHerb referral code `RZK388`.
- Brand palette: emerald `#059669`, deep green `#064E3B`, mint `#ECFDF5`.

## 1. Front matter

```yaml
---
title: 'Best <Category> in <Year>: <N> Picks Ranked by <Dimension>'
summary: One or two sentences, 150-160 characters, states the comparison and the payoff.
date: 2026-11-14
authors:
  - me
tags:
  - <Product category, e.g. Fish Oil>
  - <Second category, e.g. Omega-3>
  - <Brand A, e.g. Nordic Naturals>
  - <Brand B, e.g. Sports Research>
---
```

Use 4-5 tags per post. Lead with the product category, then the brands covered. Never tag
retailers or domains (Amazon, iHerb, ibetterlife), and never use "Buying Guides", "Supplements",
or other generic filler as a tag.

Title rules:

- Open with the head keyword, e.g. `Best CoQ10 Supplements`, then the year. Search traffic goes
  to that phrase, so never replace it with something clever.
- After the colon, promise something concrete: how many picks and what they are ranked by —
  e.g. `10 Picks Ranked by Dose & Cost`, `10 Picks Ranked by EPA & DHA`. Skip vague endings
  like "Amazon vs. iHerb Picks"; the retailer names live in the body and tags.
- Aim for 60-65 characters so Google does not truncate it.
- Never use a future date.

## 2. Depth standard

Aim for 2,000-2,800 words and 8-10 product picks. A post with fewer than 6 picks or under
1,200 words is too thin, extend it before publishing. Each pick must answer a different buyer
question: best overall, best value, one pill a day, budget, kids, seniors, highest DHA, no
fishy aftertaste, smallest pill, best seller. Do not repeat the same angle twice.

Selection criteria must cover, where the data allows: **sales heat** (review counts as the only
public proxy), **star rating**, **who it suits**, and **price per serving**. Say which criteria you
used in the intro and again in `## How we picked`.

Required sections, in order:

1. No inline FTC disclosure paragraph — the site keeps `/affiliate-disclosure/` in the nav, so
   do not add a disclosure line to the article body.
2. Intro that names the buyer problem and the selection criteria (and, for supplement topics,
   the fact that review counts are used as a sales proxy because neither retailer publishes units).
3. `## Why take <product category> at all` — 2-4 short paragraphs that set up the category before
   any product appears: what it does and does not do, who benefits most, what the government
   recommendation actually is, and why cost per serving matters. Skip only when the category is
   not a nutrient or a consumable with a health angle.
4. `## What the main <nutrients> actually do` — one table of 6-10 rows:
   `Nutrient | What it is for | What to look for on the label`. Plain-language purpose, then the
   exact label figure a shopper can compare (IU, mcg, DFE, mg, form name). Add 1-2 short
   paragraphs after the table for the two most common misreadings, e.g. "a multivitamin is not a
   calcium supplement" or "over 100% is not automatically better".
5. `## Quick comparison` table with 4-5 rows: Pick | Where to buy | Servings | Cost per serving | Best for.
6. One `##` section per product, numbered `## 1.`, `## 2.` … (matching the existing posts and the
   left TOC), containing:
   - product card via `product-grid` (see section 6)
   - 4-8 sentences on who it suits and what makes it stand out
   - **Strengths** — 2-3 bullets with real, verifiable facts
   - **What buyers say** — 2-3 real buyer reviews (see the rules below)
   - a spec line (serving size, count, dose highlights)
   - affiliate CTA link, one per retailer that actually sells it
7. `## How we picked` with 4-5 criteria, including popularity proxy, cost per serving, nutrient
   form and dose, buyer fit, and buyer experience.
8. `## FAQ` with 3-4 questions.
9. Medical or safety note for supplements.

### Real buyer reviews (`What buyers say`)

This block exists so the reader sees the product after real use, not just the label.

- **2-3 quotes per product.** One short paragraph per quote plus the attribution, in a Markdown
  blockquote so it renders as a pull quote.
- **Copy them from the live product page.** iHerb reviews are public (fetch through
  `https://r.jina.ai/<iherb-url>`); Amazon reviews sit behind a login and the `dp` page usually
  shows none, so do not claim Amazon reviews you cannot see.
- **Attribute what is actually shown:** a reviewer name when printed, otherwise
  "iHerb verified buyer", followed by the month and year on the review.
- **Keep one dissenting voice** per list where it is relevant — a complaint about size, taste,
  B6 tingling, price. Reviews that are all praise read as advertising.
- **Never invent, merge or "improve" a quote.** Do not fix a buyer's grammar into a marketing
  sentence, do not attach a date you cannot see, and do not recycle a quote from another product.
  If a product has no readable reviews, say so and omit the block for that pick.
- **Translate faithfully on `/zh/`, `/ja/`, `/ko/` pages.** Keep the meaning and the criticism
  intact; do not soften a negative line. Translation is fine, paraphrase-as-quote is not.
- Keep each quote under about 30 words (in English) so the section does not turn into a wall of
  quotes.

Use only verifiable data. If a review count, price, or lab result cannot be confirmed, either
omit it or label it clearly as approximate. Never invent certifications, sales ranks, or awards.

## 3. Product images

Prefer retailer product images when a working URL is verified, otherwise use a design card.

Amazon affiliate image widget (requires the tag, works for Associates):

```
https://ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=<ASIN>&Format=_SL250_&ID=AsinImage&MarketPlace=US&ServiceVersion=20070822&WS=1&tag=ibetterlife-20
```

Render as a clickable image that points at the affiliate link:

```markdown
[![Product name](https://ws-na.amazon-adsystem.com/widgets/q?...&ASIN=<ASIN>&...&tag=ibetterlife-20)](https://www.amazon.com/dp/<ASIN>?tag=ibetterlife-20)
```

Verify each image URL returns HTTP 200 with an image content type before using it. Never ship a
guessed URL. For iHerb, use a product image URL only when it is confirmed to load; otherwise draw
a design card with the product name and retailer.

Known issue as of November 2026: the `ws-na.amazon-adsystem.com` image widget hostname does not
resolve, so that template currently returns nothing. Ask the user to copy official image links
from Amazon SiteStripe, or use a drawn design card. Direct `m.media-amazon.com/images/I/...` links
are acceptable only when the user supplies them or they are verified to load.

## 4. Design graphics first (default)

The user prefers drawn brand graphics over AI photos. Generate them locally, no external service.

- Featured image: `featured.jpg`, 1600x900.

```powershell
powershell -ExecutionPolicy Bypass -File .trae/skills/cps-article/assets/cover-template.ps1 -Title "10 Best Omega-3 Supplements" -Subtitle "Ranked by EPA & DHA for 2026" -OutFile "content/blog/<slug>/featured.jpg"
```

- Inline graphics: `image-<topic>.jpg`, 1200x900, one of these patterns:
  - checklist card list (3-4 rounded white cards, emerald check circle, one line each)
  - numbered pick cards (number circle, pick label, retailer line)
  - simple comparison bars or spec callouts
- Draw with `System.Drawing` in a Windows PowerShell script. Keep script text ASCII-only so
  PowerShell 5.1 does not mis-decode it, then delete the helper script when done.
- Place one graphic after the intro and one before `## How we picked`.
- Reuse the template's colors, rounded corners, generous whitespace, and Segoe UI.

AI photo generation is opt-in only, when the user explicitly asks for photos. If used, run
`scripts/generate-image.ps1`, which detects the fixed 176626-byte placeholder and fails instead of
saving a fake image. Never publish a placeholder or a broken image.

## 5. Affiliate links

**Always link the exact product page, never a search results page.**

```
[Check price on Amazon](https://www.amazon.com/dp/<ASIN>?tag=ibetterlife-20)
[Check price on iHerb](https://www.iherb.com/pr/<product-slug>/<id>?rcode=RZK388)
```

Link rules:

- **No `amazon.com/s?k=...` search URLs and no `iherb.com/search?kw=...` URLs** in a finished post.
  A search page shows a wall of look-alike bottles and sends the reader to the wrong size, so it
  loses the click. The only exception is a temporary draft marked `<!-- TODO direct link -->`.
- **Amazon: prefer `Sold by Amazon.com`**, then the brand's official Amazon storefront (for some
  brands this is operated by an agency such as Pattern., which still counts as the brand's channel).
  Open the dp page and read the seller line before using it. If only unrelated third-party sellers
  carry the item, drop the Amazon button and keep iHerb only.
- **iHerb: always the `/pr/<slug>/<id>` page.** Verify the listing is the same brand, variant and
  count that the card shows.
- **One retailer that cannot be verified → one button.** Never keep a search link just to have two
  buttons; a single correct iHerb button is better than a second link that lands on the wrong bottle.
- **The card image and the buy link must point at the same product.** Do not pair an iHerb photo
  with an Amazon link for a different count or formula.
- Verify the seller/listing at writing time and note the date in the article ("prices and sellers
  checked November 15, 2026"), because Amazon buy-box ownership changes.

Never leave `<ASIN>`, `YOUR-TAG`, or `REPLACE` placeholders in a published post.

## 6. Product grid component

Every buying guide puts one product card at the top of each product section, directly under the
`## N.` heading. Do not dump all cards into a single grid block.

- Shortcode: `{{< product-grid data="<key>" item="N" >}}` where `N` is the 1-based row in the data file
- Data file: `data/products/<key>.yaml`
- Card fields: `name`, `badge`, `retailer`, `image`, `meta` (3 lines), `stars`, `rating`, `tip`, `note`, `url`
- `stars` is the editor score (1-5) and renders a gold star row; `rating` is optional and only
  filled with a verified store rating; `tip` is a short shopping hint such as "5 stars for kids"
- Use `links` when a product is sold by more than one retailer, so the card renders multiple branded
  CTA buttons. Each item needs `store` (`Amazon` or `iHerb`) and `url`. Keep the top-level `url`
  for the image/primary link, and order the buttons `Amazon` then `iHerb`.
- Quote any badge that starts with `#`, otherwise YAML treats it as a comment
- Cards render with a green CTA and `rel="sponsored nofollow noopener"`
- Images use `object-fit: contain` inside a white frame, so real bottle photos are never cropped

```yaml
- name: Nordic Naturals Ultimate Omega
  badge: Best overall
  retailer: Amazon
  image: https://m.media-amazon.com/images/I/<image-id>._AC_SL1000_.jpg
  meta:
    - 180 softgels (90 servings)
    - ~$59-65
    - ~47,000 Amazon ratings
  note: 1,100 mg combined EPA + DHA per 2 softgels.
  url: https://www.amazon.com/dp/<ASIN>?tag=ibetterlife-20
```

### Real product photos

Use the retailer's own product photo, not an illustration, whenever a URL can be verified.

- Amazon: fetch `https://www.amazon.com/dp/<ASIN>` with a desktop user agent and read the
  `"hiRes":"..."` value. The legacy `images/P/<ASIN>` endpoint still works for some ASINs but
  returns a 43-byte blank GIF for others, so always check the byte size.
- iHerb: the site blocks plain requests (403). Fetch through `https://r.jina.ai/<product-url>`
  with header `x-respond-with: html`, then collect
  `https://cloudinary.images-iherb.com/image/upload/.../images/<brand>/<code>/l/<id>.jpg`.
  The `s/` path is a small thumbnail, prefer `l/`.
- Verify every image returns HTTP 200 with an `image/*` content type and more than ~10 KB before
  writing it into the data file.
- Keep the retailer link and image pointing at the same product. Do not hotlink a competitor's
  photo for a product the retailer does not sell.

If no verified photo exists, fall back to a drawn illustration and say so in the change summary.

## 7. Verify, then ask before pushing

1. Build: `hugo --noBuildLock --gc --minify`.
2. Confirm the new page exists in `public/blog/<slug>/index.html`, references the featured image,
   and contains both affiliate parameters.
3. Preview locally with `pnpm.cmd dev` and check the table, images, and CTA links.
4. Stop here. Show the user what changed and ask for approval. Do not run `git commit` or
   `git push` until the user explicitly confirms.
5. Only after approval: commit, push to `main`, wait for the Actions run to finish, then confirm
   `https://ibetterlife.com/blog/<slug>/` returns 200 and images load.

## Compliance rules

- The affiliate disclosure page must stay reachable from the footer and navigation.
- No income claims, fake urgency, or copied manufacturer copy.
- Health content stays informational and includes an "ask your doctor" line.
- Do not state live Amazon prices in static text; link out instead.
- Escape every dollar sign with a backslash (`\$19.33`). Two unescaped `$` in one paragraph make
  Hugo read the text between them as inline math, which silently turns `**bold**` and links
  inside that span into plain text.
- In Chinese/Japanese text, never leave a punctuation mark on the inside edge of `**` when CJK
  characters follow immediately. Write `**B族维生素**：B1...` and `**ユビキノン**（ubiquinone）と...`,
  not `**B族维生素：**B1...` or `**ユビキノン（ubiquinone）**と...`. CommonMark cannot close emphasis
  when the closing run is preceded by punctuation and followed by a letter, so Hugo prints `**`.
- In translation files (`index.zh.md`, `index.ja.md`), reference bundle images with the absolute
  default-language path, e.g. `/blog/<slug>/image-check-label.jpg`. Hugo publishes page resources
  only under the default language, so relative image names 404 on `/zh/` and `/ja/` pages.
