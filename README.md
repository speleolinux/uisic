# UISIC Test Repo

This is just a test repo for UISIC projects. Currently its being used to test a
continuous integration (CI) build of a glossary.

[![Publish Glossary](https://github.com/speleolinux/uisic/actions/workflows/ci.yml/badge.svg)](https://github.com/speleolinux/uisic/actions/)
&nbsp; &nbsp; 
<!--
![Github Pages](https://github.com/speleolinux/uisic/actions/workflows/ci.yml/badge.svg?branch=gh-pages)
-->

## Description of Files & Directories

Each directory contains a README.md file describing in more details the
contents of that directory.

| File                  | Description |
| ----                  | ----------- |
| LICENSE               | Copy of the GNU GPL 3 License.                            |
| VERSION               | Update this version file to trigger the CI build.         |
| make_html.sh          | bash script used by the CI build.                         |
| assets/               | Contains HTML code and styles for the CI build.           |
| docs/                 | Contains the generated HTML index from the CI build.      |
| languages/            | Contains short extracts from Malcolm Field's lexicon.     |
| lextables/            | Contains some language CSV files from the Cavers Multi-lingual Dictionary. |
| mfield_data/          | Contains CSV & Markdown of some of Malcolm Field's lexicon. | 

## Continuous Integration & Github Pages

There is a CI file `.github/workflows/ci.yml`. At present just read that.
I'll put more details here shortly. 

Basically the CI will trigger when the file VERSION is updated. It will run the
script `make_html.sh` which will build the a HTML format glossary from Malcolm
Field's markdown format.

This HTML page will then be published from the  `gh-pages` branch to the Github
pages site here: <https://speleolinux.github.io/uisic/>.

This is just to test how in the future it could be auto generated from
the data in this repo.

## Miscellaneous Notes

### Language Files

Each language is in a separate file under the directory `languages`. The file
naming follows the ISO 639-1 codes. Those wishing to translate glossary terms
and definitions would just need to edit their own language file.

Each language dictionary or glossary will need to have the entries ordered by
the character ordering i.e.collation of the language code used. This is set by
the `LC_COLLATE` variable.

## External Resources

The python code to convert Malcolm Field's karst Lexicon to workable CSV and
Markdown formats is here: <https://hg.sr.ht/~speleolinux/uisic_glossary>

Mike Lake    
November 2022

