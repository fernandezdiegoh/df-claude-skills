# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### codebase-audit v3.4.0
- Added Tool preference section: prefer Glob/Grep/Read over bash grep/find (macOS compatibility)
- Phase 4.1 LLM detection now uses Grep/Glob tool references instead of `grep -P` (not available on macOS)
- Improved parallelization: Phase 2 (security) moved to Group 1 (no dependency on Phase 0/1)
- Added `module:<path>` scope delegation clarification
- Added Phase 0 fallback: missing tools noted as SKIPPED, don't block the audit
- Reconcile mode now saves `YYYY-MM-DD-reconcile.md` snapshot for historical tracking
- Checkpoint: explicit step to verify `.gitignore` includes `docs/.audit-checkpoint.md`
- Stale code detection: replaced `/tmp/recent-files.txt` with `comm` one-liner (no temp file collision)
- Added large repos guidance (>50k LOC): prioritize by churn + critical paths
- Exit checklist rewritten as imperative numbered steps
- Phase 4.1 automated detection reformulated from pseudo-syntax to natural language table
- Phase 1 step 8: read CLAUDE.md / `.claude/` for project decisions, known bugs, conventions
- Added `reconcile` as valid naming suffix in report storage section
- Fixed exit checklist reference from "Phase 1.7" to "Phase 1, step 7"

### codebase-audit v3.3.0
- Added `reconcile` mode: verify existing findings against current code, update statuses
- Reconcile skips the full audit — only checks if open findings are resolved/improved/worsened
- Produces a reconciliation summary with counts and per-finding status changes
- Updates `latest.md` in place (strikethrough + RESOLVED, YAML metrics)
- Time estimate: ~5-10 min vs 15-40 min for full audit
- Improved Phase 7 issue template: self-contained issues with context, current code snippet, concrete fix, and testable acceptance criteria
- Added issue quality rules (mandatory code snippets, concrete fixes, testable criteria)
- MEDIUM/LOW findings can now be created as issues if user requests it

### codebase-audit v3.2.0
- Added report storage policy: save to `docs/audits/YYYY-MM-DD.md` + copy to `docs/audits/latest.md`
- `latest.md` is the stable reference — other files point to it, no updates needed on new audits
- Dated files are historical archives for cross-audit comparison
- Updated Phase 0 to search `docs/audits/` first, then legacy locations as fallback
- Added exit checklist item for saving report + latest.md
- Retention policy: keep all reports (small files, cross-audit diff is the value)

### documentation-expert v2.3.0
- Added `validate` mode (run Phase 4 checks only — broken links, stale refs, placeholders)
- Added summary mode depth limit (top-level + docs/ first level only)
- Added orphan doc detection (Step 5 — docs with no inbound links)
- Added env var scanning (Step 6 — find undocumented env vars in code)
- Added doc debt tracking via `docs/DOC-DEBT.md` (lightweight checkbox tracker)
- Tightened path regex to require file extension (.py/.ts/.md/.json/etc.) and ignore URLs
- Improved effort scale examples (more precise per category)

### documentation-expert v2.2.0
- Added `summary` mode for quick triage (health summary + top 5 findings, no writing)
- Added hallucinated references detection to section 2.5 (plausible-looking paths/flags that don't exist)
- Added explicit prioritization criteria (onboarding > bugs > complex features > quality)
- Added filler doc handling guidance (delete / consolidate / rewrite)
- Added CHANGELOG template (Keep a Changelog format)
- Added effort scale definition (~small / ~medium / ~large)
- Added "Changes made" section to full mode output
- Added mode guards (skip Phase 3 in audit mode, stop at Phase 1 in summary mode)
- Added docs-as-tests validation step in Phase 4 (verify shell commands are real)
- Added execution rule 10: know when NOT to write docs
- Added auto-generated docs guidance in Phase 1 (OpenAPI, Typedoc — audit config, not content)
- Fixed regex to require `/` for path detection (avoids `v1.0`, `user.name` false positives)
- Fixed freshness script to handle filenames with spaces (`git ls-files -z` + `read -d ''`)
- Fixed argument parsing docs (everything after mode word is the full argument)
- Fixed README template ("3 commands max" → "group into clear steps" for complex setups)
- Fixed Mermaid guidance (added Bitbucket fallback note, ~15 node limit)
- Fixed `file:line` rule clarification (IDE/Claude Code navigation, not GitHub links)
- Removed arbitrary "50 lines" threshold for TOC filler detection

### documentation-expert v2.1.0
- Fixed Phase 1 bash scripts for macOS (`grep -oP` doesn't exist, `find -mtime` doesn't work with Git)
- Replaced raw bash commands with Claude Code tool references (Glob, Grep, Read)
- Added Tool preference section explaining when to use built-in tools vs bash
- Added invocation examples to Scope section (how to pass modes)
- Added section 2.5: LLM-generated artifacts detection (throat-clearing, false precision, redundant structure)
- Added templates for Architecture (with Mermaid diagram), Runbook, and CLAUDE.md
- Added writing rule 9: use Mermaid diagrams for architecture docs
- Added health summary table to audit output format
- Made Phase 4 validation partially automated (path verification, placeholder detection, link resolution)
- Fixed broken regex in Phase 1 (missing closing parenthesis in link pattern)
- Added execution rule 9: co-locate docs with code when they'd go stale quickly

### documentation-expert v2.0.0
- Full rewrite from generic template to comprehensive documentation skill
- Added modes: audit, create, improve, full (default)
- Added 9 documentation types (README, architecture, API, feature, guide, ADR, runbook, CHANGELOG, CLAUDE.md)
- Added 4-phase process: audit existing docs, detect anti-patterns, write/improve, validate
- Added automated checks (stale docs, broken links, outdated code references)
- Added LLM filler detection (paraphrased code, generic sections, empty overviews)
- Added writing rules (8 principles: lead with action, code over prose, one source of truth, etc.)
- Added templates for README, feature doc, and ADR
- Added validation checklist
- Added structured audit output format with documentation map

### pr-review v1.3.0
- Translated to English

### templates
- Added SKILL-TEMPLATE.md for creating new skills
- Added README-TEMPLATE.md for skill READMEs

### codebase-audit v3.1.0
- Translated to English
- Added scoping (security/architecture/quality/devex/backend/frontend/module)
- Added subagent parallelization strategy with checkpoint recovery
- Added git history analysis (churn, bus factor, stale code detection)
- Added infrastructure/container security checks (Phase 2.6)
- Added database schema analysis (Phase 3.5)
- Added frontend-specific checks (Phase 3.7)
- Added automated LLM detection grep patterns (Phase 4.1)
- Added optional GitHub issue generation with label setup (Phase 7)
- Added machine-readable YAML metrics for cross-audit tracking
- Added stable IDs (C-N, H-N, M-N, L-N) for cross-audit resolution tracking
- Added explicit SKIPPED markers for non-applicable sections
- Added time estimate disclaimer (~15-40 min full, ~5-15 min partial)
- Fixed git command for stale code detection (was finding recent files, not old)
- Fixed `pass$` grep pattern (was matching `password`, `passenger`, etc.)
- Fixed checkpoint path (now prefers `docs/.audit-checkpoint.md` over `/tmp/`)
- Clarified that Phase 0 always runs full regardless of scope

### frontend-design v1.0.0
- Replaced broken `license: Complete terms in LICENSE.txt` with `source:` attribution

## 2025-02-11

### codebase-audit v2.0.0
- Initial public release with 7-phase audit process
- LLM-specific pattern detection
- Previous audit comparison
- A-F grading rubric

### pr-review v1.2.0
- Initial public release
- Multi-commit / consolidation PR handling
- React/Next.js performance checks
- LLM-generated code focus

### documentation-expert v1.0.0
- Initial release (basic template, pending rewrite)

### frontend-design v1.0.0
- Initial release (based on Anthropic's official plugin)
