---
name: cps-article
description: Write Amazon and iHerb affiliate review articles for the iBetterLife Hugo site, including generated images and FTC disclosure. Use when adding or editing CPS review or buying-guide posts in this repo. Do not use for non-affiliate pages such as about or privacy.
---

# CPS Article Workflow

Produce English review / buying-guide posts for US shoppers on this HugoBlox blog.
Follow the steps in order. Do not skip the image and build checks.

## Site facts

- Domain `https://ibetterlife.com`, content language English (US).
- Posts live in `content/blog/<kebab-slug>/index.md` (page bundle, so images sit next to the file).
- Author key is `me` (iBetterLife Editorial) from `data/authors/me.yaml`.
- Amazon Associates tag `ibetterlife-20`, iHerb referral code `RZK388`.

## 1. Front matter

```yaml
---
title: 'Best <Category> in <Year>: Amazon vs. iHerb Picks'
summary: One or two sentences, 150-160 characters, states the comparison and the payoff.
date: 2026-11-14
authors:
  - me
tags:
  - Amazon
  - iHerb
  - <Category>
  - Buying Guides
---
```

Keep `title` under 60 characters where possible. Use realistic dates, never future dates.

## 2. Body structure

1. Italic FTC disclosure paragraph with a link to `/affiliate-disclosure/`.
2. Short intro naming the problem and the selection criteria.
3. `## Quick comparison` markdown table with columns Pick / Where to buy / Key spec / Best for. Do not invent exact prices.
4. Three product picks, each with 2-4 sentences of concrete detail and one CTA link.
5. `## How we picked` bullet list of the evaluation criteria.
6. `## FAQ` with 2-3 real questions.
7. Medical or safety note when the category is supplements or health.

Write specific, verifiable claims. Never fabricate lab results, certifications, or review counts.

## 3. Affiliate links

Use absolute markdown links. Amazon requires the tag on every link, iHerb requires the rcode.

```
[Check price on Amazon](https://www.amazon.com/dp/<ASIN>?tag=ibetterlife-20)
[Check price on Amazon](https://www.amazon.com/s?k=<urlencoded-keywords>&tag=ibetterlife-20)
[Check price on iHerb](https://www.iherb.com/pr/<product-slug>/<id>?rcode=RZK388)
[Check price on iHerb](https://www.iherb.com/search?kw=<urlencoded-keywords>&rcode=RZK388)
```

Use the search-link form when no specific ASIN or product URL is known. Never leave `<ASIN>` or `REPLACE` placeholders in a published post.

## 4. Images

Every post needs one featured image plus one or two inline images. Generate them, store them in the page bundle, and verify they are real photos.

- Featured: `featured.jpg`, size `landscape_16_9`. Detected automatically by the theme.
- Inline: `image-<topic>.jpg`, size `landscape_4_3`, referenced in the body as `![Alt text](image-<topic>.jpg)`.
- Prompts must be concrete, photorealistic, and must say `no text, no logos, no labels` to avoid garbled brand text.
- Confirm the file is not the placeholder the API returns while generating (that placeholder is a fixed 176626-byte image). Prefer the helper script, which handles retries and placeholder detection.

```powershell
powershell -File .trae/skills/cps-article/scripts/generate-image.ps1 -Prompt "<prompt>" -OutFile "content/blog/<slug>/featured.jpg" -Size landscape_16_9
```

If the script exits with code 2, the generator is still returning placeholders. Delete any partial images and tell the user images are pending. Never publish a post whose images are placeholders or missing.

Place inline images after the intro and before `## How we picked`, each followed by one explanatory sentence.

## 5. Verify and publish

1. Build: `hugo --noBuildLock --gc --minify`.
2. Check the new page exists in `public/blog/<slug>/index.html` and contains both affiliate parameters.
3. Preview locally with `pnpm.cmd dev` and confirm images, table, and CTA links render.
4. Commit with a short message and push to `main`; GitHub Actions deploys automatically.
5. After deployment confirm `https://ibetterlife.com/blog/<slug>/` returns 200.

## Compliance rules

- Affiliate disclosure page must stay reachable from the footer and navigation.
- No income claims, no fake urgency, no copied manufacturer copy.
- Health content stays informational and includes a "ask your doctor" line.
- Do not state live Amazon prices in static text; link out instead.
