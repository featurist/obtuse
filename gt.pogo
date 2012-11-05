require './given'
require 'should'
pogo = require 'pogo'

fib (n) =
    if (n == 0)
        0
    else if (n == 1)
        1
    else
        fib (n - 1) + fib (n - 2)

fibonacci works () =
    fib 0.should.equal 0
    fib 1.should.equal 1
    fib 2.should.equal 1
    fib 3.should.equal 2
    fib 4.should.equal 3
    fib 5.should.equal 5

line '## Fibonacci'
line ''
line 'fibonacci is a function that generates the fibonacci number for the index given' if
    fibonacci works ()

line 'here are some examples:'
line ''

generate
    fib expr (expr) =
        result = pogo.evaluate (expr, definitions: {fib = fib})
        line "    #(expr) == #(result)"

    for each @(n) in [0, 1, 2, 5, 10, 20]
        fib expr "fib #(n)"
