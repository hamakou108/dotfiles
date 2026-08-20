#!/bin/bash

# Re-inject the global instructions after the context has been replaced.
#
# CLAUDE.md is loaded once near the top of the context. Compaction, resume,
# clear, and fork all replace that context, leaving the instructions distant or
# absent while the freshly written summary dominates. SessionStart passes stdout
# straight into the context, so printing the file restores the instructions at
# the nearest possible position.

set -euo pipefail

cat "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/../CLAUDE.md"
