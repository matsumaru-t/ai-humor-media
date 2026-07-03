# Daily Pipeline Prompt

毎日 9:00 に、日本語ユーモア記事の自動制作パイプラインを実行してください。

## 手順

1. `article_editor_in_chief` を使って、低リスクな企画を選び、編集方針と記事内の役割を決める。
2. `article_writer_a` を使って、導入、基本構成、A氏の発言を作る。
3. `article_writer_b` を使って、疑問、ツッコミ、弱い箇所の修正、B氏の発言を足す。
4. `article_writer_c` を使って、とっぴな展開、実験案、画像案、C氏の発言を足す。
5. `article_editor_in_chief` を使って、編集長/A氏/B氏/C氏の議論が記事本文に自然に入るよう統合する。
6. `article_reader_qa` を使って、面白さ、読みやすさ、読者反応を100点満点で辛口レビューする。
7. `article_reader_qa` が `pass` でない場合は、具体的な修正指示を3人のライターへ戻し、最大2回まで改稿する。
8. `article_compliance` を使って、権利、広告表記、配信規約、公開リスクを確認する。
9. `article_editor_in_chief` が最終判定する。

## 自動公開条件

次の条件をすべて満たす場合のみ、CMSの下書きを公開予約してください。

- `editor_decision = autopublish`
- `reader_score >= 80`
- `reader_decision = pass`
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
- 辛口読者レビュー
- コンプライアンスレビュー
- 編集長判定
- DB更新用CSV行
- 次回への学習メモ
