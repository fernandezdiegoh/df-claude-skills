# pr-review

> Rigorous PR review optimized for LLM-generated code. Assumes problems exist until proven otherwise.

## What it does

Performs a line-by-line code review of a Pull Request with a skeptical mindset. Specifically tuned to catch patterns typical of LLM-generated code: unnecessary abstractions, hallucinated methods, dead code, superficial tests, and silent error swallowing.

## Usage

```
/pr-review          # review current PR
/pr-review 142      # review PR #142
```

## What you get

- **Blocker findings** that must be resolved before merge
- **Recommended improvements** that should be resolved but don't block
- **Minor suggestions** (nice to have)
- **Executive summary** with verdict: APPROVE / APPROVE WITH CHANGES / REQUEST CHANGES / REJECT

## Review dimensions

| Area | What it checks |
|------|---------------|
| Correctness | Logic errors, off-by-one, race conditions, type coercions |
| Dead code | Unused imports, variables, functions, premature abstractions |
| Naming | Generic names (`data`, `result`, `handler`), clarity |
| Security | Input validation, secrets, injection, permissions |
| Performance | N+1 queries, sync bottlenecks, missing pagination |
| Error handling | Generic catches, silent failures, missing context |
| Tests | Coverage, real assertions vs trivial ones, edge cases |
| Consistency | Project patterns, conventions, new dependencies |
| React/Next.js | Waterfalls, bundle size, re-renders, server components |
| Documentation | API changes, useful comments, stale docs |

Includes special handling for **multi-commit / consolidation PRs** (staging -> main) to avoid false positives on intentional decisions.

## Version history

| Version | Changes |
|---------|---------|
| 1.2.0 | Initial public release |
