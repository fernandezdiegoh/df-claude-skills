# documentation-expert

> Audit, create, and improve project documentation. Detects stale docs, missing coverage, and LLM-generated filler.

## What it does

Produces documentation that developers actually read. Runs in four modes:

- **audit** — Map existing docs, find what's missing/stale/filler
- **create `<type>`** — Write new docs (README, architecture, API, feature, guide, ADR, runbook, CHANGELOG, CLAUDE.md)
- **improve `<file>`** — Rewrite or fix an existing doc
- **full** (default) — Audit + create/fix everything needed

## Usage

```
/documentation-expert              # full audit + fix
/documentation-expert audit        # assess existing docs only
/documentation-expert create ADR   # write a new ADR
/documentation-expert improve docs/architecture.md
```

## What you get

- **Documentation map** — table of every doc with status (current / stale / incomplete / missing / filler)
- **Anti-pattern detection** — catches LLM-generated filler, outdated references, duplicated content
- **Actionable docs** — written with 8 principles: lead with action, code over prose, explain "why" not "what", include the sad path
- **Validation** — all file paths, code examples, and internal links verified against actual code
- **Prioritized findings** — most impactful missing docs first, then stale, then quick wins

## Version history

| Version | Changes |
|---------|---------|
| 2.0.0 | Full rewrite: modes, 4-phase process, anti-pattern detection, templates |
| 1.0.0 | Initial release (basic template) |
