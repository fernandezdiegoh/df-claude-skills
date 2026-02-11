# codebase-audit

> Full codebase audit — architecture, security, tech debt, and actionable remediation roadmap. Optimized to catch LLM-generated code issues.

## What it does

Performs a structured 8-phase audit of your codebase, producing a prioritized report with concrete findings, remediation steps, and effort estimates. Includes a dedicated phase for detecting LLM-generated code patterns (hallucinated APIs, phantom dependencies, tests that test nothing, over-engineering).

## Usage

```
/codebase-audit                  # full audit (all phases)
/codebase-audit security         # security and vulnerable deps only
/codebase-audit architecture     # structure, coupling, API surface
/codebase-audit quality          # code quality, LLM patterns, tests
/codebase-audit frontend         # frontend files only
/codebase-audit module:src/auth  # audit a specific directory
```

A full audit takes ~15-40 minutes. Partial scopes are ~5-15 minutes.

## What you get

- **Graded assessment** (A-F) based on objective criteria
- **Findings** classified by severity (CRITICAL / HIGH / MEDIUM / LOW) with stable IDs for tracking
- **Comparison** with previous audits (if one exists in `docs/`)
- **Remediation roadmap** prioritized by sprint
- **Machine-readable YAML metrics** for tracking trends across audits
- **Optional GitHub issue generation** from CRITICAL and HIGH findings

## Phases

| # | Phase | Focus |
|---|-------|-------|
| 0 | Automated checks | Linter, types, tests, dep audit, coverage |
| 1 | Reconnaissance | Structure, stack, deps, CI/CD, git history |
| 2 | Security | Secrets, inputs, auth, attack surface, infra |
| 3 | Architecture | Coupling, patterns, DB schema, API, frontend, scalability |
| 4 | Code quality | LLM patterns, dead code, error handling, tests |
| 5 | Operability | DevEx, observability, deploy |
| 6 | Tech debt | Consolidated debt assessment |
| 7 | Issues (optional) | GitHub issue creation from findings |

## Version history

| Version | Changes |
|---------|---------|
| 3.1.0 | English translation, scoping, subagents, git history, infra security, DB schema, frontend checks, LLM grep patterns, issue generation, YAML metrics, stable IDs, bug fixes |
| 2.0.0 | Initial public release |
