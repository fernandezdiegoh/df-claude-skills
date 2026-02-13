# codebase-audit

> Full codebase audit — architecture, security, tech debt, and actionable remediation roadmap. Optimized to catch LLM-generated code issues.

## What it does

Performs a structured 8-phase audit of your codebase, producing a prioritized report with concrete findings, remediation steps, and effort estimates. Includes a dedicated phase for detecting LLM-generated code patterns (hallucinated APIs, phantom dependencies, tests that test nothing, over-engineering).

## Usage

```
/codebase-audit                  # full audit (all phases)
/codebase-audit quick            # Phase 0 + top 5 findings + grade (~5 min triage)
/codebase-audit reconcile        # verify if existing findings are resolved (~5-10 min)
/codebase-audit security         # security and vulnerable deps only
/codebase-audit architecture     # structure, coupling, API surface
/codebase-audit quality          # code quality, LLM patterns, tests
/codebase-audit diff             # only files changed since last audit
/codebase-audit frontend         # frontend files only
/codebase-audit module:src/auth  # audit a specific directory
```

Approximate times by codebase size:

| Codebase | Full audit | Partial scope |
|----------|-----------|---------------|
| < 10k LOC | ~15 min | ~5 min |
| 10k–50k LOC | ~25 min | ~10 min |
| 50k–100k LOC | ~40 min | ~15 min |
| > 100k LOC | ~60 min | ~20 min |

## What you get

- **Graded assessment** (A-F) based on objective criteria, with project maturity context
- **Findings** classified by severity (CRITICAL / HIGH / MEDIUM / LOW) with stable IDs for cross-audit tracking
- **Comparison** with previous audits (auto-detected from `docs/audits/`)
- **WORSENED findings highlighted** — regressions are called out explicitly
- **Remediation roadmap** prioritized by sprint
- **Machine-readable YAML metrics** for tracking trends across audits
- **Report storage** in `docs/audits/YYYY-MM-DD.md` + `docs/audits/latest.md` (stable reference)
- **Optional GitHub issue generation** for any severity — with dedup, grouping, and self-contained issue bodies

## Examples

### Progress updates during execution

The audit runs phases in parallel via subagents and prints progress as each completes:

```
⏳ Launching Group 1: Phase 0 + Phase 1 + Phase 2

✓ Phase 0 complete — 0 lint errors, 631 tests passing, 1 vuln dep
✓ Phase 1 complete — 26k LOC, 20 hotspots, bus factor 1 (critical)
✓ Phase 2 complete — 0 critical, 1 high, 4 medium findings

⏳ Launching Group 2: Phase 3 + Phase 4 + Phase 5

✓ Phase 3 complete — 2 high, 6 medium, 8 low findings (architecture)
✓ Phase 4 complete — 3 high, 8 medium, 7 low findings (quality)
✓ Phase 5 complete — 0 high, 3 medium, 7 low findings (operability)

⏳ Consolidating tech debt (Phase 6) and writing report...
```

### Audit summary

The final report opens with an executive summary, grade, and top risks:

```markdown
Grade: B — Acceptable

| Severity | Count |
|----------|-------|
| CRITICAL | 0     |
| HIGH     | 6     |
| MEDIUM   | 17    |
| LOW      | 16    |

Top 3 risks:
1. SECRET_KEY insecure default — app encrypts data with a known key
2. PyMuPDF AGPL license — copyleft dep in MIT-licensed project
3. Global mutable state without locks — 5 dicts mutated without sync

Top 3 strengths:
1. 631 tests with CI enforcement and coverage ratchets
2. Excellent documentation — CLAUDE.md + 15 modular docs
3. Clean architecture — no circular deps, domain-based separation
```

### Progress vs. previous audit

When a previous audit exists, the report includes a comparison table with regression tracking:

```markdown
| Old ID | Finding                    | Previous | Current    | Status                  |
|--------|----------------------------|----------|------------|-------------------------|
| C1     | Zero tests                 | CRITICAL | —          | RESOLVED (631 tests)    |
| C2     | God files backend          | CRITICAL | —          | RESOLVED (PRs #73/#78)  |
| I3     | Error handling inconsistent | HIGH     | MEDIUM     | IMPROVED                |
| M3     | Threading locks             | MEDIUM   | MEDIUM     | **WORSENED** (4→5 dicts)|
| —      | PyMuPDF AGPL license       | —        | HIGH (H-2) | NEW                     |

Summary: 14 resolved, 8 persist, 1 worsened, 11 new. Trend: improving.
```

### Issue reconciliation (Phase 7)

When open audit issues exist, Phase 7 reconciles them before creating new ones:

```
Issue reconciliation:
- Close: #157 (H-2 RESOLVED — PyMuPDF replaced with pypdf in PR #179)
- Update: #162 (M-1 IMPROVED — singleton locks added, 5 globals remain)
- Update: #170 (M-11 RESOLVED, M-15 persists — update title, comment resolution)
- Keep: #158, #159, #160, ... (15 unchanged)
- Create: 13 new findings (2 HIGH, 5 MEDIUM, 6 LOW)

Proceed? [severities to create for new findings]
```

### GitHub issue (self-contained, with grouped findings)

Related findings are merged into a single issue. Each issue includes enough context to implement without reading the full audit:

```markdown
## Audit finding

**ID:** M-4, M-5
**Severity:** MEDIUM
**Phase:** 2.3 Authentication, 2.4 Sensitive data
**Location:** `backend/app/whatsapp/webhook.py:40-65`

## Context
The WhatsApp integration receives webhooks from Twilio and processes
messages through the RAG agent.

## Problem
### M-4: Webhook authentication is optional
Twilio signature validation is skipped when auth_token is empty or
the twilio package is not installed. Attackers can send spoofed
requests that consume API credits.

### M-5: PII logged in plaintext
Phone numbers and message content logged without masking.

## Current code
    [actual problematic code snippet]

## Suggested fix
    [concrete code with the fix]

## Acceptance criteria
- [ ] Webhook rejects requests (403) when auth not configured
- [ ] Phone numbers masked in all log messages
- [ ] Rate limiting (30/min) added to webhook endpoint

**Estimate:** ~small (2h)
```

### Reconcile output

Lightweight verification that checks existing findings without a full audit:

```markdown
## Reconciliation summary — 2026-03-01

| Status   | Count |
|----------|-------|
| RESOLVED | 4     |
| PERSISTS | 3     |
| IMPROVED | 1     |
| WORSENED | 0     |

### Resolved
- ~~H-1: SECRET_KEY insecure default~~ — fixed in `config.py:32`
- ~~H-2: PyMuPDF AGPL~~ — replaced with pypdf in commit `abc1234`

### Changed
- M-12: Logging → IMPROVED (structured logging added, correlation IDs pending)

### Persists
- H-4: Admin page duplication
- M-1: Threading locks on global state
```

## Reconcile mode

Lightweight verification (~5-10 min) that checks whether existing findings have been resolved without running a full audit. Updates `latest.md` in place and saves a `YYYY-MM-DD-reconcile.md` snapshot. Handles renamed files, deleted files, and PR-based resolutions (checks closing PRs via `gh` before reopening).

## Phases

| # | Phase | Focus |
|---|-------|-------|
| 0 | Automated checks | Linter, types, tests, dep audit, coverage |
| 1 | Reconnaissance | Structure, stack, deps, license compliance, CI/CD, git history, project instructions |
| 2 | Security | Secrets (+ trufflehog/gitleaks), inputs, auth, attack surface, infra |
| 3 | Architecture | Coupling, patterns, DB schema, API, frontend, scalability |
| 4 | Code quality | LLM patterns, dead code, error handling, tests |
| 5 | Operability | DevEx, observability, deploy |
| 6 | Tech debt | Consolidated debt assessment |
| 7 | Issues (optional) | GitHub issue creation with dedup and grouping |

## Key features

- **Parallelized execution** via subagents with descriptive names
- **Tool preference**: uses Claude Code's Glob/Grep/Read tools (not bash grep/find)
- **License compliance** check (copyleft in non-copyleft projects)
- **Bus factor** analysis with optional AI co-author exclusion
- **Critical file heuristic**: auth, payment, PII, external APIs, db writes, >10 importers
- **Issue dedup**: checks existing open audit issues before creating new ones
- **Issue grouping**: merges related findings into single actionable issues
- **`--body-file` method**: avoids shell quoting issues with code snippets in issues

## Version history

| Version | Changes |
|---------|---------|
| 3.8.1 | Reconcile checks PR-based resolutions before reopening findings (reads closing PRs, evaluates fix, confirms not reverted) |
| 3.8.0 | Full issue lifecycle (close resolved, update changed, create new), no background Bash rule, stable ID preservation across audits, residual work tracking for closed issues, reconcile↔issues gap documented |
| 3.7.0 | Diff scope, >100k LOC sampling, finding→issue backlinks, expanded YAML metrics, [STATIC-ONLY] tag, Phase 0 parallelization, reconcile refreshes test inventory, `latest.md` protected from partial overwrites, Phase 6 moved to sequential consolidation, `diff:YYYY-MM-DD` override, quick scope includes security skim, BRE regex fix |
| 3.6.0 | Quick scope, simplified bus factor, subagent failure handling, duration metrics, improved docstring regex, nested fence fix, Phase 3.7 merged into Phase 3 subagent, date-based issue temp dirs |
| 3.5.0 | License compliance, secret scanning tools, issue dedup, reconcile file handling, dep pinning, maturity rubric, critical file definition, bus factor improvements, LOC-based time estimates, WORSENED highlighting, body-file issues, all-severity issue creation |
| 3.4.1 | Fixed regex alternation syntax (BRE → ripgrep) |
| 3.4.0 | Tool preference section, Phase 4.1 as table, Phase 1 reads CLAUDE.md, parallelization improved, Phase 0 fallback, reconcile snapshots, checkpoint .gitignore, stale code fix, large repos guidance, imperative exit checklist |
| 3.3.0 | Reconcile mode, report storage policy, self-contained issue template, issue quality rules |
| 3.2.0 | Report storage in `docs/audits/` with `latest.md` stable reference |
| 3.1.0 | English translation, scoping, subagents, git history, infra security, DB schema, frontend checks, LLM grep patterns, issue generation, YAML metrics, stable IDs |
| 2.0.0 | Initial public release |
