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

## Recommended First Week

For the first week, do not actually publish automatically.

Run the pipeline to `scheduled`, inspect the results manually, and only then connect real CMS publishing.

After the system has produced several safe articles, allow autopublish only for these lanes:

- fictional product
- fictional system
- daily-life absurdity
- wordplay
- fictional manual
- AI dialogue
- reader diagnosis
