#!/usr/bin/env bash
# Checks and tests every Odin package in the repository.
#
# Each section directory under knuth/ and each exercise directory under
# exercises/ is its own package, so there is no single program to build:
#
#   ./build.sh         type-check every package (odin check)
#   ./build.sh test    run every package that has a *_test.odin
#
# Flags verified against odin dev-2026-09.

set -euo pipefail

cd "$(dirname "$0")"

MODE="${1:-check}"

case "$MODE" in
	check|test) ;;
	*) echo "usage: $0 [check|test]" >&2; exit 2 ;;
esac

# Package directories: any directory directly containing a .odin file.
mapfile -t packages < <(find knuth exercises -name '*.odin' -printf '%h\n' 2>/dev/null | sort -u)

status=0
for pkg in "${packages[@]}"; do
	if [ "$MODE" = test ]; then
		compgen -G "$pkg/*_test.odin" > /dev/null || continue
		echo "== test $pkg"
		odin test "$pkg" -debug -vet -strict-style || status=1
	else
		echo "== check $pkg"
		odin check "$pkg" -no-entry-point -vet -strict-style || status=1
	fi
done

echo "${#packages[@]} package(s), $MODE $([ $status = 0 ] && echo ok || echo FAILED)"
exit $status
