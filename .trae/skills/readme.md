目前这个仓库里有 2 个项目级 skill （放在`.trae/skills/` 下，只对本项目生效）。

## 1. cps-article —— 测评 / 购买指南
管什么 ：`/blog/` 下的产品测评文章，一篇横向对比 8-10 款产品。

产出 ：

- `content/blog/<slug>/index.md` + 封面图`featured.jpg` 、列表缩略图
- `data/products/<key>.yaml` ：每款产品的图片、评分、规格、联盟链接
- 可选：加进首页轮播`data/sliders/home.yaml`

你这样说就能触发 ：

 写一篇关于镁片的测评，覆盖 10 款不同定位的产品

内置规则 ：Amazon 链接带`tag=ibetterlife-20` 、iHerb 带`rcode=RZK388` ；4-5 个标签（产品分类优先、再品牌，禁止用 Amazon/iHerb/域名/Buying Guides）；商品图必须是真实可访问的图；推送前必须先经你确认。配图脚本：`cover-template.ps1` （生成封面）。

## 2. cps-deal —— 单商家促销
管什么 ：`/deals/` 下的促销文章，一篇只讲 一个商家的一次促销 ，正文推荐 3-6 款商品。

产出 ：

- `content/deals/<slug>/index.md` +`card.jpg` 、`thumb-xxx.jpg`
- `data/deals/<key>.yaml` ：一条促销（折扣标签、优惠码、链接、更新时间）
- `data/deals/<key>-picks.yaml` ：3-6 款推荐商品（用码价 + 现价划线）
一键搭骨架 （这次新加的）：

生成后只剩两类 TODO：正文那段带 emoji 的口语化介绍、以及真实商品的价格/图/链接。

你这样说就能触发 ：

新建一篇 iHerb 促销，最高 7 折，码 ABC123，推荐 6 款