#!/usr/bin/python

from pathlib import Path
import sys


link_path = Path("/home/dave/.config/starship.toml")
themes_dir = Path("/home/dave/.config/starship/themes/")
cmd = sys.argv[1]

if cmd == "set":
    if link_path.exists():
        try:
            f = Path(link_path)
            f.unlink()
        except Exception as e:
            print(f"[ERROR] removal of {link_path} failed: {e}")
    
    new_theme_arg = sys.argv[2]
    
    found = False
    for f in Path(themes_dir).iterdir():
        if f.name.startswith(new_theme_arg):
            try:
                link = Path(link_path)
                link.symlink_to(themes_dir / f)
                print(f"Theme set to {f.stem}")
                found = True
            except Exception as e:
                print(f"[ERROR] Failed to create link at {link_path} for {themes_dir / f}: {e}")
            break
    if not found:
        print(f"[ERROR] No theme name found starting with {new_theme_arg}")
elif cmd == "current":
    target = Path(link_path)
    if target.exists():
        print(f"Current theme is: {target.readlink().stem}")
    else:
        print(f"Symlink '{target.resolve()}' does not exist")
elif cmd == "list":
    for f in sorted(list(Path(themes_dir).iterdir())):
        print("- " + f.stem)
elif cmd == "help":
    cmds = ["set", "current", "list", "help"]
    print("Usage: ./change_theme.py <cmd> [option]")
    print("available commands:")
    for cmd in cmds:
        print("- " + cmd)
else:
    print(f"[ERROR] Command unknown: {cmd}, use 'help' for available commands")

