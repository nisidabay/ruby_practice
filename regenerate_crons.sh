#!/usr/bin/env bash
# Regenerate Fibonacci study reminders
set -euo pipefail
cd "$(dirname "$0")"
exec ./regenerate_crons.py
