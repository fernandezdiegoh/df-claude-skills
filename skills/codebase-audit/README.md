# codebase-audit

> Full codebase audit — architecture, security, tech debt, and actionable remediation roadmap. Optimized to catch LLM-generated code issues.

## What it does

Performs a structured 8-phase audit of your codebase, producing a prioritized report with concrete findings, remediation steps, and effort estimates. Includes a dedicated phase for detecting LLM-generated code patterns (hallucinated APIs, phantom dependencies, tests that test nothing, over-engineering).

## Usage

```
/codebase-audit                  # full audit (all phases)
/codebase-audit reconcile        # verify if existing findings are resolved (~5-10 min)
/codebase-audit security         # security and vulnerable deps only
/codebase-audit architecture     # structure, coupling, API surface
/codebase-audit quality          # code quality, LLM patterns, tests
/codebase-audit frontend         # frontend files only
/codebase-audit module:src/auth  # audit a specific directory
```

Approximate times by codebase size:

| Codebase | Full audit | Partial scope |
|----------|-----------|---------------|
| < 10k LOC | ~15 min | ~5 min |
| 10k–50k LOC | ~25 min | ~10 min |
| > 50k LOC | ~40 min | ~15 min |

## What you get

- **Graded assessment** (A-F) based on objective criteria, with project maturity context
- **Findings** classified by severity (CRITICAL / HIGH / MEDIUM / LOW) with stable IDs for cross-audit tracking
- **Comparison** with previous audits (auto-detected from `docs/audits/`)
- **WORSENED findings highlighted** — regressions are called out explicitly
- **Remediation roadmap** prioritized by sprint
- **Machine-readable YAML metrics** for tracking trends across audits
- **Report storage** in `docs/audits/YYYY-MM-DD.md` + `docs/audits/latest.md` (stable reference)
- **Optional GitHub issue generation** for any severity — with dedup, grouping, and self-contained issue bodies

## Reconcile mode

Lightweight verification (~5-10 min) that checks whether existing findings have been resolved without running a full audit. Updates `latest.md` in place and saves a `YYYY-MM-DD-reconcile.md` snapshot. Handles renamed and deleted files.

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
- **Bus factor** analysis excluding AI co-authors (Claude, Copilot, Cursor, etc.)
- **Critical file heuristic**: auth, payment, PII, external APIs, db writes, >10 importers
- **Issue dedup**: checks existing open audit issues before creating new ones
- **Issue grouping**: merges related findings into single actionable issues
- **`--body-file` method**: avoids shell quoting issues with code snippets in issues

## Version history

| Version | Changes |
|---------|---------|
| 3.6.0 | Quick scope, simplified bus factor, subagent failure handling, duration metrics, improved docstring regex, nested fence fix, Phase 3.7 merged into Phase 3 subagent, date-based issue temp dirs |
| 3.5.0 | License compliance, secret scanning tools, issue dedup, reconcile file handling, dep pinning, maturity rubric, critical file definition, bus factor improvements, LOC-based time estimates, WORSENED highlighting, body-file issues, all-severity issue creation |
| 3.4.1 | Fixed regex alternation syntax (BRE → ripgrep) |
| 3.4.0 | Tool preference section, Phase 4.1 as table, Phase 1 reads CLAUDE.md, parallelization improved, Phase 0 fallback, reconcile snapshots, checkpoint .gitignore, stale code fix, large repos guidance, imperative exit checklist |
| 3.3.0 | Reconcile mode, report storage policy, self-contained issue template, issue quality rules |
| 3.2.0 | Report storage in `docs/audits/` with `latest.md` stable reference |
| 3.1.0 | English translation, scoping, subagents, git history, infra security, DB schema, frontend checks, LLM grep patterns, issue generation, YAML metrics, stable IDs |
| 2.0.0 | Initial public release |
