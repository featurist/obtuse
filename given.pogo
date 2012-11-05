global.text (t) if (block) =
    no errors =
        try
            block ()
            true
        catch (error)
            process.stdout.write (error.to string ())
            false

    if (no errors)
        text =
            if (t :: Function)
                t ()
            else
                t

        process.stdout.write (text.to string ())

global.text (t) =
    process.stdout.write (t.to string ())

global.line (t) = text ((t || '') + "\n")
global.line if (t, args, ...) = text if (t + "\n", args, ...)

global.generate (block, callback) =
    block (callback)

global.obtuse (filename) =
    require ('./' + filename)
