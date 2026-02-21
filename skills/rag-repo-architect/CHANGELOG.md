# Changelog

## [1.0.0] — 2026-02-21

### Added
- **5-phase analysis pipeline:** pre-flight checks, repo discovery, structure analysis, content analysis (opt-in), hook opportunities, report generation
- **Structure analysis:** file organization, glob pattern optimization, source name quality
- **Content analysis** (with `--deep`): title quality, chunking compatibility, semantic density, metadata opportunities, i18n structure
- **Hook recommendations** with implementation sketches: breadcrumb enrichment, metadata injection, category mapping, cross-reference resolution, custom title construction
- **RAG-readiness grading** (A-F) with criteria tied to pipeline mechanics
- **10 common anti-patterns:** monolith files, generic titles, orphan tables, changelog noise, duplicate content, ID filenames, deep nesting without breadcrumbs, mixed concerns, code-heavy docs, frontmatter waste
- **Pre-flight checks** for `gh auth status` and private repo access
- **Early exit** for code-only repos (<5% indexable content)
- **Smart file sampling** for deep analysis: one per directory, prioritized by size and recency (up to 20 files)
- **Recommended connector config** with optimal glob pattern and estimated chunk count
- **Pre-ingestion checklist** covering titles, file size, glob patterns, filenames, translations, and priority documents
- **Pipeline knowledge** embedded: chunking (512 chars, sentence boundaries, title prepending), embedding (text-embedding-3-small), retrieval (pgvector, parent doc retrieval ≤30 chunks), GitHub connector (SHA-based incremental sync), project hooks
