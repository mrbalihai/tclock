setup () {

    # Don't screw up env variables if ran locally
    PREV_TCLOCK_FILE="$TCLOCK_FILE"
    export TCLOCK_FILE="./test/test.timeclock"
}

teardown () {
    TCLOCK_FILE="$PREV_TCLOCK_FILE"
    if [ -f ./test/test.timeclock ]; then
        rm ./test/test.timeclock
    fi
    unset PREV_TCLOCK_FILE
}

flunk() {
    { if [ "$#" -eq 0 ]; then
        cat -
      else
          echo "$@"
      fi
    } >&2
    return 1
}

assert_success() {
    if [ "$status" -ne 0 ]; then
        flunk "command failed with exit status $status"
    elif [ "$#" -gt 0 ]; then
        assert_output "$1"
    fi
}

assert_failure() {
    if [ "$status" -eq 0 ]; then
        flunk "expected failed exit status"
    elif [ "$#" -gt 0 ]; then
        assert_output "$1"
    fi
}

assert_equal() {
    if [ "$1" != "$2" ]; then
        { echo "expected: ${1}"
            echo "actual:   ${2}"
        } | flunk
    fi
}

assert_pattern() {
    if [[ ! "$1" =~ $2 ]]; then
        { echo "expected: ${1}"
            echo "actual:   ${2}"
        } | flunk
    fi
}

assert_contains() {
    if [ "$1" == *"$2"* ]; then
        { echo "expected: ${1}"
            echo "actual:   ${2}"
        } | flunk
    fi
}

assert_length () {
    local p1=$1
    local p2=$2
    if [ "${#p1}" -ne "${p2}" ]; then
        { echo "expected length: ${p2}"
            echo "actual length:   ${#p1}"
        } | flunk
    fi
}

assert_output() {
    local expected
    if [ $# -eq 0 ]; then expected="$(cat -)"
    else expected="$1"
    fi
    assert_equal "$expected" "$output"
}

assert_line () {
    if [ "$1" -ge 0 ] 2>/dev/null; then
        assert_equal "$2" "${lines[$1]}"
    else
        local line
        for line in "${lines[@]}"; do
            if [ "$line" = "$1" ]; then return 0; fi
        done
        flunk "expected line \`$1'"
    fi
}

assert_line_contains () {
    if [ "$1" -ge 0 ] 2>/dev/null; then
        assert_contains "${lines[$1]}" "$2"
    else
        local line
        for line in "${lines[@]}"; do
            if [ "$line" == *"$1"* ]; then return 0; fi
        done
        flunk "expected line \`$1'"
    fi
}

assert_line_pattern () {

    if [ "$1" -ge 0 ] 2>/dev/null; then
        assert_pattern "${lines[$1]}" "$2"
    else
        local line
        for line in "${lines[@]}"; do
            if [ "$line" =~ "$2" ]; then return 0; fi
        done
        flunk "expected line to match pattern \`$1'"
    fi
}

assert_line_length () {
    if [ "$1" -ge 0 ] 2>/dev/null; then
        assert_length ${lines[$1]} "$2"
    else
        flunk "No line number >1 specified"
    fi
}

assert_line_count () {
    local num_lines="${#lines[@]}"
    if [ "$1" -ne "$num_lines" ]; then
        flunk "output has $num_lines lines, not $1"
    fi
}

refute_line () {
    if [ "$1" -ge 0 ] 2>/dev/null; then
        local num_lines="${#lines[@]}"
        if [ "$1" -lt "$num_lines" ]; then
            flunk "output has $num_lines lines"
        fi
    else
        local line
        for line in "${lines[@]}"; do
            if [ "$line" = "$1" ]; then
                flunk "expected to not find line \`$line'"
            fi
        done
    fi
}

assert () {
    if ! "$@"; then
        flunk "failed: $@"
    fi
}

assert_file_doesnt_exist () {
    local file="$1"
    if [ -f $file ]; then
        { echo "file exists: ${1}"
        } | flunk
    fi
}

assert_file_exists () {
    local file="$1"
    if ![ -f $file ]; then
        { echo "file does not exist: ${1}"
        } | flunk
    fi
}
