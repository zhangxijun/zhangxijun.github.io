---
name: cps-product
description: Write single-product deep-dive reviews for the iBetterLife /blog/ (Reviews) section — one product, its specs, strengths and honest caveats. Use when the user hands you one product URL or name to review. Not for multi-product comparisons (cps-article) or store promotions (cps-deal). Never push to GitHub without user approval.
---

# CPS Single-Product Review Workflow

One product, one post, published under `/blog/<slug>/` alongside the buying guides. The job is
to answer "is this specific bottle worth buying?" — not to rank ten of them.

| | cps-article | cps-product | cps-deal |
| --- | --- | --- | --- |
| Topic | 8-10 products compared | **one product in depth** | one store promo |
| Length | 1,800-2,500 words | **900-1,500 words** | 300-500 words |
| Reader question | "which one should I buy?" | **"is this one any good?"** | "what is on sale now?" |

## Site facts

- Domain `https://ibetterlife.com`, English (US), readers are US shoppers.
- Post lives in `content/blog/<slug>/index.md` (page bundle, images next to the file).
- Author key `me`. Amazon tag `ibetterlife-20`. iHerb referral code `RZK388`.
- Brand palette: emerald `#059669`, deep green `#064E3B`, mint `#ECFDF5`.
- Reuse the existing single card component: `{{< product-grid data="<key>" item="1" >}}`
  (reads `data/products/<key>.yaml`, renders image + stars + specs + affiliate button).

## 1. Confirm the product and the angle

The user usually supplies a URL. Before writing, decide the one question the post answers, e.g.
"Does 1,000 mg of Emergen-C actually cover a day?" Two products with the same category still get
different angles; never reuse the previous post's outline verbatim.

If the user gives several products to compare, use `cps-article` instead. If they want a sale
post, use `cps-deal`.

## 2. Verify everything on the label (no invented claims)

- **iHerb** blocks plain requests (403). Fetch `https://r.jina.ai/<iherb-url>` and read the page.
- Copy from the listing, not from memory: serving size, active ingredient and form (e.g.
  ascorbic acid vs. sodium ascorbate), mg per serving, packet/capsule count, sugar and sodium per
  serving, certifications the brand actually prints.
- Ratings, review counts and prices: only if the page shows them, and date-stamp them
  ("as of Nov 14, 2026"). If a number is not visible, leave it out.
- Product image: use the `l/` size on `cloudinary.images-iherb.com`, never the `u/` thumbnail;
  confirm it returns 200 with an `image/*` content type and is over 100 KB. If it fails, draw a
  design card instead.
- Every iHerb URL carries `rcode=RZK388`; every Amazon URL carries `tag=ibetterlife-20`.
  Quote URLs in YAML when they contain `&`.
- Health language stays descriptive: "provides", "is marketed for", "some people use it for".
  Never "cures", "treats" or "replaces a doctor".

## 3. Files a product review needs

| File | Purpose |
| --- | --- |
| `content/blog/<slug>/index.md` | The article |
| `content/blog/<slug>/featured.jpg` | 1600x900 cover |
| `content/blog/<slug>/image-<topic>.jpg` | 1-2 inline graphics (spec cards) |
| `data/products/<key>.yaml` | One product entry for the single card |

`<key>` is short and stable, e.g. `emergen-c-super-orange`. Do not reuse the key of an existing
buying guide — that file holds 8-10 products.

```yaml
- name: Emergen-C, Vitamin C, Super Orange, 1,000 mg, 30 Packets, 0.32 oz (9.1 g) Each
  badge: 1,000 mg + B vitamins    # the product's single biggest selling point, not "review"
  retailer: iHerb
  image: https://cloudinary.images-iherb.com/.../l/xxx.jpg
  stars: 4                 # editor score only if you actually justify it in the text
  meta:
    - 1,000 mg vitamin C per packet
    - 30 packets per box
    - ~$0.60 per serving
  tip: "One line on who this suits."
  note: One line on the catch, e.g. "6 g of sugar per packet."
  url: 'https://www.iherb.com/pr/.../18057?rcode=RZK388'
  # Two buy buttons with store icons. Use a direct /dp/<ASIN> Amazon link once it is
  # confirmed; a tagged Amazon search URL is acceptable until then.
  links:
    - store: Amazon
      url: 'https://www.amazon.com/s?k=<product+query>&tag=ibetterlife-20'
    - store: iHerb
      url: 'https://www.iherb.com/pr/.../18057?rcode=RZK388'
```

## 4. Front matter and title

```yaml
---
title: 'Emergen-C Vitamin C Review: Worth 1,000 mg a Day? (2026)'
summary: 150-160 characters. Name the product, the deliverable and the verdict.
date: 2026-11-14
authors:
  - me
tags:
  - Vitamin C
  - Emergen-C
  - Immune Support
  - Powder Packets
sidebar_products: omega-3
---
```

Title rules:

- Head keyword first: `<Product> Review`, e.g. `Emergen-C Vitamin C Review`. That phrase is what
  people search; keep the brand name exactly as the label prints it.
- Then a real hook — the question a buyer actually has (`Worth 1,000 mg a Day?`,
  `Does It Beat a Capsule?`), then the year in brackets.
- 60-65 characters total so Google does not truncate it.
- Never use a future date.

Tags: 4-5, product category first (Vitamin C), then brand (Emergen-C), then adjacent categories
or form (Immune Support, Powder Packets). Never tag iHerb, Amazon, the domain, "Reviews",
"Supplements" or "Buying Guides".

## 5. Body skeleton (900-1,500 words, in this order)

1. **Intro** — 2-3 short paragraphs: what the product is, who it is for, and the one thing that
   makes it different from a plain vitamin C tablet.
2. **The card** — `{{< product-grid data="<key>" item="1" >}}` right after the intro, so the
   price, image and shop button are above the fold.
3. `## Quick verdict` — three bullets: **Best for**, **Skip if**, **What stands out**.
4. `## What you actually get` — servings, dose, form, sugar/sodium, packet count. Bullets or a
   small table; no marketing filler.
5. `## What I like` — 4-6 points, each one concrete and traceable to the label
   (dose per packet, dissolves fast, travel-friendly, no pill to swallow, price per serving).
6. `## Where it falls short` — 2-4 honest points (sugar per packet, taste, cost per dose versus
   a tub, foil waste). A review without caveats reads like an ad.
7. `## How it compares` — a 2-3 competitor table; template and rules below.
8. `## How to use it` — the label dose, when people take it, and what to check on the box.
9. `## Who should skip it` — 2-3 lines; this is where the medical caution lives.
10. `## FAQ` — 2-3 questions pulled from the page or the label.
11. `## Bottom line` — 2-3 sentences repeating the verdict, then one affiliate link.

### Comparison table template

```markdown
## How it compares

Two sentences: what this product wins at, and the exact case where a rival is the smarter buy
(prices checked Nov 14, 2026).

| Spec | Emergen-C Super Orange | <Competitor A> | <Competitor B> |
| --- | --- | --- | --- |
| Price per serving | ~$0.60 | ~$0.18 | ~$0.31 |
| Vitamin C per serving | 1,000 mg | 1,000 mg | 500 mg |
| Form | Powder packet | Tablet | Capsule |
| Sugar per serving | 6 g | 0 g | 0 g |
| Best for | Travel and taste | Everyday budget | People who skip pills |

Want the full rankings? See our [vitamin C buying guide](/blog/best-vitamin-c-supplements/).
```

Rules for this section:

- **2-3 competitors, no more.** A four-column table stops fitting on mobile and turns into a
  roundup, which is `cps-article`'s job.
- **Compare facts, not adjectives.** Rows are label numbers (dose, form, sugar, servings per
  container, price per serving). Keep 4-5 rows; drop rows where the products are identical.
- **Verify the competitors the same way as the main product.** Label and price from the retailer
  page (iHerb via `https://r.jina.ai/<url>`); if a number cannot be confirmed, drop that
  competitor instead of guessing.
- **The reviewed product must not win every row.** Say plainly where a rival is cheaper, cleaner
  or easier, otherwise the table reads like an ad.
- **One row per competitor, no paragraphs.** Details belong in the linked buying guide.
- Competitor links carry the affiliate parameters (`rcode=RZK388` / `tag=ibetterlife-20`). Link
  to the matching buying guide when one exists; otherwise link straight to the product page.
- No verified competitors? Omit the whole section rather than inventing one.

Article rules:

- One product only. Alternatives appear only inside the comparison table, never as their own
  reviewed sections.
- Images inside the text: one or two spec cards, not a photo dump.
- No inline FTC disclosure line by default — the site keeps `/affiliate-disclosure/` in the nav.
  (Deal posts dropped the inline line at the user's request.) Ask before adding one back.
- Never invent awards, certifications, review counts or "Amazon's Choice" style badges.
- Markdown tables in `/blog/` posts are styled automatically (rounded border, mint header,
  zebra rows) by `layouts/_partials/hooks/head-start/article-tables.html`. Do not add inline
  table CSS or HTML tables.
- Escape every dollar sign with a backslash (`\$15.43`). Two unescaped `$` in one paragraph make
  Hugo read the text between them as inline math, which silently turns `**bold**`, `_italic_`
  and links inside that span into plain text. Safest habit: always write `\$` for prices.

## 6. Draw the graphics

Cover (1600x900), reusing the article skill's generator:

```powershell
powershell -ExecutionPolicy Bypass -File .trae/skills/cps-article/assets/cover-template.ps1 `
  -Title "Emergen-C Vitamin C Review" -Subtitle "1,000 mg per packet, tested on the road" `
  -OutFile "content/blog/<slug>/featured.jpg"
```

- Inline graphic: one spec card listing the label facts (dose, packets, sugar, price per serving).
- Keep helper scripts ASCII-only; PowerShell 5.1 mis-decodes non-ASCII script text.
- Never ship a guessed image URL. Check every URL returns 200 / `image/*` before committing.

## 7. Verify, then ask before pushing

1. `hugo --noBuildLock --gc --minify` — zero errors.
2. Check `public/blog/<slug>/index.html` contains the card, the affiliate parameter
   (`rcode=RZK388` or `tag=ibetterlife-20`) and every image.
3. Open `http://localhost:1313/blog/<slug>/`: card renders, no broken image, left TOC and right
   sidebar present.
4. Show the user the title, the verdict and the price you used. **Ask for approval.**
   Never `git commit` or `git push` without an explicit go-ahead.
5. After approval: commit, push to `main`, wait for the Actions run, then confirm the live URL
   returns 200.

## Compliance

- Prices and review counts are dated and sourced from the retailer page; promos rotate.
- Say "as of <date>" whenever a number can change.
- Supplements are not medicine: keep the safety line and tell readers to check with a clinician,
  especially with pregnancy, medication or a diagnosed condition.
- One product per post — no hidden roundups, no fake scarcity.
