#!/usr/bin/env python3
# PYTHON_ARGCOMPLETE_OK

from pathlib import Path
import sys
import argparse


link_path = Path("/home/dave/.config/starship.toml")
themes_dir = Path("/home/dave/.config/starship/themes/")


def handle_set(args):
    if link_path.exists():
        try:
            f = Path(link_path)
            f.unlink()
        except Exception as e:
            print(f"[ERROR] removal of {link_path} failed:\n{e}")
    

    found = False
    theme = args.theme.split('/')[-1]
    for f in Path(themes_dir).iterdir():
        if f.name.startswith(theme):
            try:
                link = Path(link_path)
                link.symlink_to(themes_dir / f)
                print(f"Theme set to {f.stem}")
                found = True
            except Exception as e:
                print(f"[ERROR] Failed to create link at {link_path} for {themes_dir / f}:\n{e}")
            exit(1)
    if not found:
        print(f"[ERROR] No theme name found starting with {theme}")

def handle_current(_):
    target = Path(link_path)
    if target.exists():
        print(f"Current theme:\n{target.readlink().stem}")
    else:
        print(f"Symlink '{target.resolve()}' does not exist")

def handle_list(_):
    print("Available themes:")
    for f in sorted(list(Path(themes_dir).iterdir())):
        print("- " + f.stem)


def main():
    parser = argparse.ArgumentParser(description="Helper for changing Starship themes")

    subparsers = parser.add_subparsers(dest='command', required=True, help='Available commands')

    # 'set'
    set_parser = subparsers.add_parser('set', help='Set a new theme')
    set_parser.add_argument('theme', help='New theme name, with or without file-extension')
    set_parser.set_defaults(func=handle_set)

    # 'current'
    get_parser = subparsers.add_parser('current', help='Print current theme')
    get_parser.set_defaults(func=handle_current)

    # 'list'
    list_parser = subparsers.add_parser('list', help='List all available themes')
    list_parser.set_defaults(func=handle_list)

    # 'help'
    def print_full_help(_):
        parser.print_help()
        sys.exit(0)

    help_parser = subparsers.add_parser('help', help='Show this help message and exit')
    help_parser.set_defaults(func=print_full_help)

    args = parser.parse_args()
    args.func(args)

if __name__ == "__main__":
    main()




