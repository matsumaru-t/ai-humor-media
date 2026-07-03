# Workflow

## Daily Run

```text
article_editor_in_chief
-> article_writer_seto_mina
-> article_writer_kuga_saji
-> article_writer_naruse_poka
-> article_reader_qa
-> article_compliance
-> article_editor_in_chief
```

## Reader QA Emphasis

The reader QA agent should review whether the article is enjoyable as a web article, not only whether the prose is clear.

Current reader priorities:

- Too much地の文 should be flagged. Prefer conversation-led scenes when the writer characters are present.
- Ask for more photo-like inserts: prop shots, reaction shots, before/after shots, process shots, and comparison shots.
- Captions should add a small joke or extra observation, not only describe the image.
- Strong lines should usually use restrained editorial emphasis: compact pull quotes, dry subheads, small labels, or sharp captions. Avoid giant colorful reaction text, black-bar shouting, and repeated `!` unless there is a specific reason.
- Use overseas humor media as broad reference for dryness and restraint, e.g. McSweeney's essay-like oddness, ClickHole's headline discipline, Reductress-style satirical framing, or satirical news pages. Do not clone any site's format.
- Use external humor articles only as broad inspiration for pacing; do not copy a specific site's format, catchphrases, image rhythm, or layout.

## Status Values

Use these values consistently in the DB.

```text
backlog
scored
briefed
draft1
draft2
visual_ready
reader_review
compliance_review
editor_gate
revise
human_review
scheduled
published
analyzed
rejected
```

## Editor Gate

The editor-in-chief agent can choose:

```text
autopublish
revise
human_review
reject
```

`autopublish` is allowed only for low-risk fictional or daily-life articles that pass reader review and compliance review.

It requires `article_reader_qa` to return `reader_decision = pass` with `reader_score >= 80`, and `article_compliance` to return `compliance_status = OK`.

## Publish Lanes

Low-risk articles may be published when reader QA, compliance, and the editor gate pass.

Autopublish or direct publish is allowed only for these lanes:

- fictional product
- fictional system
- daily-life absurdity
- wordplay
- fictional manual
- AI dialogue
- reader diagnosis
