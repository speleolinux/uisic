# UISIC Test Repo

This is just a test repo for UISIC projects. Currently its being used to test a
continuous intergartion (CI)


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
| languages/            | Contains short extracts from Malcolm Field's lexicon.     |
| lextables/            | Contains some language CSV files from the Cavers Multi-lingual Dictionary. |
| mfield_data/          | Contains CSV & Markdown of some of Malcolm Field's lexicon. | 

## Translating Language Files

Each language is in a separate file under the directory `languages`. The file
naming follows the ISO 639-1 codes. Those wishing to translate glossary terms
and definitions would just need to edit their own language file.

## Miscellaneous Notes

Each language dictionary or glossary will need to have the entries ordered by
the character ordering i.e.collation of the language code used. This is set by
the `LC_COLLATE` variable.

## This Projects Github Page(s)

A TEST projects page(s) is at: <https://speleolinux.github.io/uisic/>.
This is just to test how in the future it could be auto generated from
the data in this repo. There is a `gh-pages` branch for this.

## External Resources

The python code to convert Malcolm Field's karst Lexicon to workable CSV and
Markdown formats is here: <https://hg.sr.ht/~speleolinux/uisic_glossary>

Mike Lake    
November 2022

