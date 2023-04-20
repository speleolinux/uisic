# UISIC Test Repo

This is a test repo for some UISIC projects. Currently its being used to test a
continuous integration (CI) build of a cave science glossary.

Here is the [Cave and Karst Glossary](https://speleolinux.github.io/uisic/) test web page. 

The raw data for the glossary comes from the directory `glossary_content`; either 
the full data `glossary_table.md .md` or the short data `glossary_table_short.md`. 
Edit the `make_html.sh` script to select the data file.
The remaining content of the test web page comes from files in the `glossary_content`
and the `assets` directories.
The data is stored in Markdown format which is easy to edit and view. 

There is also a `VERSION` file in this repository. That should contain just a
single line with the date as YYYY-MM-DD e.g. "2023-04-19". This will be shown
on the web page as the "Published" date.

The Markdown data is transformed to this Cave and Karst Glossary test web page
whenever the Github action is initiated. 

This status image shows if the build of the Markdown data to the web page job has passed OK.    
[![Publish Glossary](https://github.com/speleolinux/uisic/actions/workflows/ci.yml/badge.svg)](https://github.com/speleolinux/uisic/actions/)

<!--
![Github Pages](https://github.com/speleolinux/uisic/actions/workflows/ci.yml/badge.svg?branch=gh-pages)
-->

## Description of Files & Directories

Each directory contains a README.md file describing in more details the
contents of that directory.

| File                  | Description |
| ----                  | ----------- |
| LICENSE               | Copy of the GNU GPL 3 License.                              |
| VERSION               | Update this version file to trigger the CI build.           |
| make_html.sh          | Bash script used by the CI build.                           |
| generate_dict.py      | Python script reads in lang tables, outputs dict.           |
| assets/               | Contains HTML code and styles for the CI build.             |
| glossary_content/     | Contains glossary data, and other content for the web page. |
| docs/                 | Contains the generated HTML index from the CI build.        |
| languages/            | Contains short extracts from Malcolm Field's lexicon.       |
| lextables/            | Contains some language CSV files from the Cavers Multi-lingual Dictionary. |
| utils/                | Contains some utility programs.                             |

## Continuous Integration & Github Pages

There is a CI file `.github/workflows/ci.yml`. At present just read that.
I'll put more details here shortly. 

Currently the CI is triggred manually from Github actions. 
It will run the script `make_html.sh` which will build the a HTML format
glossary from the Markdown format.
Later we may set the CI to trigger when the file VERSION is updated. 

This HTML page will then be published from the `gh-pages` branch to the Github
pages site here: <https://speleolinux.github.io/uisic/>.

In the future this should be published directly to the UISIC site or just 
copied from here and uploaded. No other manual HTML editing should be required.

## Miscellaneous Notes

### Language Files

These are not used here at present. They will be used later for the UISIC Cavers dictionary.

Each language is in a separate file under the directory `languages`. The file
naming follows the ISO 639-1 codes. Those wishing to translate glossary terms
and definitions would just need to edit their own language file.

Each language dictionary or glossary will need to have the entries ordered by
the character ordering i.e.collation of the language code used. This is set by
the `LC_COLLATE` variable.

## External Resources

The python code to convert Malcolm Field's karst Lexicon to workable CSV and
Markdown formats is here: <https://hg.sr.ht/~speleolinux/uisic_glossary>

## License

Note that license for this repository and code is the GNU General Public License v3.0.
The glossary itself, i.e. the content of the Markdown document, and the generated 
HTML document is released under the Creative Commons License
Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0).

Mike Lake & Peter Matthews        
November 2022

