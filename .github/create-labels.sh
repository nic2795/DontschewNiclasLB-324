#!/usr/bin/env bash
# Einmalig ausführen, nachdem das Repo auf github.com existiert und
# du lokal mit der GitHub CLI eingeloggt bist (gh auth login).
#
#   chmod +x .github/create-labels.sh
#   ./.github/create-labels.sh

set -e

gh label create "funktionale-anforderung" --color "1d76db" \
  --description "Funktionale Anforderung" --force
gh label create "qualitätsanforderung" --color "0e8a16" \
  --description "Qualitätsanforderung" --force
gh label create "randanforderung" --color "d93f0b" \
  --description "Randanforderung" --force

echo "Etiketten erstellt."
