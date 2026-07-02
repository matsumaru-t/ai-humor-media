# Site Publish Prompt

AI Humor Media の記事を自前サイトへ公開する準備をしてください。

## 入力

- 対象 `article_id`
- 最終稿本文
- 画像パッケージ
- QAレビュー
- コンプライアンス判定
- 編集長判定

## 公開条件

次をすべて満たす場合だけ、`site/` 配下へ公開用ファイルを作成してください。

- `editor_decision = autopublish` または人間が明示的に公開承認済み
- `qa_score >= 80`
- `compliance_status = OK`
- `final_risk_level = low`
- `asset_rights_all_checked = true`
- 実在人物、実在企業、実在商品、時事、医療、法律、金融、政治、災害、事件、未成年、PR、アフィリエイトを扱っていない
- 画像に実在ロゴ、実在人物、商標、ニュース写真風、既存媒体風の誤認がない

## 手順

1. 公開用slugを確定する。
2. 画像を `site/public/images/<slug>/` に保存する。
3. 公開用Markdownを `site/src/content/articles/<slug>.md` に作成する。
4. frontmatterに以下を入れる。
   - `title`
   - `slug`
   - `description`
   - `publishDate`
   - `category`
   - `tags`
   - `eyecatch`
   - `eyecatchAlt`
   - `draft: false`
5. 本文から制作メモ、QAメモ、内部判定、露骨なメタ説明を外す。
6. `site` で `npm run build` を実行する。
7. `db-templates/articles.csv` と `db-templates/publishing_queue.csv` の更新用CSV行を出す。

## 出力

- 作成した記事Markdownパス
- 作成/参照した画像パス
- build結果
- 公開後URL予定
- DB更新用CSV行
- 公開前の人間確認ポイント
