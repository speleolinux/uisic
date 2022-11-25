# UISIC Test Repo

This is just a test repo for UISIC projects.

## Description of Files & Directories

| File                  | Description |
| ----                  | ----------- |
| LICENSE               | Copy of the GNU GPL 3 License.    |
| test_glossary.jsonld  | A JSON-LD file to play with.      |
| mkdocs.yml            | Main file for a MkDocs site.      |
| docs/                 | Contains pages for a MkDocs site. |
| mkdocs_ci.yml         | A CI job to build a MkDocs site.  |

## This Projects Github Page(s)

The projects page(s) are at: <https://speleolinux.github.io/uisic/>.
There is a `gh-pages` branch for this.

### To Use a Single Page

Ensure the `gh-pages` branch contains the `index.html` page.

### To use a MkDocs Site

The docs directory contains pages suitable for a MkDocs site.
See the `mkdocs.yaml` file for this. If you wish to build that site 
as a CI job then copy the `mkdocs_ci.yml` to `.github/workflows/ci.yml`
and push the change.

## External Resources

The python code to convert Malcolm Field's karst Lexicon to workable CSV and
Markdown formats is here: <https://hg.sr.ht/~speleolinux/uisic_glossary>

Mike Lake    
November 2022

