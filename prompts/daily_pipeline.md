# Daily Pipeline Prompt

毎日 9:00 に、日本語ユーモア記事の自動制作パイプラインを実行してください。

## 手順

1. `article_planner` を使って、低リスクな企画を30本出す。
2. 25点以上の企画から、自動公開レーンに入るものだけ選ぶ。
3. `article_writer` を使って、1本を8000〜12000字程度の記事にする。短文、多めの改行、やさしい言葉を優先する。
4. `article_visual_director` を使って、画像パッケージを作る。
5. `air_reader_qa` を使って、100点満点レビューをする。
6. `humor_tough_reader` を使って、面白さと読みやすさを辛口レビューする。
7. `humor_tough_reader` が `pass` でない場合は、具体的な修正指示を `article_writer` に戻し、最大2回まで改稿する。
8. `article_distribution_compliance` を使って、公開可否を確認する。
9. `article_editor_in_chief` が最終判定する。

## 自動公開条件

次の条件をすべて満たす場合のみ、CMSの下書きを公開予約してください。

- `editor_decision = autopublish`
- `qa_score >= 80`
- `humor_score >= 80`
- `humor_tough_reader_decision = pass`
- `compliance_status = OK`
- `final_risk_level = low`
- `asset_rights_all_checked = true`
- 実在人物、実在企業、時事、医療、法律、金融、政治、災害、事件、未成年、PR、アフィリエイトを扱っていない
- 架空設定やAI生成要素が必要に応じて明示されている

条件を満たさない場合は公開せず、`Articles` DB の `status` を `human_review`、`revise`、または `rejected` にしてください。

危ない記事を出すくらいなら、その日は公開しないでください。

## 出力

- 今日生成した企画一覧
- 採用した企画
- 記事本文
- 画像パッケージ
- QAレビュー
- 辛口読者レビュー
- コンプライアンス判定
- 編集長判定
- DB更新用CSV行
- 次回への学習メモ
