# scripts/check_version.py

import sys
from packaging.version import parse as V

def main(pr_version: str, main_version: str):
    pr_v = V(pr_version)
    main_v = V(main_version)

    if pr_v <= main_v:
        sys.exit(f"Version must be greater than main (got {pr_v} <= {main_v})")

    print(f"Version bump OK: {pr_v} > {main_v}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: check_version.py <pr_version> <main_version>")
        sys.exit(1)

    pr_version = sys.argv[1]
    main_version = sys.argv[2]
    main(pr_version, main_version)
