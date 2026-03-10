# Changelog

## [1.0.0] — 2026-03-10

### Added
- **3 operating modes:** `--audit`, `--generate`, `--iterate`
- **7 core principles** grounded in empirical evidence:
  - Attention is a zero-sum budget (Databricks/Scale AI research)
  - U-shaped attention curve (Lost in the Middle effect)
  - Progressive disclosure architecture (CLAUDE.md -> rules/ -> skills/ -> hooks)
  - Specificity over vagueness (testable instructions only)
  - Don't instruct what's already natural
  - Linters over instructions
  - Hooks for enforcement, instructions for guidance
- **19 anti-patterns** across 4 severity levels (CRITICAL, HIGH, MEDIUM, LOW):
  - AP-1 through AP-5 (CRITICAL): instruction overload, linter-as-CLAUDE.md, conflicting instructions, tutorial dump, no project context
  - AP-6 through AP-10 (HIGH): auto-generated dump, NEVER proliferation, CAPS overuse, redundant instructions, stale instructions
  - AP-11 through AP-15 (MEDIUM): missing commands, generic identity, vague constraints, over-instruction of natural behavior, monolithic CLAUDE.md
  - AP-16 through AP-19 (LOW): missing file map, anti-laziness prompts, style micromanagement, missing domain knowledge
- **5-phase audit flow:** ecosystem discovery, individual file analysis, cross-file analysis, content validation, report generation
- **Claude Code ecosystem knowledge:** instruction resolution hierarchy, rules system, skills, hooks, settings, memory
- **Progressive disclosure architecture** — recommends optimal instruction placement across CLAUDE.md, rules/, skills/, hooks
- **Cross-file analysis** — conflict detection, redundancy, coverage gaps, hierarchy compliance
- **Reference validation** — glob-checks file paths, verifies commands, checks dependencies
- **Grading rubric** (A-F) with objective criteria tied to line counts and anti-pattern severity
- **Generate mode** with project analysis, optimal architecture scaffolding, and supporting rule file recommendations
- **Iterate mode** with side-by-side diff, impact prediction, and regression detection
- **Execution rules** including "never suggest adding instructions as first fix" and attention budget accounting
