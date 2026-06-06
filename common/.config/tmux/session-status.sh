#!/usr/bin/env bash
# Outputs: current_session_index/total_sessions session_name

CURRENT=$(tmux display-message -p '#{session_name}')
TOTAL=$(tmux list-sessions | wc -l | tr -d ' ')
INDEX=$(tmux list-sessions -F '#{session_name}' | awk -v curr="$CURRENT" '$0 == curr {print NR; exit}')

echo "${INDEX}/${TOTAL} ${CURRENT}"
