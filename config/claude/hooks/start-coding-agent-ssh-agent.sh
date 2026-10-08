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

# Machines without the key have nothing to sign with
[ -f "${key}" ] || exit 0

# ssh-add -l exits with 0 when the agent holds keys, 1 when it holds none,
# and 2 when no agent listens on the socket
status=0
SSH_AUTH_SOCK=${socket} ssh-add -l > /dev/null 2>&1 || status=$?

if [ "${status}" -eq 0 ]; then
    exit 0
fi

if [ "${status}" -eq 2 ]; then
    mkdir -p "${socket_dir}"
    chmod 700 "${socket_dir}"
    # A socket left by an agent that stopped would block binding the path
    rm -f "${socket}"
    ssh-agent -a "${socket}" > /dev/null
fi

# The standard output of a SessionStart hook is added to the context, so keep
# it quiet
SSH_AUTH_SOCK=${socket} ssh-add -q "${key}"
