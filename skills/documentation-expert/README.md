# documentation-expert

> Audit, create, and improve project documentation. Detects stale docs, missing coverage, and LLM-generated filler. Produces actionable docs that developers actually read.

## What it does

Performs a structured 5-phase documentation audit, producing a prioritized report with concrete findings and effort estimates. Includes dedicated detection of LLM-generated documentation patterns (filler that looks complete but says nothing, hallucinated file references, exhaustive tables without explanation). Can also write, improve, and validate docs directly.

## Usage

```
/documentation-expert                      # full audit + fix everything
/documentation-expert audit                # assess only, don't write
/documentation-expert summary              # quick health check, top 5 findings
/documentation-expert validate             # check links, refs, placeholders only
/documentation-expert diff                 # what docs are stale from recent changes?
/documentation-expert diff:7               # changes in last 7 days (default: 30)
/documentation-expert reconcile            # check if previous findings are resolved
/documentation-expert scope:services/auth/ # audit docs for auth service only
/documentation-expert create architecture  # write a new architecture doc
/documentation-expert create ADR           # write a new ADR
/documentation-expert improve docs/api.md  # rewrite an existing doc
```

Approximate times by project size:

| Project size | Markdown files | Approximate time |
|-------------|----------------|-----------------|
| Small | ≤20 | ~10 min |
| Medium | 20-50 | ~20 min |
| Large | 50-100 | ~35 min |
| Very large | 100+ | ~50 min |

## What you get

- **Graded assessment** (✅ Good / ⚠️ Needs work / ❌ Critical gaps) based on objective P1/P2 counts and current-doc percentage
- **Structured findings** classified by priority (P1–P4) with location, problem, impact, action, and effort
- **Comparison** with previous audits (auto-detected from `docs/doc-audits/`)
- **Machine-readable YAML metrics** for tracking trends across audits
- **Report storage** in `docs/doc-audits/YYYY-MM-DD.md` + `docs/doc-audits/latest.md` (stable reference)
- **Optional GitHub issue generation** for any priority — with dedup, grouping, and self-contained issue bodies

## Examples

### Progress updates during execution

The audit prints progress as each phase starts and completes:

```
⏳ Phase 1: scanning and mapping documentation...
✓ Phase 1 complete — 14 docs mapped (8 current, 3 stale, 2 missing, 1 filler)

⏳ Phase 2: detecting anti-patterns...
✓ Phase 2 complete — 7 anti-patterns found (2 filler, 3 stale refs, 2 LLM artifacts)

⏳ Phase 3: writing and improving documentation...
✓ Phase 3 complete — 4 docs written, 2 improved

⏳ Phase 4: validating...
✓ Phase 4 complete — all paths verified, 1 broken link fixed

✓ Phase 5 complete — 3 issues created, 1 closed, 1 updated
```

### Audit summary

The report opens with a health summary and grade:

```markdown
## Health summary

| Metric | Value |
|--------|-------|
| **Documented areas** | 6/9 areas covered |
| **Current docs** | 8 |
| **Stale docs** | 3 |
| **Missing docs** | 2 |
| **Filler docs** | 1 |
| **Overall health** | ⚠️ Needs work |
```

### Structured findings

Findings are grouped by category with concrete locations and proposed actions:

```markdown
### Missing

#### [P1 — Blocks onboarding] No API documentation
- **Location:** `docs/` (doesn't exist yet) — related code: `src/api/routes/`
- **Problem:** 12 API endpoints with no documentation. Integrators have to read source code.
- **Impact:** Blocks external integrators and slows onboarding for new team members.
- **Action:** Create `docs/api.md` using the API reference template.
- **Effort:** ~large

### Stale

#### [P2 — Causes confusion] Architecture doc references old module structure
- **Location:** `docs/architecture.md` (last updated 2025-11-03)
- **Problem:** References `src/services/` which was renamed to `src/modules/` in December.
- **Impact:** New hires follow wrong file paths; causes confusion during onboarding.
- **Action:** Update all file path references and the Mermaid diagram.
- **Effort:** ~small
```

### Progress vs. previous audit

When a previous audit exists, the report includes a comparison table:

```markdown
## Changes since last audit (2026-01-15)

| Finding | Previous | Current | Status |
|---------|----------|---------|--------|
| Missing API docs | P1 | — | ✅ Resolved |
| Stale architecture.md | P2 | P3 | ⬆️ Improved |
| README missing quickstart | — | P1 | 🆕 New |
| Filler in deployment.md | P3 | P3 | ➡️ Persists |
```

### Reconcile output

Lightweight verification that checks existing findings without a full audit:

```markdown
## Finding status (vs. audit of 2026-01-15)

| Finding | Previous | Current | Status |
|---------|----------|---------|--------|
| Missing API docs | P1 | — | ✅ Resolved |
| Stale architecture.md | P2 | P3 | ⬆️ Improved |
| README missing quickstart | P1 | — | ✅ Resolved |
| Filler in deployment.md | P3 | P2 | ⬇️ Worsened |
| Orphan runbook | P4 | P4 | ➡️ Persists |

**Resolved:** 2/5 (40%) · **Improved:** 1/5 (20%) · **Persists:** 1/5 (20%) · **Worsened:** 1/5 (20%)
```

### Diff mode output

Shows which code changes triggered which doc flags:

```markdown
| Changed file | Docs referencing it | Likely stale? |
|-------------|--------------------|----|
| `src/api/auth.ts` | `docs/api.md`, `README.md` | ⚠️ Yes — auth flow rewritten |
| `src/utils/format.ts` | (none) | — |
| `src/db/schema.ts` | `docs/architecture.md` | ⚠️ Yes — new tables added |
```

## Modes

| Mode | Phases | Writes docs? |
|------|--------|-------------|
| `full` (default) | 1 → 2 → 3 → 4 → 5 | Yes |
| `audit` | 1 → 2 → 4 | No |
| `summary` | 1 (partial) | No |
| `validate` | 4 only | No |
| `diff` | 1 → 2 → 4 (scoped to changed files) | No |
| `reconcile` | Spot-check previous findings | No |
| `scope:<path>` | 1 → 2 → 4 (scoped to directory) | No |
| `create <type>` | 3 only | Yes |
| `improve <file>` | 3 only | Yes |

## Phases

| # | Phase | Focus |
|---|-------|-------|
| 1 | Audit | Map all docs, check freshness via git, find broken links, detect orphans, scan env vars |
| 2 | Anti-patterns | Filler docs, outdated references, missing critical docs, structure problems, LLM artifacts |
| 3 | Write/improve | Create or fix docs following 9 writing rules and type-specific templates |
| 4 | Validate | Verify file paths, placeholder content, internal links, code examples, CI integration |
| 5 | GitHub issues | Optional: create `doc-debt` issues, reconcile existing, group related findings |

## Key features

| Feature | Description |
|---------|-------------|
| 9 doc types | README, architecture, API, feature, guide, ADR, runbook, CHANGELOG, CLAUDE.md — each with a template |
| LLM artifact detection | Throat-clearing phrases, hallucinated references, exhaustive tables that explain nothing |
| Objective health grade | ✅/⚠️/❌ based on P1/P2 counts and current-doc percentage — no subjective judgment |
| Priority system (P1–P4) | Blocks onboarding → Causes confusion → Missing coverage → Polish |
| Previous audit comparison | Auto-detects `docs/doc-audits/latest.md`, tracks resolved/improved/worsened/new |
| Report storage | `docs/doc-audits/YYYY-MM-DD.md` with `latest.md` stable reference |
| YAML metrics | Machine-readable block for automated trend tracking |
| Reconcile mode | Lightweight verification of previous findings without full scan, updates `latest.md` |
| Diff mode | Audit only docs affected by recent code changes (default: 30 days) |
| Scope mode | Audit docs within a specific directory (monorepo-friendly) |
| Parallelization | Phase 3 writing fans out across subagents when 3+ docs need work |
| Checkpoints | Recovery from interrupted sessions via `docs/.doc-audit-checkpoint.md` |
| CI recommendations | Suggests broken link checks, doc freshness, placeholder detection in CI |
| OpenAPI/Swagger audit | Checks spec version, endpoint coverage, output freshness, build integration |
| Orphan detection | Link graph analysis with actionable recommendations (delete/link/consolidate) |
| GitHub issues | Create `doc-debt` issues with priority filter, dedup, grouping, and backlinks |
| Exit checklist | 16-point verification before delivering the final report |

## Version history

| Version | Changes |
|---------|---------|
| 3.0.0 | Reconcile mode, scope mode, diff mode, GitHub issues, structured findings (P1–P4), health grading rubric, YAML metrics, parallelization, checkpoints, report storage, previous audit comparison, CI integration guidance, OpenAPI audit guidance, progress reporting, exit checklist |
| 2.0.0 | Full rewrite: modes, 4-phase process, anti-pattern detection, templates |
| 1.0.0 | Initial release (basic template) |
