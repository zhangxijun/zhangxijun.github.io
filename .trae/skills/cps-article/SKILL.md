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

## Propose the picks before writing

When the user gives a topic, do not write the post. Research first, then reply with the
**10-product shortlist only** — no article body, no graphics, no data files, no translations.

For each pick, give one compact line or table row with:

- the position and the angle it fills (best overall, best value, best two-tablet, best liquid,
  best collagen, best plant calcium, ...)
- brand, product name and size
- store, current price and cost per serving
- the dose facts that decide the pick (glucosamine and chondroitin mg, collagen g, calcium mg
  with D3, etc.)
- star rating and review count
- which retailers have a verified listing for that exact size

Add a short list of what you left out and why — a second size from the same house brand, a product
only sold by an unverified third-party seller, a pick that repeats an angle already covered.

Then stop and ask for approval. Wait for the user's confirmation, and fold every edit they ask for
into the shortlist before drafting. Only after the list is approved do you start at step 1 and
create `index.md`, the product YAML, the graphics and the translations.

A single-product review skips this step, because the user already named the product.

## 1. Front matter

```yaml
---
title: 'The <N> Best <Category> of <Year>, Ranked by <Dimension A> and <Dimension B>'
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

Title rules (current standard — use this pattern for every new list post):

- Use the number-first formula:
  `The <N> Best <Category> of <Year>, Ranked by <Dimension A> and <Dimension B>`
  e.g. `The 10 Best Multivitamins of 2026, Ranked by Value and Real Reviews`,
  `The 10 Best CoQ10 Supplements of 2026, Ranked by Dose and Cost`.
- Leading with "The 10 Best" beats "Best <Category> in <Year>:" because the number and the word
  "Best" both survive mobile truncation, and the comma keeps the category phrase intact for
  search matching. Keep the head keyword ("Multivitamins", "CoQ10 Supplements") right after the
  number and never bury it at the end.
- Name the two dimensions that actually decided the ranking, using the buyer's words: Value +
  Reviews, Dose + Cost, EPA + DHA, Potency + Price. Two concrete dimensions beat one vague one,
  and never end with "Amazon vs. iHerb Picks" — retailers belong in the body and tags.
- Length: 60-70 characters. The pattern above lands around 65-67; if a category name is long,
  trim the year wording or drop to one dimension rather than letting Google cut the ending.
- Never use a future date, and never add a trailing brand or site name — the theme appends it.

## 2. Depth standard

Aim for 2,000-2,800 words and 8-10 product picks. A post with fewer than 6 picks or under
1,200 words is too thin, extend it before publishing. Each pick must answer a different buyer
question: best overall, best value, one pill a day, budget, kids, seniors, highest DHA, no
fishy aftertaste, smallest pill, best seller. Do not repeat the same angle twice.

Selection criteria must cover, where the data allows: **sales heat** (review counts as the only
public proxy), **star rating**, **who it suits**, and **price per serving**. Say which criteria you
used, but in a blogger's voice: one short line in the intro and 3-4 plain bullets in
`## How we picked`. Never turn that section into a methods audit — see the editorial voice rules
below.

For bone, joint and other supplement lists, cross-check the shortlist against the relevant
**Amazon US Best Sellers** category before finalizing the picks. For joint articles use
`Bone & Joint Supplements` and/or `Chondroitin & Glucosamine Combination Nutritional
Supplements`; for other topics use the closest matching Amazon category. Use the ranking to spot
mainstream sellers that an iHerb-only search would miss, then verify each product's live link,
seller, dose, price and image independently. If the Amazon page is unreachable, say so and use a
verified bestseller from the retailer's own ranking instead; never invent an Amazon rank.

**iHerb house brands are limited to one pick each per article.** California Gold Nutrition and
21st Century may each appear at most once, and the rest of the list must be filled with distinct
mainstream brands. Do not use several sizes or formulas from the same house brand to fill the
list. A category-leading product can stay as that brand's single pick; drop the other sizes or
related blends even when their review counts are high. For joint guides, always evaluate Schiff
Move Free for inclusion, and consider New Chapter Bone Strength Take Care for the bone-health
slot, before falling back to a house-brand alternative.

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
   - **one hard-numbers line first** — servings · key dose · cost per serving, before any prose, so
     a reader can decide in three seconds whether this bottle is in their budget
   - 4-8 sentences on who it suits and what makes it stand out
   - **Strengths** — 2-3 bullets with real, verifiable facts
   - **Weaknesses** — 1-2 honest limits, specific to this bottle (small review sample, 4.4-star
     average, two capsules per serving, needs refrigeration, highest cost per day). Never write a
     fake weakness such as "the only downside is it sells out"
   - **What buyers say** — 2-3 real buyer reviews (see the rules below)
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

### Moves borrowed from working affiliate desks

These come from reading OutdoorGearLab, BarBend and mindbodygreen list posts, not from copying
their words. Apply the structure, keep our own voice.

- **Award-first headings.** `## 3. Best for IBS: Align Probiotic 24/7` lets a reader scanning the
  table of contents find their case without opening the section. A bare `## 3. Align` wastes that
  line.
- **Numbers before narrative.** BarBend puts a Specs block at the top of every pick; GearLab leads
  each award with the one measurement that decided it. Do the same with servings, dose and cost per
  serving.
- **A visible cons block.** mindbodygreen's Pros/Cons pairs are the most-scanned part of the page.
  Every pick needs a **Weaknesses** block worth reading, not a humility gesture.
- **The comparison table is navigation.** After it, add 2-3 sentences in the form "if you only care
  about X, jump to pick N". GearLab ends its table with a short "What's the Best Value?" note for
  the same reason.
- **One cost sentence per pick.** Multiply the serving cost by 30 and say it out loud: a
  three-month trial at 96 cents a day is \$86. Readers budget in months, not in servings.
- **Selection comes before shopping advice.** All three sites explain how to choose after the picks
  and before the FAQ, using situations rather than spec recitals. Add 3-6 sentences of that, then
  stop.
- **Trust lives in one place.** GearLab keeps it in a single "How We Tested" section, Wirecutter in
  "Why you should trust us". Ours is `## How we picked`; do not scatter credibility lines through
  the product sections.

**Do not imitate testing we did not do.** OutdoorGearLab buys and abuses every product; we compare
labels, prices and published buyer reviews. Never write "we tested", "after three months of use",
or a first-person reaction to a product nobody on the site has opened. If a claim needs hands-on
experience to be true, drop the claim instead of inventing the experience.

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

## 7. Build, then ask before pushing

**Do not run page verification.** The user checks the rendered pages manually, so never start a
local preview server, never open the page in a browser, and never take screenshots to confirm
layout, tables, images or CTA styling. File-level checks and the build below are enough.

1. Build: `hugo --noBuildLock --gc --minify` — this is a compile check for Markdown and shortcode
   errors, not a visual review.
2. Confirm the new page exists in `public/blog/<slug>/index.html` and contains both affiliate
   parameters.
3. Stop here. Show the user what changed and ask for approval. Do not run `git commit` or
   `git push` until the user explicitly confirms.
4. Only after approval: commit, push to `main`, wait for the Actions run to finish, then confirm
   `https://ibetterlife.com/blog/<slug>/` returns 200.

## Editorial voice: no AI voice

Write like a picky shopper who has read every label, not like a content generator. If a sentence
could open any supplement article on the internet, delete it and replace it with a fact from the
label, the review page or the price tag.

Banned English openings and phrases (rewrite, do not just reword slightly):

- "In today's fast-paced world", "When it comes to <category>", "Whether you're a busy mom or a
  gym rat", "Let's dive in", "Look no further", "We've got you covered"
- "delve into", "unlock", "elevate", "game-changer", "revolutionize", "a testament to",
  "navigate the landscape", "the perfect blend of", "not just X, but Y"
- "It's important to note", "It is worth mentioning", "In conclusion", "Overall,"
- "Our team of experts", "we compiled this guide" — the site has one editorial voice, so do not
  invent a research department
- Emoji, exclamation marks, and "Say goodbye to <problem>" constructions

Also avoid the structural tells: every paragraph the same length, every section opening with a
one-line fragment, three adjectives in a row, and a bolded takeaway after each paragraph. Vary
sentence length, let one paragraph be two sentences and the next be six.

Write instead: "6 cents a serving is the lowest here, and the 300-count bottle lasts ten months."
State the number, name the trade-off, and let the buyer draw the conclusion. Keep one honest
opinion per section — a review with no friction reads fake.

Chinese: 禁用「在这个快节奏的时代」「值得一提的是」「总而言之」「无论你是……还是……」
「不仅……而且……」（滥用）「让我们一起来看看」「赋能」「解锁」「极致」「一站式」「全面解析」
以及机械的「首先/其次/最后」三段式。用具体数字和真实体验代替形容词。

Japanese: 禁用「〜ではないでしょうか」「〜と言えるでしょう」「いかがでしょうか」
「さあ、見ていきましょう」「〜することが重要です」「〜を徹底解説」
「ぜひチェックしてみてください」。数字と実体験で書き、形容詞で埋めない。

Korean: 禁用「~해 보시는 건 어떨까요?」「지금부터 알아보겠습니다」「~라고 할 수 있습니다」
「~를 소개해 드리겠습니다」「놓치지 마세요」「꼭 확인해 보세요」。
구체적인 숫자와 실제 후기로 쓰고, 형용사로 채우지 않는다.

Before publishing, scan the draft for the phrases above (`grep` the banned list) and check that the
first paragraph contains at least one number or one concrete product fact.

### Do not prove your own honesty

Lines that explain how carefully you checked something read exactly like an AI defending its
homework. Delete them:

- "rather than copying a search result"
- "each card pairs one verified listing with the size and formula it shows, so no button points to
  a look-alike bottle"
- "we verified the seller, formula, size, dose, price and image on each product page"
- "sellers, ranks, ratings and prices were checked November 15, 2026 and can change" as a
  paragraph under a table

A reviewer states the finding and the number. Sourcing detail earns its place only when it changes
the buying decision: "the iHerb listing is a different 130-tablet product, so this pick is
Amazon-only" belongs in that product's section, not in a preamble. If a process sentence does not
help the reader choose, cut it. One short footnote is enough when a table number would otherwise
mislead — not a paragraph about how the numbers were gathered.

Open with the buyer's problem and a concrete fact, the way a good blogger does: the number printed
on every bottle, the dose that differs, the price gap. Never open with the method.

## Tables on mobile

A site-wide CSS hook (`layouts/_partials/hooks/head-start/article-tables.html`) turns every
Markdown table into a horizontal scroller below 640px, pins the first column to the left edge and
caps it at 34vw / min 6.5rem. Write tables with that in mind:

- Keep first-column labels short: 1-3 words, under ~20 characters ("Centrum Adults", not
  "Centrum Adults Multivitamin 200 Tablets"). A long first cell fills the whole phone screen, and
  because that column is sticky it covers columns 2-4 while the reader swipes — the table looks
  frozen even though it scrolls.
- Use at most 4 columns; put the longest text in the last column.
- Plain pipe tables only — no HTML tables, no inline `white-space` styles.
- Verify at 390px width before publishing: first column under ~35% of the viewport, `scrollWidth >
  clientWidth`, and swiping right reveals column 2 while column 1 stays pinned.

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
