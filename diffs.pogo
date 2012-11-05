exec = require 'child_process'.exec
require './given'
common = require './testCommon'

common.make file! 'hello.md' contain
    "# Hello World

     hello, world!
     "

common.make file! 'hello.pogo' contain
    "console.log '# Hello World'
     console.log ()
     console.log 'hello,'
     console.log 'world!'"

line '# Diffs
      
      When the test file produces content that is different to the description file, `obtuse` will output the differences:'

line ''

generate!
    common.in directory! '.test'
        text (common.indent (common.remove coloring from (exec! 'pogo ../index.pogo hello.pogo')))
