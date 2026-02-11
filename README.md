# df-claude-skills

Custom skills for Claude Code. Optimized to detect patterns in LLM-generated code.

## Available skills

| Skill | Description | Version |
|-------|-------------|---------|
| `pr-review` | Rigorous PR review, assumes problems exist until proven otherwise | 1.2.0 |
| `codebase-audit` | Full audit — architecture, security, tech debt, remediation roadmap | 2.0.0 |
| `documentation-expert` | Technical documentation creation and maintenance | 1.0.0 |
| `frontend-design` | Distinctive, production-grade frontend interfaces | 1.0.0 |

## Installation

Clone this repo alongside your projects:

```bash
git clone git@github.com:fernandezdiegoh/df-claude-skills.git
```

### Option A: Sync script (recommended)

Add a sync script to your project that copies skills from the cloned repo. Claude Code does not follow symlinks for skill discovery, so copies are required.

Example `scripts/sync-skills.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

SKILLS_REPO="<path-to>/df-claude-skills/skills"

rm -rf .claude/skills/*
cp -r "$SKILLS_REPO"/* .claude/skills/

echo "Skills synced. Restart Claude Code to pick up changes."
```

Then add `.claude/skills/` to your project's `.gitignore` — skills are local copies, not committed to the repo.

After cloning or updating skills:

```bash
./scripts/sync-skills.sh
```

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
