#!/bin/bash
#
# Render ~/.claude/settings.json from config/claude/settings.json.
#
# The output is a regular file rather than a symlink to the template, so that
# tools writing to it (Claude Code's /config, herdr's integration installer)
# leave their changes on this machine instead of in this repository.
#
# `${HOME}` in any string is replaced with the home directory, because Claude
# Code does not expand variables in settings files.
#
# When the existing file differs from the rendered settings, the difference is
# printed and the existing file is backed up before it is overwritten.

set -euo pipefail

# Without the rendered file, Claude Code starts with no sandbox or deny rules
if ! command -v jq > /dev/null; then
    echo "jq is required to render Claude Code settings" >&2
    exit 1
fi

dotfiles_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
claude_dir=${CLAUDE_CONFIG_DIR:-${HOME}/.claude}

template=${dotfiles_dir}/config/claude/settings.json
output=${claude_dir}/settings.json

rendered=$(jq --arg home "${HOME}" \
    'walk(if type == "string" then gsub("\\$\\{HOME\\}"; $home) else . end)' \
    "${template}")

if [[ -e ${output} ]]; then
    if diff -u \
        --label "${output} (current)" <(jq -S . "${output}") \
        --label "${output} (rendered)" <(echo "${rendered}" | jq -S .); then
        # Keep the output a regular file, so a symlink is replaced even
        # without differences
        [[ -L ${output} ]] || exit 0
    else
        backup=$(mktemp "${output}.$(date +%Y%m%d%H%M%S).XXXXXX")
        # Copy the content even when the output is a symlink
        cp -L "${output}" "${backup}"
        echo "Backed up ${output} to ${backup}"
    fi
fi

mkdir -p "${claude_dir}"
tmp=$(mktemp "${claude_dir}/settings.json.XXXXXX")
echo "${rendered}" > "${tmp}"
# Replace a symlink as well as a regular file
mv -f "${tmp}" "${output}"
echo "Rendered ${output}"
