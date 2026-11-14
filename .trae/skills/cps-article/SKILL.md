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
title: 'Best <Category> in <Year>: Amazon vs. iHerb Picks'
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

Keep `title` under 60 characters when possible. Never use a future date.

## 2. Depth standard

Aim for 1,800-2,500 words and 8-10 product picks. A post with fewer than 6 picks or under
1,200 words is too thin, extend it before publishing. Each pick must answer a different buyer
question: best overall, best value, one pill a day, budget, kids, seniors, highest DHA, no
fishy aftertaste, smallest pill, best seller. Do not repeat the same angle twice.

Required sections, in order:

1. Italic FTC disclosure paragraph linking to `/affiliate-disclosure/`.
2. Intro that names the buyer problem and the selection criteria.
3. `## Quick comparison` table with 4-5 rows: Pick | Where to buy | EPA + DHA per serving | Best for.
4. One `###` section per product, numbered, containing:
   - product image (see section 3)
   - 3-5 sentences on who it suits and what makes it stand out
   - 2-3 bullet strengths with real, verifiable facts
   - a spec line (combined EPA + DHA per serving, softgel count, form)
   - one affiliate CTA link
5. `## How we picked` with 4 criteria.
6. `## FAQ` with 2-3 questions.
7. Medical or safety note for supplements.

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
powershell -ExecutionPolicy Bypass -File .trae/skills/cps-article/assets/cover-template.ps1 -Title "Omega-3 Buying Guide" -Subtitle "Amazon vs. iHerb picks for 2026" -OutFile "content/blog/<slug>/featured.jpg"
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

```
[Check price on Amazon](https://www.amazon.com/dp/<ASIN>?tag=ibetterlife-20)
[Check price on Amazon](https://www.amazon.com/s?k=<urlencoded-keywords>&tag=ibetterlife-20)
[Check price on iHerb](https://www.iherb.com/pr/<product-slug>/<id>?rcode=RZK388)
[Check price on iHerb](https://www.iherb.com/search?kw=<urlencoded-keywords>&rcode=RZK388)
```

Never leave `<ASIN>`, `YOUR-TAG`, or `REPLACE` placeholders in a published post.

## 6. Product grid component

Every buying guide puts one product card at the top of each product section, directly under the
`## N.` heading. Do not dump all cards into a single grid block.

- Shortcode: `{{< product-grid data="<key>" item="N" >}}` where `N` is the 1-based row in the data file
- Data file: `data/products/<key>.yaml`
- Card fields: `name`, `badge`, `retailer`, `image`, `meta` (3 lines), `stars`, `rating`, `tip`, `note`, `url`
- `stars` is the editor score (1-5) and renders a gold star row; `rating` is optional and only
  filled with a verified store rating; `tip` is a short shopping hint such as "5 stars for kids"
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
