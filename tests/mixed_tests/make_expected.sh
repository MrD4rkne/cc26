#!/bin/bash
# Regenerates NN_*.out from CPython. Tests other than 01 don't import
# input_int, so this harness provides it (and a `runtime` module for 01).
cd "$(dirname "$0")"
for p in [0-9][0-9]_*.py; do
    n=${p%.py}
    python3 -I -c "
import sys, types
def input_int(): return int(input())
rt = types.ModuleType('runtime'); rt.input_int = input_int; sys.modules['runtime'] = rt
src = open('$p').read()
exec(compile(src, '$p', 'exec'), {'input_int': input_int, '__name__': '__main__'})
" < "$n.in" > "$n.out" || { echo "CPython failed on $p"; exit 1; }
done
