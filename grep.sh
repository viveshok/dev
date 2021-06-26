
set -e

grep -Iinr $1 $2 \
    | grep -v 'mypy_cache' \
    | grep -v '\.pytest_cache' \
    | grep -v '\.ipynb' \
    | grep -v '\.pytype' \
    | grep -v '\.svg' \
    | grep -v '\.git' \
    | grep -v '\.html:' \
    | grep -v '_pb2'
