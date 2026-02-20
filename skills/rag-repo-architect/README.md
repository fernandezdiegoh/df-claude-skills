# rag-repo-architect

> Analyze and optimize GitHub repository structure for RAG ingestion.

## What it does

Audits a GitHub repo's file organization, naming, content structure, and metadata opportunities — then produces actionable recommendations to maximize retrieval quality when ingested into the RAG pipeline.

Understands the full pipeline: chunking (512 chars, sentence boundaries, title prepending), embedding (OpenAI text-embedding-3-small), retrieval (pgvector cosine similarity, parent doc retrieval for ≤30-chunk sources), and project hooks.

## Usage

```
/rag-repo-architect sovrahq/docs                          # Quick structure audit
/rag-repo-architect sovrahq/docs --deep                    # + content analysis
/rag-repo-architect sovrahq/docs --pattern "docs/**/*.md"  # Focus on specific files
/rag-repo-architect sovrahq/docs --branch develop          # Specific branch
```

## What you get

- **RAG-readiness grade** (A-F) with rationale
- **Connector config** recommendation (glob pattern, estimated chunks)
- **Structure findings** (file organization, naming, granularity)
- **Content findings** (titles, chunking compatibility, semantic density) — with `--deep`
- **Hook recommendations** (breadcrumbs, metadata injection, category mapping)
- **Quick wins** (high-impact, low-effort changes to do first)
- **Pre-ingestion checklist**

## Key concepts

| Concept | Why it matters |
|---------|---------------|
| File titles (`# ` heading) | Prepended to EVERY chunk from that file — must be descriptive |
| File size | Sources with ≤30 chunks get full-context retrieval; split large files |
| Filenames | Become the `source` column in chunks — users see these |
| Directory structure | Can be leveraged via hooks for breadcrumb enrichment |
| Frontmatter | Can be extracted via hooks into chunk metadata for filtering |
| `filter_value` | Auto-routes queries to the right content subset via keyword detection |
| `priority` flag | Lowers similarity threshold so critical docs surface even on marginal matches |
