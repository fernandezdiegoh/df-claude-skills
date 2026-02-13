# df-claude-skills

Custom skills for Claude Code. Optimized to detect patterns in LLM-generated code.

## Available skills

| Skill | Description | Version |
|-------|-------------|---------|
| [`codebase-audit`](skills/codebase-audit/) | Full audit — architecture, security, tech debt, remediation roadmap | 3.8.0 |
| [`pr-review`](skills/pr-review/) | Rigorous PR review, assumes problems exist until proven otherwise | 2.1.0 |
| [`frontend-design`](skills/frontend-design/) | Distinctive, production-grade frontend interfaces | 1.0.0 |
| [`documentation-expert`](skills/documentation-expert/) | Audit, create, and improve docs — detects stale content and LLM filler | 3.0.0 |

## Installation

Clone this repo alongside your projects:

```bash
git clone git@github.com:fernandezdiegoh/df-claude-skills.git
```

### Option A: Sync script (recommended)

Claude Code does not follow symlinks for skill discovery, so copies are required. This repo includes a sync script that handles this.

From your target project's root:

```bash
<path-to>/df-claude-skills/scripts/sync-skills.sh
```

Or sync to a specific project:

```bash
<path-to>/df-claude-skills/scripts/sync-skills.sh /path/to/my-project
```

The script copies all skills to `.claude/skills/`, stripping READMEs and examples that Claude doesn't need.

Add `.claude/skills/` to your project's `.gitignore` — skills are local copies, not committed to the target repo.

### Option B: --add-dir flag

Launch Claude Code with the repo as an additional directory:

```bash
claude --add-dir <path-to>/df-claude-skills
```

Note: this flag must be passed every time you launch Claude Code.

### Option C: Manual copy

Copy skills into your project manually:

```bash
cp -r <path-to>/df-claude-skills/skills/* <your-project>/.claude/skills/
```

## Updating skills

1. Edit skills in this repo, commit, push
2. In each project: `git pull` the skills repo, then run `./scripts/sync-skills.sh`
3. Restart Claude Code to pick up changes

## Usage

From Claude Code, invoke with `/<skill-name>`:

- `/pr-review` — review a PR
- `/codebase-audit` — full codebase audit
- `/frontend-design` — design and build frontend interfaces
- `/documentation-expert` — create or improve documentation
