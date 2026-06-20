#!/usr/bin/env bash
set -euo pipefail

VAULT="${VAULT:-}"
DRY_RUN=true
[ "${1:-}" = "--apply" ] && DRY_RUN=false

VAULT_FLAG=()
[ -n "$VAULT" ] && VAULT_FLAG=(--vault "$VAULT")

op item list "${VAULT_FLAG[@]}" --format=json | jq -r '.[].id' | while read -r id; do
  item=$(op item get "$id" --format=json)
  title=$(echo "$item" | jq -r '.title')
  url=$(echo "$item" | jq -r '.urls[0]?.href // empty')

  if [ -z "$url" ]; then
    echo "skip (no url): $title"
    continue
  fi

  host=$(echo "$url" | sed -E 's#^[a-zA-Z]+://##; s#/.*##; s#:.*##')
  username=$(echo "$item" | jq -r '.fields[]? | select(.id=="username") | .value // empty')

  if [ -n "$username" ]; then
    new_title="$host - $username"
  else
    new_title="$host"
  fi

  if [ "$title" = "$new_title" ]; then
    continue
  fi

  echo "$title  ->  $new_title"

  if [ "$DRY_RUN" = false ]; then
    op item edit "$id" --title "$new_title" >/dev/null
  fi
done
