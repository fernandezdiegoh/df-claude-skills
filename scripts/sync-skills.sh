#!/usr/bin/env bash
set -euo pipefail

# Sync skills from df-claude-skills repo into a target project.
#
# Usage:
#   ./scripts/sync-skills.sh                        # sync to current git project's .claude/skills/
#   ./scripts/sync-skills.sh /path/to/project       # sync to a specific project
#   SKILLS_TARGET=.claude/skills ./scripts/sync-skills.sh  # override target subdirectory

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$(cd "$SCRIPT_DIR/../skills" && pwd)"

# Determine target project root
if [[ -n "${1:-}" ]]; then
  PROJECT_ROOT="$1"
else
  PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
fi

TARGET_SUBDIR="${SKILLS_TARGET:-.claude/skills}"
TARGET_DIR="$PROJECT_ROOT/$TARGET_SUBDIR"

# Safety check
if [[ "$SKILLS_DIR" == "$TARGET_DIR"* ]]; then
  echo "Error: target directory is inside the skills repo. Aborting."
  exit 1
fi

# Sync
mkdir -p "$TARGET_DIR"
rm -rf "${TARGET_DIR:?}"/*
cp -r "$SKILLS_DIR"/* "$TARGET_DIR"

# Remove files that Claude doesn't need (READMEs, examples)
find "$TARGET_DIR" -name "README.md" -delete 2>/dev/null || true
find "$TARGET_DIR" -name "examples" -type d -exec rm -rf {} + 2>/dev/null || true

# Count synced skills
SKILL_COUNT=$(find "$TARGET_DIR" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')
echo "Synced $SKILL_COUNT skills to $TARGET_DIR"
echo "Restart Claude Code to pick up changes."
