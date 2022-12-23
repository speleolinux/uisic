# UISIC Test Repo

This is just a test repo for UISIC projects.

## Description of Files & Directories

| File                  | Description |
| ----                  | ----------- |
| LICENSE               | Copy of the GNU GPL 3 License.             |
| test_glossary.jsonld  | A JSON-LD file to play with.               |
| languages/Contents.md | Contents page with links to languages.     |
| languages/en.md       | Test of an English language Markdown file. |
| languages/fr.md       | Test of a French language Markdown file.   |
| lextables/            | Contains test language CSV files.          |
| mkdocs.yml            | Main file for a MkDocs site.               |
| docs/                 | Contains pages for the MkDocs site.        |
| mkdocs_ci.yml         | A CI job to build the MkDocs site.         |

## Translating the Language Files

Each language is in a separate file under the directory `languages`. The file
naming follows the ISO 639-1 codes. Those wishing to translate glossary terms
and definitions just need to edit their own language file.

## Miscellaneous Notes

Each language glossary will need to have the entries ordered by the character
ordering i.e.collation of the language code used. This is set by the `LC_COLLATE`
variable.

## This Projects Github Page(s)

A TEST projects page(s) is at: <https://speleolinux.github.io/uisic/>.
This is just to test how in the future it could be auto generated from
the data in this repo. There is a `gh-pages` branch for this.

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

