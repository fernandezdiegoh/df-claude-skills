# Changelog

## [1.0.0] — 2026-02-21

### Added
- **4 operating modes:** `--audit`, `--generate`, `--iterate`, `--test`
- **7 core principles** grounded in empirical evidence:
  - Attention is zero-sum (Databricks/Scale AI research)
  - U-shaped attention curve (Lost in the Middle effect)
  - Instructions vs. organic behavior (SovraWeb V1→V4 link regression)
  - Template variable hygiene
  - Session context contamination
  - Trigger phrases
  - Chunks > prompt for factual grounding
- **19 anti-patterns** across 4 severity levels (CRITICAL, HIGH, MEDIUM, LOW):
  - AP-1 through AP-5 (CRITICAL): instruction overload, explicit link instructions, template collisions, facts in prompt, no abstention rule
  - AP-6 through AP-10 (HIGH): hardcoded URLs, NEVER proliferation, CAPS overuse, redundant instructions, missing grounding anchor
  - AP-11 through AP-15 (MEDIUM): generic identity, context at top, missing locale rule, over-routing, confidentiality buried
  - AP-16 through AP-19 (LOW): anti-laziness prompts, verbose examples, style micromanagement, README dump
- **Optimal prompt architecture** based on U-shaped attention: critical rules → domain → context → output → grounding anchor
- **Live API testing** with 6 diagnostic queries (grounding, locale, routing, confidentiality, links, adversarial)
- **Pre-flight checks** for API access and credentials before test/live modes
- **Token counting** via `tiktoken` (cl100k_base) with heuristic fallback (~4 chars/tok EN, ~3 chars/tok ES)
- **Grading rubric** (A-F) with objective criteria tied to instruction budget and anti-pattern counts
- **Iterate mode** with side-by-side diff, impact prediction, and regression detection
- **Generate mode** with optimal architecture scaffolding and inline commentary
- **Execution rules** including "never suggest adding instructions as first fix" and attention budget accounting
