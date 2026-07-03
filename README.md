# AI Humor Media Pipeline

これは、Codexのサブエージェントを使って日本語ユーモア記事を継続制作するための運用テンプレートです。

## 追加したカスタムエージェント

プロジェクト用エージェント定義は `C:\Users\m-t20\Documents\ai-humor-media\.codex\agents` にあります。

- `article_editor_in_chief`: 企画、編集、最終判断。記事上では「風間すべり」として登場
- `article_writer_seto_mina`: 導入と読みやすさを作るライター。記事上では「瀬戸ミナ」
- `article_writer_kuga_saji`: 疑い、ツッコミ、弱い箇所の修正を担当。記事上では「久我さじ」
- `article_writer_naruse_poka`: とっぴな展開、実験、画像案を足すライター。記事上では「成瀬ポカ」
- `article_reader_qa`: 辛口読者レビュー。面白さ、読みやすさ、読者反応を見る
- `article_compliance`: 権利、広告表記、配信規約、公開リスクを見る

## DBテンプレート

`db-templates` 以下のCSVをNotion、Google Sheets、Airtableなどへ取り込んで使います。

- `ideas.csv`: 企画案と採点
- `articles.csv`: 記事制作ステータス
- `assets.csv`: 画像/図解/SNS素材
- `reader_reviews.csv`: 辛口読者による面白さ/読みやすさレビュー
- `compliance_reviews.csv`: 権利、広告表記、配信リスクレビュー
- `publishing_queue.csv`: 公開予約と編集長判断
- `performance.csv`: 公開後の反応ログ

## 基本フロー

```text
ideas
-> scored
-> briefed
-> draft1
-> draft2
-> visual_ready
-> reader_review
-> compliance_review
-> editor_gate
-> scheduled
-> published
-> analyzed
```

## 自動公開の方針

自動公開は低リスク記事だけに限定します。

自動公開しやすいもの:

- 架空商品レビュー
- 架空制度紹介
- 日常の違和感検証
- 言葉遊び
- 架空マニュアル
- AIとの会話劇
- 読者診断

自動公開しないもの:

- 実在人物、実在企業、実在商品を笑いの対象にする記事
- 政治、医療、金融、法律、災害、事件、未成年、公共安全に触れる記事
- PR、アフィリエイト、有料推薦、企業案件
- 他媒体、漫画、SNS投稿、スクショ、画像を強く参照する記事
- readerスコア80未満、reader判定がpassでない、またはコンプライアンス判定がOKでない記事

## 使い方

1. `prompts\daily_pipeline.md` のプロンプトをCodex Automationsに登録します。
2. DBテンプレートをNotion/Sheets等に取り込みます。
3. reader QA、compliance、editor gate が通った低リスク記事は `main` へ反映して公開します。
4. `human_review` または `revise` 判定の記事だけ `scheduled` / `revise` で止めます。

## 自前サイト

公開面は `site` 以下のAstro静的サイトです。

- 公開用記事: `site/src/content/articles`
- 公開用画像: `site/public/images/<slug>`
- サイト運用: `site/OPERATIONS.md`
- 自前サイト公開プロンプト: `prompts/site_publish.md`

ローカル確認:

```powershell
cd site
npm install
npm run dev
```

GitHub Pagesでは、`main` ブランチへのpushをトリガーに `.github/workflows/deploy.yml` が `site` をビルドし、`site/dist` を公開します。

公開URL:

```text
https://matsumaru-t.github.io/ai-humor-media/
```
