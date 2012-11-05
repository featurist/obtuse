fs = require 'fs'

test path (f) = ".test/#(f)"

exports.make file! (filename) contain (content block) =
    content = if (content block :: Function)
            content block! ()
        else
            content block

    fs.write file! (test path (filename), content, 'utf-8')

exports.remove coloring from (text) =
    text.replace(new (RegExp "\033\\[\\d+m" 'g'), '')

exports.indent (text) =
    text.replace r/^(.+[^\s].*)$/gm "    $1"


exports.in directory! (dir, block) =
    cwd = process.cwd ()
    console.log "CURRENT WORKING DIRECTORY #(cwd)"
    try
        process.chdir (dir)
        console.log "IN DIRECTORY #(process.cwd())"
        block! ()
    finally
        process.chdir (cwd)
        console.log "BACK IN DIRECTORY #(process.cwd())"
