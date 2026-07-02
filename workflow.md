# Workflow

## Daily Run

```text
article_planner
-> article_writer
-> article_visual_director
-> air_reader_qa
-> article_distribution_compliance
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
qa_review
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

`autopublish` is allowed only for low-risk fictional or daily-life articles that pass QA and compliance.

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
