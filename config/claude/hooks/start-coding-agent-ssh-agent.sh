#!/bin/sh
#
# Start the ssh-agent that signs commits made by coding agents, and load the
# coding agent signing key into it.
#
# Hooks run outside the Bash sandbox, so this script can read the key file
# while commands run by agents cannot. Agents sign through the socket, which
# the sandbox allows, and never see the key itself.
#
# The agent keeps running after the session ends, so later sessions reuse it.

set -eu

key=${HOME}/.ssh/id_ed25519_coding_agent_signing
socket_dir=${HOME}/.local/state/coding-agent
socket=${socket_dir}/ssh-agent.sock
lock=${socket_dir}/ssh-agent.lock

if [ ! -f "${key}" ]; then
    echo "${key} does not exist, so commits by coding agents cannot be signed. See the dotfiles README to create it." >&2
    exit 1
fi

mkdir -p "${socket_dir}"
chmod 700 "${socket_dir}"

# Sessions started at the same time run this hook concurrently. mkdir is
# atomic, so only one of them starts the agent while the others wait.
attempts=0
until mkdir "${lock}" 2> /dev/null; do
    attempts=$((attempts + 1))
    if [ "${attempts}" -ge 50 ]; then
        echo "Timed out waiting for ${lock}. Remove it if no session is starting." >&2
        exit 1
    fi
    sleep 0.1
done
trap 'rmdir "${lock}"' EXIT

# ssh-add -T exits with 0 only when the agent holds the key matching the given
# public key, so an agent holding another key, such as one replaced by a newer
# key, gets the current key loaded
if SSH_AUTH_SOCK=${socket} ssh-add -T "${key}.pub" > /dev/null 2>&1; then
    exit 0
fi

# ssh-add -l exits with 2 when no agent listens on the socket
status=0
SSH_AUTH_SOCK=${socket} ssh-add -l > /dev/null 2>&1 || status=$?
if [ "${status}" -eq 2 ]; then
    # A socket left by an agent that stopped would block binding the path
    rm -f "${socket}"
    ssh-agent -a "${socket}" > /dev/null
fi

# The standard output of a SessionStart hook is added to the context, so keep
# it quiet
SSH_AUTH_SOCK=${socket} ssh-add -q "${key}"
