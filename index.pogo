program = require 'commander'.parse(process.argv)
exec = require 'child_process'.exec
fs = require 'fs'
diff = require 'diff'
colors = require 'colors'

remove ext from (filename) =
    filename.replace r/\.[^.]*$/ ''

markdown for (filename) =
    "#(remove ext from (filename)).md"

// sorry, bug in pogo async
process.next tick!()

file (filename) exists (callback) =
    fs.exists (filename) @(exists)
        callback (nil, exists)

show differences between expected (expected) and actual (actual) =
    console.log "showing differences between #(expected.filename.red) and #(actual.filename.green)"

    differences = diff.diff lines (expected.contents, actual.contents)

    for each @(difference) in (differences)
        if (difference.added)
            process.stdout.write (("+" + difference.value).green)
        else if (difference.removed)
            process.stdout.write (("-" + difference.value).red)
        else
            process.stdout.write (difference.value)

for each @(filename) in (program.args)
    actual = {filename = filename}
    actual.contents = exec! "pogo #(filename)"
    expected = {filename = markdown for (filename)}
    if (file (expected.filename) exists!)
        expected.contents = fs.read file! (expected.filename, 'utf-8')
        if (expected.contents != actual.contents)
            show differences between expected (expected) and actual (actual)
    else
        fs.write file! (md filename, 'utf-8', output)
