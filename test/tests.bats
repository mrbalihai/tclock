#!/usr/bin/env bats

load test_helper

@test "Create in entry" {
    run ./tclock i test testing
    run cat ./test/test.timeclock

    assert_line_count 1
    assert_line_pattern 0 "^i [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2} test testing$"
}
@test "Create out entry" {
    run ./tclock o
    run cat ./test/test.timeclock

    assert_line_count 1
    assert_line_pattern 0 "^o [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$"
}

@test "Print active entry" {
    run ./tclock i test testing

    run ./tclock active

    assert_line_count 1
    assert_line_pattern 0 "^[0-9]{1,2}s test testing $"
}

@test "Print multiple active entries" {
    run ./tclock i test testing
    run ./tclock i test testing2

    run ./tclock active

    assert_line_count 2
    assert_line_pattern 0 "^[0-9]{1,2}s test testing $"
    assert_line_pattern 1 "^[0-9]{1,2}s test testing2 $"
}

@test "Print entries list" {
    run ./tclock i test testing
    run ./tclock o
    run ./tclock i test testing2
    run ./tclock o

    run ./tclock print

    assert_line_count 2
    assert_line_pattern 0 "^ +[0-9]{1,2}s test +testing$"
    assert_line_pattern 1 "^ +[0-9]{1,2}s test +testing2$"
}

@test "Print summary" {
    run ./tclock i test testing
    run ./tclock o
    run ./tclock i test testing2
    run ./tclock o

    run ./tclock summary

    assert_line_count 3
    assert_line_pattern 0 "^ +[0-9]{1,2}s test$"
    assert_line_pattern 1 "^---------------$"
    assert_line_pattern 2 "^ +[0-9]{1,2}s$"
}
