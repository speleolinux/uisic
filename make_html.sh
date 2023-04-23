#!/bin/bash

# Script to generate HTML Glossary page from the Markdown input.
# This script is invoked by the CI workflow .github/workflows/ci.yml
# If it runs on Github as a CI job then it will create "docs/index.html".
# If it is run locally on your PC it will create "tmp/UIS_Glossary.html"
# It decides the above based on if the CI variable exists and is set.
# Usage: ./make_html.sh
#
# Author: Mike Lake
# Git repo: https://github.com/speleolinux/uisic
# Date: March 2023

# Assets such as styles, icons etc, plus header and footer.
styles="assets/styles.css"
header="assets/header.html"
footer="assets/footer.html"

# The main glossary table.
glossary_full="glossary_content/glossary_table.md"
glossary_short="glossary_content/glossary_table_short.md"

intro="glossary_content/intro.html"
references="glossary_content/references.md"
epa_intro="glossary_content/epa_intro.md"
license="glossary_content/license.md"
contact="glossary_content/contact.md"

# Final output file for publishing.
output="UIS_Glossary.html"

###########
# Functions
###########

function minify_css {
    # Minify the CSS styles.
    # The first sed removes the block css comments.
    # The tr squeezes spaces and removes new lines.
    # The final sed removes spaces after : and ; and {.
    cat $styles | \
    sed -r ':a; s%(.*)/\*.*\*/%\1%; ta; /\/\*/ !b; N; ba' \
    | tr -s '\t' ' ' | tr -s ' ' | tr -d '\n' \
    | sed 's/: /:/g' | sed 's/; /;/g' | sed 's/ { /{/g'
}

function print_header {
    # Print the HTML header.

    # This will be a build date that will be in the HTML header.
    # The H:M also ensures the file is changed.
    # Otherwise the index.html has not changed and the git push
    # will fail, reporting back that the CI has failed.
    today=$(date +"%Y-%m-%d %H:%M %Z")
    
    cat $header | sed "s/BUILD_DATE/$today/"
    echo "<!-- These CSS styles are included locally so that this page \
will still display OK when downloaded and used off-line. -->"
    echo '<style type="text/css">'
    minify_css
    echo '</style>'
    echo '</head>'
}

function print_intro {
    # Print the HTML introduction, replacing VERSION_DATE.

    # This will be the version that users see in the HTML page.
    version=$(cat VERSION)
    cat $intro | sed "s/VERSION_DATE/$version/"
}

function print_glossary {
    # Print the glossary table as HTML.

    local tmp="tmp.txt"

    # We use columns=10000 to reduce the column width on the term column.
    pandoc --columns=10000 --mathml -f markdown -t html $glossary > $tmp
    
    # This table needs a few things fixed.
    
    # 1. Replace line like this: <td>7</td>
    #    with line like this:    <td id="7">7</td>
    sed -i 's/<td>\([0-9]*\)<\/td>/<td id="\1">\1<\/td>/' $tmp
    
    # 2. Remove the even/odd classes on the rows.
    sed -i 's/ class="even"//' $tmp
    sed -i 's/ class="odd"//'  $tmp
    
    # Print output
    cat $tmp
    rm -f $tmp
}

function print_references {
    # Print the references as HTML.

    local tmp="tmp.txt"

    pandoc -f markdown -t html --strip-comments $references > $tmp

    # Replace lines in the temporary HTML file as follows: 
    #   <p>As extracted from ....              <== Do not change. 
    #   <p>1. Bates, R. L. and J. A. Jackson.  <== Change this.
    # with line like this: 
    #   <p id="ref1">Bates, R. L. and J. A. Jackson.
    # Match at the start a <p> followed by an integer, one or more times,
    # followed by a fullstop.
    cat $tmp | sed 's/^<p>\([0-9]\+\)\./<p id="ref\1">\1./'
    rm -f $tmp
}

######
# Main
######

# If $CI is set then we are running under Github's CI.
if [ -z "${CI+x}" ]; then
    # CI is unset or zero so we are running locally.
    # Use this shorter version of the glossary for testing.
    glossary="$glossary_short"
    echo "Using short $glossary as CI=$CI"
else
    # We are running at Gitlab via CI.
    glossary="$glossary_full"
fi

# Export our timezone so in the shell on the Github build,
# the timezone will be correct.
export TZ="Australia/Sydney"

# Write the HTML sections.
cat /dev/null    >  $output
print_header     >> $output
print_intro      >> $output
print_glossary   >> $output
print_references >> $output
pandoc -f markdown -t html $epa_intro >> $output
pandoc -f markdown -t html $license   >> $output
pandoc -f markdown -t html $contact   >> $output
cat $footer >> $output

# Move the HTML doc into the appropriate location.
if [ -z "${CI+x}" ]; then
    # CI is unset or zero so we are running locally.
    echo "Moving output to tmp/$output"
    mv $output tmp/
else
    # We are running at Gitlab via CI so move the
    # output to the directory for Github pages.
    mv $output docs/index.html
fi

