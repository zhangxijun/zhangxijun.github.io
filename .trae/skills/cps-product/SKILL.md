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
- **Link the exact product page, never a search page.** iHerb must be `/pr/<slug>/<id>`; Amazon must
  be `/dp/<ASIN>`. Do not ship `iherb.com/search?kw=` or `amazon.com/s?k=` links.
- **Amazon: prefer `Sold by Amazon.com`**, then the brand's official Amazon storefront (an agency
  like Pattern. operating the brand store still counts). Open the dp page and read the seller line.
  If only unrelated third-party sellers carry the exact size, drop the Amazon button and keep one
  iHerb button — never keep a search link just to have two buttons.
- The product image, the card title and both buy links must describe the same product and count.
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
  # confirmed; if no Amazon listing can be verified, keep the iHerb button only.
  links:
    - store: Amazon
      url: 'https://www.amazon.com/dp/<ASIN>?tag=ibetterlife-20'
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
3. `## Why people take <nutrient>` — 1-2 short paragraphs before the verdict: what the nutrient
   does in plain language, who is most likely to be short on it, and what the label dose should be
   compared against. Skip only for non-nutrient products.
4. `## Quick verdict` — three bullets: **Best for**, **Skip if**, **What stands out**.
5. `## What you actually get` — servings, dose, form, sugar/sodium, packet count. Bullets or a
   small table; no marketing filler.
6. `## What I like` — 4-6 points, each one concrete and traceable to the label
   (dose per packet, dissolves fast, travel-friendly, no pill to swallow, price per serving).
7. `## What buyers say` — 3-5 real buyer reviews, rules below.
8. `## Where it falls short` — 2-4 honest points (sugar per packet, taste, cost per dose versus
   a tub, foil waste). A review without caveats reads like an ad.
9. `## How it compares` — a 2-3 competitor table; template and rules below.
10. `## How to use it` — the label dose, when people take it, and what to check on the box.
11. `## Who should skip it` — 2-3 lines; this is where the medical caution lives.
12. `## FAQ` — 2-3 questions pulled from the page or the label.
13. `## Bottom line` — 2-3 sentences repeating the verdict, then one affiliate link.

### Real buyer reviews (`What buyers say`)

- **3-5 quotes**, each a short blockquote plus the attribution, so the reader sees how the product
  behaves after weeks of use rather than only what the label claims.
- **Copy from the live product page.** iHerb reviews are public — fetch the page through
  `https://r.jina.ai/<iherb-url>` and read the review block. Amazon reviews need a login and the
  `dp` page normally shows none, so never present Amazon quotes you could not actually open.
- **Attribute what the page shows:** reviewer name when printed, otherwise "iHerb verified buyer",
  plus the month and year printed on the review.
- **Include at least one critical quote** (taste, sweetness, price per serving, packaging). A
  review page with only five-star praise reads like an ad and hurts trust.
- **Never invent, merge or clean up a quote.** No fabricated dates, no "paraphrased" quotes, no
  quotes borrowed from a similar product. Do not translate a quote into something warmer than the
  original on `/zh/`, `/ja/`, `/ko/` pages — keep the complaint intact.
- If the page shows too few readable reviews, say so in the change summary and use fewer quotes
  instead of filling the gap.
- Keep quotes short (roughly under 30 English words each) so the section stays scannable.

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
- In Chinese/Japanese text, never leave a punctuation mark on the inside edge of `**` when CJK
  characters follow immediately. Write `**适合的人**：经常旅行的人` and `**向いている人**：旅行が多い人`,
  not `**适合的人：**经常旅行的人` or `**向いている人：**旅行が多い人`. Otherwise Hugo prints `**` literally.
- In translation files (`index.zh.md`, `index.ja.md`), reference bundle images with the absolute
  default-language path (`/blog/<slug>/<image>.jpg`); relative names 404 on `/zh/` and `/ja/`.

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

## 7. Build, then ask before pushing

**Do not run page verification.** The user checks the rendered pages manually, so never start a
local preview server, never open the page in a browser, and never take screenshots to confirm
layout, tables, images or CTA styling. File-level checks and the build below are enough.

1. `hugo --noBuildLock --gc --minify` — zero errors. This is a compile check, not a visual review.
2. Check `public/blog/<slug>/index.html` contains the card and the affiliate parameter
   (`rcode=RZK388` or `tag=ibetterlife-20`).
3. Show the user the title, the verdict and the price you used. **Ask for approval.**
   Never `git commit` or `git push` without an explicit go-ahead.
4. After approval: commit, push to `main`, wait for the Actions run, then confirm the live URL
   returns 200.

## Tables on mobile

Tables are styled by `layouts/_partials/hooks/head-start/article-tables.html`: below 640px each
table becomes a horizontal scroller with the first column sticky at 34vw (min 6.5rem).

- First column must be short — 1-3 words, under ~20 characters. In the comparison table put
  "This product" / "Competitor" / "Label dose", never a full product title. A long first cell
  occupies the whole screen and, since it is sticky, hides the remaining columns while swiping.
- Max 4 columns, longest text in the last column, plain pipe tables only.
- Check at 390px before publishing: first column under ~35% of viewport width and a right swipe
  reveals column 2 with column 1 staying pinned.

## Editorial voice: no AI voice

A single-product review only works if it sounds like one person who bought the bottle, used it,
and noticed the small annoyances. Remove anything that reads like generated copy.

Banned English phrases:

- "game-changer", "must-have", "little powerhouse", "hidden gem", "holy grail", "supercharge",
  "unlock", "elevate", "delve into", "the perfect blend of", "a testament to"
- "In today's fast-paced world", "When it comes to", "Whether you're ...", "Look no further",
  "We've got you covered", "Let's dive in", "Say goodbye to <problem>"
- "It's important to note", "It is worth mentioning", "Bottom line:" used as a section opener,
  "In conclusion", "All things considered"
- "Our team of experts", "we tested this for months" — never claim hands-on testing the site did
  not do. Say "the label shows", "buyers report", "the price works out to"
- Exclamation marks, emoji, three adjectives stacked in a row, and bolded one-line takeaways after
  every paragraph

Write instead: "One packet carries 1,000 mg of vitamin C and 6 g of sugar, so it is closer to a
soft drink than a capsule." Concrete dose, real trade-off, no adjectives doing the arguing.

Keep at least one sentence per section that only fits this exact product. If a sentence could sit
in any supplement review, cut it.

Chinese: 禁用「堪称神器」「闭眼入」「宝藏好物」「YYDS」「在这个快节奏的时代」「值得一提的是」
「无论你是……还是……」「总而言之」「一站式」「全面解析」「赋能」「解锁」，以及感叹号堆叠。

Japanese: 禁用「神アイテム」「買って損なし」「〜ではないでしょうか」「〜と言えるでしょう」
「さあ、見ていきましょう」「ぜひチェックしてみてください」「〜を徹底解説」。

Korean: 禁用「갓템」「무조건 사세요」「~해 보시는 건 어떨까요?」「지금부터 알아보겠습니다」「~라고 할 수 있습니다」「놓치지 마세요」「꼭 확인해 보세요」。

Before publishing, grep the draft for the banned list and confirm the intro names a real number
(dose, price per serving, count) in the first two sentences.

### Do not prove your own honesty

Never explain how carefully the listing, seller or size was checked. Lines like "rather than
copying a search result", "no button points to a look-alike bottle", or "we verified the seller,
formula and size" read as AI self-defence, not as a review. State what the label says and what the
price works out to. Mention sourcing only when it changes the decision ("the iHerb listing is a
different 130-tablet product, so this one is Amazon-only"), and put it in that product's own
section rather than a preamble.

## Compliance

- Prices and review counts are dated and sourced from the retailer page; promos rotate.
- Say "as of <date>" whenever a number can change.
- Supplements are not medicine: keep the safety line and tell readers to check with a clinician,
  especially with pregnancy, medication or a diagnosed condition.
- One product per post — no hidden roundups, no fake scarcity.
