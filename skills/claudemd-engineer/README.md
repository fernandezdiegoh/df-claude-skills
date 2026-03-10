# claudemd-engineer

> Audit, iterate, and generate Claude Code instruction ecosystems (CLAUDE.md + rules + skills + hooks) — grounded in attention economics, progressive disclosure, and battle-tested anti-patterns.

## What it does

Analyzes the full Claude Code instruction ecosystem — CLAUDE.md files, `.claude/rules/`, skills, hooks, and settings — against 7 empirically validated principles and a catalog of 19 anti-patterns. Grades attention budget compliance, detects hierarchy violations, validates references, and produces optimized instruction architectures that maximize Claude Code's adherence.

The key insight: a monolithic CLAUDE.md is an anti-pattern. Claude Code has a multi-layer instruction system (CLAUDE.md, rules, skills, hooks), and putting the right instruction in the right layer is what separates high-adherence setups from instruction overload.

## Usage

```
/claudemd-engineer --audit                              # Full ecosystem audit
/claudemd-engineer --generate "Next.js SaaS app..."     # Generate CLAUDE.md from requirements
/claudemd-engineer --iterate current optimized.md        # Compare two versions
```

## What you get

- **Ecosystem grade** (A-F) with rationale
- **Ecosystem map** — all instruction files, line counts, always-on vs. scoped
- **Attention budget analysis** — total always-on lines, budget compliance
- **Architecture compliance** check (U-shaped curve, progressive disclosure, hierarchy)
- **Anti-pattern detection** (19 cataloged patterns with severity, impact, and fix)
- **Cross-file analysis** — conflicts, redundancy, coverage gaps
- **Reference validation** — stale paths, missing commands, outdated dependencies
- **Recommended CLAUDE.md** when changes are warranted
- **Ecosystem change recommendations** — rules to create, instructions to move to hooks, lines to delete

## Examples

### Audit summary

```markdown
# CLAUDE.md Ecosystem Audit

## Executive Summary
Grade: C — Functional but suboptimal. CLAUDE.md at 287 lines (43% over A-grade target),
4 high anti-patterns detected. Main issues: linter rules duplicated in CLAUDE.md, no
path-scoped rules despite multi-directory project, 3 stale path references.

## Ecosystem Map
| File | Type | Lines | Always-On | Notes |
|------|------|-------|-----------|-------|
| CLAUDE.md | root | 287 | Yes | Over budget |
| .claude/rules/api.md | rule (always-on) | 42 | Yes | Should be path-scoped |
| .claude/settings.json | config | — | — | 2 hooks configured |

**Totals:** 329 always-on instruction lines | 1 rule file | 0 skills | 2 hooks
```

### Finding example

```markdown
### [CRITICAL] AP-2: Linter-as-CLAUDE.md — ESLint rules duplicated
**File:** CLAUDE.md, lines 45-62
**Problem:** 18 lines of style rules (semicolons, quotes, indentation) that are already
enforced by .eslintrc.json.
**Principle:** Principle 6 (Linters Over Instructions)
**Impact:** 18 lines of attention budget spent on rules with 0% additional enforcement value.
**Fix:** Delete lines 45-62. ESLint already enforces these with 100% reliability.
```

## Modes

| Mode | What it does | Reads files | Validates refs |
|------|-------------|-------------|----------------|
| `--audit` | Full ecosystem analysis against principles and anti-patterns | Yes (all) | Yes |
| `--generate` | Create CLAUDE.md ecosystem from requirements + project analysis | Project files | N/A |
| `--iterate` | Compare two versions, predict impact | Yes (x2) | Optional |

## Core principles

| # | Principle | Key Insight |
|---|-----------|------------|
| 1 | Attention is zero-sum | Every instruction competes. CLAUDE.md under 200 lines (B), under 100 (A). |
| 2 | U-shaped attention curve | Start and end get most attention. Critical rules at top. |
| 3 | Progressive disclosure | Right instruction, right layer: CLAUDE.md, rules/, skills/, hooks. |
| 4 | Specificity over vagueness | "Write clean code" = noise. "Use early returns" = signal. |
| 5 | Don't instruct what's natural | "Think step by step" wastes budget — Claude already does this. |
| 6 | Linters over instructions | If a linter enforces it, delete the CLAUDE.md instruction. |
| 7 | Hooks for enforcement | NEVER/ALWAYS rules -> hooks. Instructions for guidance only. |

## Anti-pattern catalog

19 cataloged anti-patterns across 4 severity levels:

| Severity | Count | Examples |
|----------|-------|---------|
| **CRITICAL** | 5 | Instruction overload (>200 lines), linter-as-CLAUDE.md, conflicting instructions, tutorial dump, no project context |
| **HIGH** | 5 | Auto-generated dump, "NEVER" proliferation, CAPS overuse, redundant instructions, stale instructions |
| **MEDIUM** | 5 | Missing commands, generic identity, vague constraints, over-instruction of natural behavior, monolithic CLAUDE.md |
| **LOW** | 4 | Missing file map, anti-laziness prompts, style micromanagement, missing domain knowledge |

## Key features

| Feature | Description |
|---------|-------------|
| 7 core principles | Empirically validated, grounded in attention research and Claude Code behavior |
| 19 anti-patterns | Severity-graded catalog with detection criteria, impact, and fix for each |
| 3 operating modes | Audit, generate, iterate — covers full CLAUDE.md lifecycle |
| Multi-file analysis | Audits CLAUDE.md, rules/, skills/, hooks, and settings holistically |
| Progressive disclosure | Recommends optimal instruction placement across the file hierarchy |
| Reference validation | Glob-checks file paths, verifies commands exist, checks dependencies |
| Cross-file detection | Finds conflicts, redundancy, and coverage gaps across the ecosystem |
| Attention budget | Line-count tracking with A-F grading against empirical thresholds |
| Recommended output | Produces a complete revised CLAUDE.md, not just findings |

## Version history

| Version | Changes |
|---------|---------|
| 1.0.0 | Initial release — 3 modes (audit, generate, iterate), 7 core principles, 19 anti-patterns, progressive disclosure architecture, cross-file analysis, reference validation, attention budget grading |
