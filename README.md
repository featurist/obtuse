# Obtuse

Obtuse makes README driven development executable, by ensuring that your README.md is generated by tests.

## How it works

Obtuse operates on pairs of files, the first being an executable file, such as `feature.pogo`
and the second being the description of the feature, `feature.md`.
Obtuse simply executes the executable file, and ensures that its output matches the description.
If it does, no problem, if it doesn't, it prints out the differences.

## An example

Lets say you're writing a small useful utility, for example, a utility that generates the fibonacci sequence up to a given number of values. A utility you could imagine using just about every day.

First you'd start by writing a description of how it worked in your `README.md`:

    # yo-fib: a command line tool for generating the fibonacci sequence

    `yo-fib` helps you generate the fibonacci sequence up to a specified number of values.

    usage: `yo-fib N`

    where `N` is the number of fibonacci numbers you want to generate.

Then you'd write a file that would generate the contents of the `README.md` file, based on testing that `yo-fib` works they way you described it, we call this `README.pogo`:

    exec = require 'child_process'.exec
    should = require 'should'

    text (s) =
        process.stdout.write (s)

    line (l) =
        console.log (l)

    yo fib generates the fibonacci sequence up to the specified number of values () =
        exec! './yo-fib 0'.should.equal ''
        exec! './yo-fib 1'.should.equal '0'
        exec! './yo-fib 2'.should.equal '0 1'
        exec! './yo-fib 3'.should.equal '0 1 1'
        exec! './yo-fib 4'.should.equal '0 1 1 2'
        exec! './yo-fib 10'.should.equal '0 1 1 2 3 5 8 13 21 34'

    given! (block) then (t) =
        try
            block!()
            text (t)
        catch (error)
            console.log (error)

    line '# yo-fib: a command line tool for generating the fibonacci sequence'
    line ''
    given!
        yo fib generates the fibonacci sequence up to the specified number of values! ()
    then '`yo-fib` helps you generate the fibonacci sequence up to a specified number of values.'
    line ''
    line ''
    line 'usage: `yo-fib N`

          where `N` is the number of fibonacci numbers you want to generate.'

Then you can run `pogo ../index.pogo README.pogo` and see if the behaviour of `yo-fib` matches that of the description. In this case, it will just have an exit code of 0, with no output.
