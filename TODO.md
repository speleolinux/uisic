# TODO

This is a list of TODOs that Peter and Mike are attending to.
It is a quicker way to record stuff to do than the Issues list.    
The Unassigned section is for issues to be noted and later assigned to
someone.

## Unassigned

Inconsistent use of - or – for number range separator e.g.:

50–500mm deep    
1,000-3,000 mg/L    
3,000-10,000 mg/L    
10,000-35,000 mg/L

## Peter Matthews

PM Will be fixing the scientific equations in the main doc. Mike is doing some tests with a short version of the doc so we can decide 
if we wish to use standard HTML, MathML or MathJax.

## Mike Lake

Done:

- Chemical Formulas: I think all chemical formulas are now OK.
- Numbering / Ordering Issues: No current problems.
- Have added meta tags in header to prevent caching.
- Moved build date into header as a meta tag.
- Extracted license, notes and references to separate files. To be used later.

TODO: 

Currently `epa_mfield_2002_utf8.md` is under the `mfield_data` directory. 
Eventually this should be renamed to `glossary.md` and under a `glosssary` directory.
Then the `mfield_data` files can be archived.

Dictionary stuff should be under a `dictionary` directory. We should also rename the
`lextables` directory and place it under dictionary. The CSV files should have
lower case filenames.

Documentation will also need to be written for the updating and maintenance
procedures for the dictionary and glossary.

### Continuous Integration

I have commented out the *auto* updating of the glossary at <https://speleolinux.github.io/uisic/>
until I work out how to stop Github pages from running when it's not required.

A manual update can be triggered by clicking the "Actions" tab at the top.
Then on the left hand side, under "All workflow" click "Publish Glossary".
Then on the right hand side in the blue header will be a drop down "Run workflow".
Drop down that and click the button "Run workflow"

