# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

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
