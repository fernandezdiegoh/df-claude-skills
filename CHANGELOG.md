# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

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
