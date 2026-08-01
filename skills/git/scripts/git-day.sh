#!/usr/bin/env bash
# git-day.sh — Quick daily Git workflow helpers
# Usage: ./scripts/git-day.sh <command> [args]
#
# Commands:
#   start <branch>   — Create a feature branch off main (or current branch)
#   sync             — Pull latest with rebase, push current branch
#   publish          — Push branch and set upstream
#   finish           — Switch to main, pull, delete feature branch
#   squash <n>       — Interactive rebase to squash the last <n> commits
#   log              — Show a compact log of the last 20 commits

set -euo pipefail

COMMAND="${1:-help}"

case "$COMMAND" in
  start)
    BRANCH="${2:-}"
    if [ -z "$BRANCH" ]; then
      echo "Usage: $0 start <branch-name>"
      exit 1
    fi
    BASE="main"
    # fall back to master if main doesn't exist
    if ! git show-ref --verify --quiet refs/heads/main; then
      BASE="master"
    fi
    echo "⟳  Creating branch '$BRANCH' off '$BASE'..."
    git checkout "$BASE"
    git pull --rebase
    git checkout -b "$BRANCH"
    echo "✓  On branch '$BRANCH' — ready to work."
    ;;
  sync)
    BRANCH=$(git branch --show-current)
    echo "⟳  Syncing '$BRANCH' with remote..."
    git pull --rebase
    git push
    echo "✓  '$BRANCH' is up to date and pushed."
    ;;
  publish)
    BRANCH=$(git branch --show-current)
    echo "⟳  Publishing '$BRANCH' to origin..."
    git push -u origin "$BRANCH"
    echo "✓  '$BRANCH' published to origin."
    ;;
  finish)
    BRANCH=$(git branch --show-current)
    BASE="main"
    if ! git show-ref --verify --quiet refs/heads/main; then
      BASE="master"
    fi
    echo "⟳  Finishing branch '$BRANCH'..."
    git checkout "$BASE"
    git pull --rebase
    git branch -d "$BRANCH"
    echo "✓  Back on '$BASE', branch '$BRANCH' deleted."
    ;;
  squash)
    N="${2:-2}"
    echo "⟳  Squashing last $N commits..."
    git rebase -i HEAD~"$N"
    ;;
  log)
    git log --oneline --graph --all --decorate -20
    ;;
  help|*)
    echo "Usage: $0 <command> [args]"
    echo ""
    echo "Commands:"
    echo "  start <branch>   Create a feature branch off main"
    echo "  sync             Pull with rebase + push"
    echo "  publish          Push and set upstream"
    echo "  finish           Merge back to main and delete branch"
    echo "  squash <n>       Squash last n commits interactively"
    echo "  log              Show compact commit log"
    ;;
esac
