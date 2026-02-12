# pr-review

> Rigorous PR review optimized for LLM-generated code. Assumes problems exist until proven otherwise.

## What it does

Performs a line-by-line code review of a Pull Request with a skeptical mindset. Specifically tuned to catch patterns typical of LLM-generated code: unnecessary abstractions, hallucinated methods, dead code, superficial tests, and silent error swallowing.

Works both as a **standalone skill** (`/pr-review` from any Claude Code session) and as part of **agent-team workflows** (reviewer, senior-reviewer, final-reviewer roles).

## Usage

```
/pr-review                    # full review, auto-detect PR from current branch
/pr-review 142                # review PR #142 (full)
/pr-review security           # security-only review
/pr-review 142 performance    # PR #142, performance-only
/pr-review 142 quick          # PR #142, blockers + recommended only (standalone)
/pr-review 142 --team         # PR #142, agent-team mode (SendMessage delivery)
```

### Scopes

| Scope | Focus |
|-------|-------|
| `full` (default) | All 11 review dimensions |
| `security` | Input validation, secrets, injection, permissions, info exposure in errors |
| `performance` | N+1 queries, bottlenecks, frontend waterfalls and bundle size |
| `tests` | Coverage, assertion quality, edge cases, mocks |
| `architecture` | Logic, dead code, naming, performance, consistency — for refactors |
| `quick` | All dimensions, but report blockers + recommended only (standalone only) |

## What you get

- **Blocker findings** that must be resolved before merge
- **Recommended improvements** that should be resolved but don't block
- **Minor suggestions** (nice to have)
- **Executive summary** with verdict: APPROVE / APPROVE WITH CHANGES / REQUEST CHANGES / REJECT
- **Optional GitHub posting** — summary review or inline comments on the PR (standalone mode)

## Examples

### Progress updates during review

The review prints progress as each step and dimension completes:

```
✓ Context: 8 files modified across 3 commits — add user preferences API endpoint

→ Reviewing dimensions 2.1–2.11...
  ✓ 2.1 Logic — 1 blocker found
  ✓ 2.2 Dead code — clean
  ✓ 2.3 Naming — 1 minor
  ✓ 2.4 Security — 1 blocker found
  ✓ 2.5 Performance — clean
  ✓ 2.6 Error handling — 1 recommended
  ✓ 2.7 Tests — 1 recommended
  ✓ 2.8 Consistency — clean
  ✓ 2.9 Frontend perf — skipped (no frontend changes)
  ✓ 2.10 Documentation — clean
  ✓ 2.11 Migrations — 1 recommended

✓ Review complete: 2 blockers, 3 recommendations, 1 minor
```

### Findings report

Findings are organized by severity with concrete file:line references and proposed fixes:

```markdown
## Blockers (must be resolved before merging)

### B1: SQL injection via unsanitized user input
- **File and line**: `backend/app/api/preferences.py:47`
- **Problem**: User-provided `sort_by` parameter interpolated directly into SQL query
  without validation against an allowlist.
- **Impact**: Attacker can extract or modify any database data via crafted sort parameter.
- **Proposed solution**: Validate `sort_by` against an explicit allowlist of column names:
  ```python
  ALLOWED_SORT = {"created_at", "updated_at", "name"}
  if sort_by not in ALLOWED_SORT:
      raise HTTPException(400, f"Invalid sort field: {sort_by}")
  ```

### B2: Race condition in preference upsert [VERIFY]
- **File and line**: `backend/app/services/preferences.py:83-91`
- **Problem**: Read-then-write without transaction — concurrent requests can overwrite
  each other's changes. `[VERIFY]` — depends on whether concurrent writes are realistic.
- **Impact**: User preferences silently lost under concurrent updates.
- **Proposed solution**: Use `INSERT ... ON CONFLICT UPDATE` instead of separate read + write.

## Recommended improvements

### R1: Missing index for new query pattern
- **File and line**: `supabase/migrations/20260212_add_preferences.sql:12`
- **Problem**: New `WHERE user_id = ? AND category = ?` query without composite index.
- **Impact**: Full table scan on preferences table as it grows.
- **Proposed solution**: `CREATE INDEX idx_preferences_user_category ON preferences(user_id, category);`

## Executive summary

| Category | Count |
|----------|-------|
| Blockers | 2     |
| Recommended | 3  |
| Minor | 1       |

**Verdict: REQUEST CHANGES** — 2 blockers must be resolved: SQL injection (B1) and
race condition (B2, pending verification).
```

### Re-review output

When running a second review on the same PR after fixes:

```markdown
## Previously flagged — status update

- ~~B1: SQL injection via unsanitized user input~~ — **resolved** in commit `f3a21bc`
- B2: Race condition in preference upsert — **persists** (not addressed)

## New findings

### R3: Undocumented environment variable
- **File and line**: `backend/app/services/preferences.py:12`
- **Problem**: `os.environ["PREFERENCES_CACHE_TTL"]` not in `.env.example`.
```

### GitHub inline comment (Step 4)

When posting inline, blockers and recommendations become PR review comments:

```
📍 backend/app/api/preferences.py:47

**Blocker:** User-provided `sort_by` parameter interpolated directly into SQL
query without validation. This is a SQL injection vector.

**Fix:** Validate against allowlist:
    ALLOWED_SORT = {"created_at", "updated_at", "name"}
    if sort_by not in ALLOWED_SORT:
        raise HTTPException(400, f"Invalid sort field")
```

### Large PR category summary (>30 files)

```markdown
| Category        | Files | Blockers | Recommended | Minor |
|-----------------|-------|----------|-------------|-------|
| security-critical | 2   | 1        | 0           | 0     |
| database        | 3     | 0        | 1           | 0     |
| business-logic  | 12    | 1        | 3           | 2     |
| tests           | 8     | 0        | 0           | 1     |
| frontend        | 6     | 0        | 1           | 4     |
| config          | 3     | 0        | 0           | 0     |
| docs            | 2     | 0        | 0           | 0     |
```

## Review dimensions

| # | Area | What it checks |
|---|------|---------------|
| 2.1 | Correctness | Logic errors, off-by-one, race conditions, type coercions |
| 2.2 | Dead code + LLM anti-patterns | Unused code, hallucinated APIs, over-commenting, copy-paste bugs |
| 2.3 | Naming | Generic names (`data`, `result`, `handler`), clarity |
| 2.4 | Security | Input validation, secrets, injection, SSRF, permissions, CI/CD security |
| 2.5 | Performance | N+1 queries, sync bottlenecks, missing pagination |
| 2.6 | Error handling | Generic catches, silent failures, missing context |
| 2.7 | Tests | Coverage, real assertions vs trivial ones, edge cases |
| 2.8 | Consistency | Project patterns, conventions, new dependencies, env vars, dep CVEs |
| 2.9 | Frontend perf + a11y | Waterfalls, bundle size, re-renders, accessibility (React checks conditional) |
| 2.10 | Documentation | API changes, useful comments, stale docs |
| 2.11 | Migrations | Idempotency, zero-downtime safety, rollback, indexes |

## Key features

| Feature | Description |
|---------|-------------|
| Scoped reviews | Focus on security, performance, architecture, or tests only |
| GitHub integration | Post review as summary or inline comments via `gh api` |
| Progress reporting | Mandatory progress lines so you always know what's happening |
| Multi-commit handling | Detects intentional decisions in consolidation PRs, avoids false positives |
| Large PR strategy | Category grouping, priority-based review order for PRs with 30+ files |
| Confidence tagging | `[VERIFY]` tag for findings that need runtime verification |
| Self-correction detection | Skips issues fixed in later commits within the same PR |
| Agent-team compatible | Works as reviewer/senior-reviewer/final-reviewer with SendMessage delivery |
| Finding deduplication | Consolidates repeated patterns into single findings with all locations |
| Draft PR awareness | Adjusts tone for WIP PRs while maintaining rigor |
| Trivial PR fast path | Condensed review for ≤3 files, ≤20 lines, docs/config/style only |
| Generated file skip | Lock files and auto-generated code noted but not reviewed line-by-line |
| Re-review tracking | Reads previous review, tracks resolved/pending findings across iterations |
| CLAUDE.md integration | Reads project-specific rules to supplement default dimensions |
| Auto-detect PR | Resolves PR number from current branch when not specified |
| Exit checklist | 12-point verification before delivering the verdict |

## Version history

| Version | Changes |
|---------|---------|
| 2.1.0 | CLAUDE.md integration, re-review tracking, auto-detect PR, SSRF/CI-CD/dep-CVE checks, a11y, trivial fast path, cross-PR conflicts |
| 2.0.0 | Scoping, GitHub integration, migrations dimension, progress reporting, large PR handling, agent-team compatibility, exit checklist |
| 1.3.0 | Translated to English |
| 1.2.0 | Initial public release |
