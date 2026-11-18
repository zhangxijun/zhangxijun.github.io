---
name: cps-deal
description: Write short store-promotion posts for the iBetterLife /deals/ section, using the 55haitao-style promo card plus a 6-product picks grid. Use when a retailer is running a sale (iHerb, Amazon) rather than for product reviews. Never push to GitHub without user approval.
---

# CPS Deal Workflow

A **deal post** covers **one retailer promotion** — e.g. "Up to 30% Off iHerb Brands". It is not a
review and not a multi-store roundup. The shape is: a short, friendly intro (Xiaohongshu tone,
a few emoji), one promo card with the code and a shop button, then a grid of 6 recommended
products. For 8-10 product comparisons use the `cps-article` skill instead.

## Site facts

- Domain `https://ibetterlife.com`, English (US), readers are US shoppers.
- Deal posts live in `content/deals/<kebab-slug>/index.md` → URL `/deals/<slug>/`. Reviews stay
  in `content/blog/` and are never touched by this workflow.
- The `/deals/` listing renders each post as a 55haitao-style row card, driven by the post's own
  front matter (`badge`, `summary`, `retailer`, `updated`, `thumb`, optional `code`).
- Author key `me`. Amazon tag `ibetterlife-20`. iHerb referral code `RZK388`.
- Components:
  - `layouts/deals/list.html` — the `/deals/` listing
  - `layouts/deals/single.html` — the post layout (left TOC + article + right sidebar)
  - `layouts/_partials/deal_card.html` — the row card markup
  - `layouts/_partials/hooks/head-start/deal-assets.html` — row-card / grid CSS + countdown,
    injected from `<head>`. Never inline this CSS in a shortcode: Hugo renders RSS first and a
    `.Scratch` dedupe flag gets consumed there, leaving the HTML page unstyled.
  - `layouts/shortcodes/deal-feed.html` — row card list inside a post (`data="<key>"`)
  - `layouts/shortcodes/deal-picks.html` — 3-column product grid (`data="<key>-picks"`)
- Graphics helpers: `.trae/skills/cps-deal/assets/` (`deal-thumb.ps1`, `deal-header.ps1`,
  `new-deal.ps1`).

## Propose the six picks before writing

When the user names a promotion, do not write the post yet. Research the sale and reply with the
**6-product shortlist only** — no article body, no promo card, no graphics.

For each pick, give the product name and size, the store price, the discounted price you calculated
and the discount assumption you used, plus one line on why it fits this promotion. Note anything
you dropped and why, such as a listing that is not part of the sale or a product already used in a
recent deal post.

Then stop and ask for approval. Apply every change the user asks for to the shortlist, and only
start scaffolding the post after the picks are confirmed.

## 0. Scaffold the post

Do not hand-copy the last post. Run the generator:

```powershell
powershell -ExecutionPolicy Bypass -File .trae/skills/cps-deal/assets/new-deal.ps1 `
  -Slug "iherb-brands-30-off" -Retailer "iHerb" -Badge "Up to 30% off" `
  -Title "iHerb Brands Is Up to 30% Off Right Now" -Code "NOV26HB" -Products 6
```

It creates, in one go:

- `content/deals/<slug>/index.md` — front matter + the standard body skeleton with `<!-- TODO -->`
  comments where the chatty intro goes
- `content/deals/<slug>/card.jpg` and `thumb-<key>.jpg` — 420x420 tiles drawn by `deal-thumb.ps1`
- `data/deals/<key>.yaml` — one promo entry, with the affiliate parameters already on the URL
- `data/deals/<key>-picks.yaml` — `<n>` placeholder product rows pointing at the generated tile,
  so the page builds without broken images while you gather the real ones

Flags: `-Key` (data file name, defaults to the slug), `-Products` (3-6, default 6), `-Summary`,
`-Headline` (card art text, defaults to the badge in caps), `-Accent` / `-Bg`, `-Tags`, `-StoreUrl`
(required for retailers other than iHerb/Amazon), `-NoImage`, `-Force`.

The scaffold is a starting point only: replace every TODO with real prices, product images and
links, then follow sections 2, 4 and 6. Keep `new-deal.ps1` ASCII-only — PowerShell 5.1 reads
scripts as ANSI and non-ASCII comments break parsing; the script already writes files as UTF-8
without BOM.

## 1. Files a deal post needs

| File | Purpose |
| --- | --- |
| `content/deals/<slug>/index.md` | Front matter card fields + short body |
| `content/deals/<slug>/card.jpg` | 420x420 tile for the `/deals/` listing (`thumb: card.jpg`) |
| `content/deals/<slug>/thumb-<name>.jpg` | 420x420 tile for the promo card in the post |
| `data/deals/<key>.yaml` | Exactly **one** promo entry (the retailer's sale) |
| `data/deals/<key>-picks.yaml` | The 6 recommended products |

## 2. Verify the promotion (do not invent numbers)

- **iHerb** blocks plain requests (403). Fetch `https://r.jina.ai/<iherb-url>` and read the
  banner copy, e.g. "Up to 30% Off iHerb Brands" plus the code `NOV26HB`.
- Product cards on that page carry lines like `30% off code: NOV26HB` and
  `<s>25% off</s>$11.41`. Copy those exactly; a bottle at 20% must not be described as 30%.
- Product images: `https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/cgn/<code>/l/<id>.jpg`.
  Use the `l/` size, never the `u/` thumbnail. Verify each returns 200 / `image/*` / >100 KB.
- Every iHerb URL gets `rcode=RZK388`; every Amazon URL gets `tag=ibetterlife-20`. Quote URLs in
  YAML when they contain `&`.
- **Product picks must link the exact product page, never a search page.** iHerb:
  `/pr/<slug>/<id>`; Amazon: `/dp/<ASIN>`. Do not ship `iherb.com/search?kw=` or
  `amazon.com/s?k=` links. A promo/category page (`/c/iherb-brands?...`) is fine for the deal card,
  but the six product tiles each need their own product URL.
- **Amazon: prefer `Sold by Amazon.com`**, then the brand's official Amazon storefront. If the exact
  discounted item is only sold by an unrelated third party, keep the iHerb link only rather than
  sending readers to a look-alike listing.
- No published end date means no countdown. Never invent a deadline.

## 3. Data files

Promo card (`data/deals/<key>.yaml`, one entry only):

```yaml
- badge: Up to 30% off
  title: Up to 30% Off iHerb Brands
  desc: One or two sentences — what is discounted and what the code does.
  code: NOV26HB
  retailer: iHerb
  updated: Nov 14
  image: /deals/<slug>/thumb-iherb-brands.jpg
  url: 'https://www.iherb.com/c/iherb-brands?soa=true&pcode=NOV26HB&rcode=RZK388'
```

Product picks (`data/deals/<key>-picks.yaml`, 6 entries, display order = grid order):

```yaml
- name: California Gold Nutrition, Omega 800, 30 Fish Gelatin Softgels (1,000 mg per Softgel)
  price: $8.56
  was: $11.41                  # optional, renders struck through
  note: 30% off with code      # optional, appended to the store line
  store: iHerb
  image: https://cloudinary.images-iherb.com/.../cgn/cgn01251/l/307.jpg
  url: 'https://www.iherb.com/pr/<slug>/<id>?rcode=RZK388'
```

## 4. Write the post

Front matter:

```yaml
---
title: "iHerb Brands Is Up to 30% Off Right Now (Code NOV26HB)"
summary: 150-160 characters; names the retailer, the sale and what to buy.
date: 2026-11-14
authors:
  - me
tags:
  - Omega-3
  - Collagen
  - Probiotics
  - Vitamin C
  - Creatine
sidebar_products: coq10
badge: Up to 30% off
retailer: iHerb
updated: Nov 14
thumb: card.jpg
code: NOV26HB
---
```

Body, in order — keep it short, 200-350 words:

1. No inline FTC disclosure line — `/affiliate-disclosure/` stays in the nav, not in the body.
2. Two or three chatty lines with a few emoji (🛒 👇 🧾 ⚠️): what is on sale, which brands are
   included, and the code in bold. Emoji are expected here; do not overdo it (max ~6).
3. `{{< deal-feed data="<key>" >}}` — the single promo card with the code chip and shop button.
4. `## 6 bottles I'd grab first 👇` — one sentence of context, then
   `{{< deal-picks data="<key>-picks" >}}`. No per-product paragraphs; the grid is the content.
5. `## How to use the code 🧾` — 3 bullets: where to shop, where to paste the code, shipping
   threshold.
6. `## Before you check out ⚠️` — "up to X%" caveat, prices change, medical disclaimer.

Rules:

- Tags: 4-5 product categories covered by the picks. Never use iHerb, Amazon, the domain,
  Deals, Coupons, Supplements or Buying Guides as a tag.
- One retailer per post. Do not mix Amazon and iHerb in one deal post.
- Use an evergreen-but-dated slug such as `iherb-brands-30-off`.
- In Chinese/Japanese text, never leave a punctuation mark on the inside edge of `**` when CJK
  characters follow immediately. Write `**优惠码**：NOV26HB` and `**クーポンコード**：NOV26HB`,
  not `**优惠码：**NOV26HB` or `**クーポンコード：**NOV26HB`. Otherwise Hugo prints the `**` literally.
- Translated deal posts keep the English `data` key in the shortcode and add localized data files
  with a language suffix (`iherb-brands-zh.yaml`, `iherb-brands-ja.yaml`); the shortcode resolves
  the suffix automatically. Bundle images in translations use absolute paths (`/deals/<slug>/...`).

## 5. Draw the squares

Listing tile and promo tile use the same generator (420x420):

```powershell
powershell -ExecutionPolicy Bypass -File .trae/skills/cps-deal/assets/deal-thumb.ps1 `
  -Brand "iHerb Brands" -Headline "UP TO 30% OFF" -Note "Code NOV26HB" `
  -Accent "#ea580c" -Bg "#FFF7ED" `
  -OutFile "content/deals/<slug>/card.jpg"
```

- Palette: orange `#ea580c` / `#f97316` for deals, red `#dc2626` for clearance, emerald for
  shipping, amber for marketplace promos.
- Keep helper scripts ASCII-only; PowerShell 5.1 mis-decodes non-ASCII scripts.
- Reference page images with page paths, e.g. `/deals/<slug>/card.jpg`.

## 6. Build, then ask before pushing

**Do not run page verification.** The user checks the rendered pages manually, so never start a
local preview server, never open the page in a browser, and never take screenshots to confirm
layout, promo cards, grids or image loading. File-level checks and the build below are enough.

1. `hugo --noBuildLock --gc --minify` — this is a compile check, not a visual review.
2. Confirm `public/deals/<slug>/index.html` contains the code, all 6 pick images and every
   `rcode=RZK388` / `tag=ibetterlife-20`; confirm `public/deals/index.html` shows the post as a
   row card.
3. Show the user what changed and **ask for approval**. Never `git commit` or `git push`
   without an explicit go-ahead.
4. After approval: commit, push to `main`, wait for the Actions run, then confirm the live URLs
   return 200.

## Tables on mobile

If a deal post uses a Markdown table, it is styled by
`layouts/_partials/hooks/head-start/article-tables.html`: below 640px the table scrolls
horizontally and the first column stays sticky at 34vw (min 6.5rem).

- First column: 1-3 words, under ~20 characters. A long first cell fills the phone screen and,
  being sticky, hides the other columns while swiping.
- Max 4 columns, longest text in the last column, plain pipe tables only.
- Check at 390px before publishing: first column under ~35% of viewport width and a right swipe
  reveals column 2.

## Compliance

- No fake countdowns, invented discounts, or "expired soon" copy.
- Say "up to X%" when that is what the banner says.
- Never add an inline affiliate disclosure line; `/affiliate-disclosure/` is linked from the nav.
- Tell readers to confirm the price at checkout; promos rotate.
- Apply the code only where the retailer says it applies — never imply it stacks with everything.
