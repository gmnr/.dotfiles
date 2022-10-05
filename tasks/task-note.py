#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Manage Taskwarrior notes
"""


import argparse
import os
import sys

NOTES_DIR = "~/.notes/task-notes"
EDITOR = os.environ["EDITOR"]

def write_note(task_id: int):
    """Open `$EDITOR` to take notes about task with ID `task_id`."""
    task_uuid = os.popen(f"task _get {task_id}.uuid").read().rstrip()

    if not task_uuid:
        sys.exit(1)

    notes_dir = os.path.expanduser(NOTES_DIR)
    os.makedirs(notes_dir, exist_ok=True)
    notes_basename = f"{task_uuid}.md"
    notes_file = os.path.join(notes_dir, notes_basename)

    if not os.path.exists(notes_file):
        task_description = os.popen(f"task _get {task_id}.description").read()

        with open(notes_file, "w") as f:
            f.write(f"# {task_description}\n")

    os.execlp(EDITOR, EDITOR, notes_file)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Write Taskwarrior notes")
    parser.add_argument('task_id', metavar='ID', type=int, help="ID of the task to note")
    args = parser.parse_args()

    write_note(args.task_id)
