#!/bin/bash
assert() {
  expected="$1"
  input="$2"

  ./9cc "$input" > tmp.s
  cc -o tmp tmp.s
  ./tmp
  actual="$?"

  if [ "$actual" = "$expected" ]; then
    echo "$input => $actual"
  else
    echo "$input => $expected expected, but got $actual"
    exit 1
  fi
}

assert 0 0
assert 42 42
assert 21 "5+20-4"
assert 42 " 12 + 34 - 4 "
assert 47 '5+6*7'
assert 15 '5*(9-6)'
assert 4 '(3+5)/2'
assert 10 '-10+20'
assert 30 '- -30'
assert 10 '-3*-5+-5'

assert 0 '8==9'
assert 1 '10==10'

assert 1 '8!=9'
assert 0 '10!=10'

assert 1 '2 < 3';
assert 0 '3 < 2';

assert 0 '2 > 3';
assert 1 '3 > 2';

assert 1 '2 <= 2'
assert 1 '2 <= 3'
assert 0 '3 <= 2'

assert 1 '2 >= 2'
assert 0 '2 >= 3'
assert 1 '3 >= 2'

echo OK