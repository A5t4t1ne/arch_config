#!/usr/bin/python

import os
from pathlib import Path
import sys


link_path = Path("/home/dave/.config/starship.toml")
cmd = sys.argv[1]

if cmd == "set":
    if link_path.exists():
        try:
            os.remove(link_path)
        except Exception as e:
            print(f"[ERROR] removal of {link_path} failed: {e}")
    else:
        print(f"[INFO] {link_path} not found, did not remove")
    
    
    themes_dir = Path("/home/dave/.config/starship/themes/")
    new_theme_arg = sys.argv[2]
    
    for f in os.listdir(themes_dir):
        if f.startswith(new_theme_arg):
            try:
                os.symlink(themes_dir / f, link_path)
            except Exception as e:
                print(f"[ERROR] Failed to create link at {link_path} for {themes_dir / f}: {e}")
    
            break
elif cmd == "get":
    target = Path(os.readlink(link_path))
    if target.is_
else:
    print(f"[ERROR] Command unknown: {cmd}")

