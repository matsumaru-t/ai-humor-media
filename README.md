# AI Humor Media Pipeline

これは、Codexのサブエージェントを使って日本語ユーモア記事を継続制作するための運用テンプレートです。

## 追加したカスタムエージェント

プロジェクト用エージェント定義は `C:\Users\m-t20\Documents\ai-humor-media\.codex\agents` にあります。

- `article_planner`: 企画生成と採点
- `article_writer`: 本文/台本制作
- `article_visual_director`: 画像生成指示とビジュアル設計
- `air_reader_qa`: エア読者QAと炎上/権利リスク確認
- `article_distribution_compliance`: 配信、収益化、広告表記、規約確認
- `article_editor_in_chief`: 自動公開可否の最終判断

## DBテンプレート

`db-templates` 以下のCSVをNotion、Google Sheets、Airtableなどへ取り込んで使います。

- `ideas.csv`: 企画案と採点
- `articles.csv`: 記事制作ステータス
- `assets.csv`: 画像/図解/SNS素材
- `qa_reviews.csv`: 公開前QA
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
-> qa_review
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
- QAスコア80未満、またはコンプライアンス判定がOKでない記事

## 使い方

1. `prompts\daily_pipeline.md` のプロンプトをCodex Automationsに登録します。
2. DBテンプレートをNotion/Sheets等に取り込みます。
3. 最初の1週間は自動公開せず、`scheduled` までで止めて品質を確認します。
4. 問題ない型だけ `article_editor_in_chief` の `autopublish` 判定を許可します。

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
