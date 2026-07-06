#!/usr/bin/env python3
"""Regenerate Fibonacci study reminders for this repo."""

import os, re, sys, shutil

REPO_DIR = os.path.dirname(os.path.abspath(__file__))
SCHEDULE_FILE = os.path.join(REPO_DIR, "learning_schedule.md")
QUEUE_DIR = os.path.join(REPO_DIR, ".fibonacci", "queue")

def parse_sessions() -> list[dict]:
    sessions = []
    with open(SCHEDULE_FILE) as f:
        lines = f.readlines()
    in_table = False
    for line in lines:
        line = line.strip()
        if line.startswith("|") and re.match(r"^\|\s*\d+", line):
            in_table = True
            parts = [p.strip() for p in line.split("|")]
            if len(parts) >= 5:
                sessions.append({
                    "num": parts[1],
                    "day": parts[2],
                    "unit": parts[3],
                    "activity": parts[4],
                })
        elif in_table and line.startswith("## "):
            break
    return sessions

def main():
    print("🧠 Regenerating Fibonacci plan...\n")
    if os.path.exists(QUEUE_DIR):
        shutil.rmtree(QUEUE_DIR)
    os.makedirs(QUEUE_DIR, exist_ok=True)
    sessions = parse_sessions()
    if not sessions:
        print("❌ No sessions found in learning_schedule.md")
        sys.exit(1)
    for s in sessions:
        fname = f"session_{int(s['num']):03d}.md"
        path = os.path.join(QUEUE_DIR, fname)
        content = f"""# Fibonacci Session {s['num']} — Day {s['day']}
## {s['unit']}
{s['activity']}
---
📁 Repo: {REPO_DIR}
✅ When you finish:
   rm .fibonacci/queue/{fname}
"""
        with open(path, "w") as f:
            f.write(content)
    print(f"✅ {len(sessions)} reminders generated in .fibonacci/queue/")
    print("📋 To see the next one: ls .fibonacci/queue/ | head -1")
    print("📋 To see how many remain: ls .fibonacci/queue/ | wc -l")
    print("💡 When you finish: rm .fibonacci/queue/session_NNN.md")

if __name__ == "__main__":
    main()
