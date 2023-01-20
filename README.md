# UISIC Test Repo

This is a test repo for some UISIC projects. Currently its being used to test a
continuous integration (CI) build of a cave science glossary.


Here is the [Cave and Karst Glossary](https://speleolinux.github.io/uisic/) test web page. 
The raw data for this page comes from the directory `mfield_data/epa_mfield_2002_utf8_short.md` in this repository.
The raw data is stored in Markdown format which is easy to edit and view. 
The Markdown data is transformed to the web page [Cave and Karst Glossary](https://speleolinux.github.io/uisic/)
whenever the raw data and the file `VERSION` in this repository is updated.

[![Publish Glossary](https://github.com/speleolinux/uisic/actions/workflows/ci.yml/badge.svg)](https://github.com/speleolinux/uisic/actions/)
&nbsp; &nbsp; 
This status image shows if the transformation of the Markdown data to the web page job has suceeded OK.

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

### Build Issues

If you have made commits and the CI has run the merge will not succeed 
as the gh-pages branch has been changed. You then need to do a `git pull -rebase`
to fix the issue. How can we get rid of this issue for those not familiar with git?

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

