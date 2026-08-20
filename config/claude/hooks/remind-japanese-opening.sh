#!/bin/bash

# Keep the opening of each turn in Japanese.
#
# The first tokens of a reply follow the language of the surrounding context
# before the instructions are consulted, so an English system prompt or tool
# output pulls the opening into English even when CLAUDE.md sits nearby.
# UserPromptSubmit injects right before generation begins, which is the only
# position early enough to reach those first tokens.
#
# The reminder names the opening rather than restating the whole rule: CLAUDE.md
# already carries the rule, and what fails is the start of the turn.

set -euo pipefail

cat <<'JSON'
{
  "hookSpecificOutput": {
    "hookEventName": "UserPromptSubmit",
    "additionalContext": "返答は日本語で書き始めてください。最初のトークンから日本語にすること。"
  }
}
JSON
