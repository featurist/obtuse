# Obtuse

Obtuse makes README driven development executable, by ensuring that your README.md is generated by tests.

## How it works

Obtuse operates on pairs of files, the first being an executable file, such as `feature.pogo`
and the second being the description of the feature, `feature.md`.
Obtuse simply executes the executable file, and ensures that its output matches the description.
If it does, no problem, if it doesn't, it prints out the differences.