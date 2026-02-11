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

### Option A: Symlinks (recommended)

Create symlinks from your project to the cloned repo. Updates via `git pull` are picked up automatically:

```bash
ln -s <path-to>/df-claude-skills/skills/<skill-name> <your-project>/.claude/skills/<skill-name>
```

Or all at once:

```bash
for skill in <path-to>/df-claude-skills/skills/*/; do
  ln -s "$skill" <your-project>/.claude/skills/$(basename "$skill")
done
```

### Option B: --add-dir flag

Launch Claude Code with the repo as an additional directory. Skills are loaded automatically with live change detection:

```bash
claude --add-dir <path-to>/df-claude-skills
```

Note: this flag must be passed every time you launch Claude Code.

### Option C: Copy (no auto-updates)

Copy skills into your project. You'll need to re-copy after each update:

```bash
cp -r <path-to>/df-claude-skills/skills/<skill-name> <your-project>/.claude/skills/
```

## Usage

From Claude Code, invoke with `/<skill-name>`:

- `/pr-review` — review a PR
- `/codebase-audit` — full codebase audit
- `/frontend-design` — design and build frontend interfaces
- `/documentation-expert` — create or improve documentation
