#!/bin/bash

# Script to generate HTML Glossary page from the Markdown input.
# Author: Mike Lake
# Date: March 2023

# Assets such as styles, icons etc, plus header and footer.
styles="assets/styles.css"
header="assets/header.html"
footer="assets/footer.html"

intro="glossary_content/intro.html"

# The main glossary table.
glossary="glossary_content/glossary_table.md"

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
    # This just minifies the styles.css
    # The first sed removes the block css comments.
    # The tr squeezes spaces and removes new lines.
    # The final sed removes spaces after : and ; and {.
    cat $styles | \
    sed -r ':a; s%(.*)/\*.*\*/%\1%; ta; /\/\*/ !b; N; ba' \
    | tr -s '\t' ' ' | tr -s ' ' | tr -d '\n' \
    | sed 's/: /:/g' | sed 's/; /;/g' | sed 's/ { /{/g'
}

######
# Main
######

# If $CI is set then we are running under Github's CI.
if [ -z "${CI+x}" ]; then
    # CI is unset or zero so we are running locally.
    # Use this shorter version of the glossary for testing.
    glossary="glossary_content/glossary_table_short.md"
    echo "Using short $glossary CI=$CI"
fi

# Export our timezone so in the shell on the Github build,
# the timezone will be correct.
export TZ="Australia/Sydney"

# Get the date & time now for adding to the HTML header.
# The H:M also ensures the file is changed.
# Otherwise the index.html has not changed and the git push
# will fail, reporting back that the CI has failed.
today=$(date +"%Y-%m-%d %H:%M %Z")

# This will be the version that users see in the HTML page.
version=$(cat VERSION)

cat $header | sed "s/BUILD_DATE/$today/" > $output
echo '<style type="text/css">' >> $output
minify_css >> $output
echo '</style>' >> $output
cat $intro | sed "s/VERSION_DATE/$version/" >> $output

# Create the main HTML table data.
# We use columns=10000 to reduce the column width on the term column.
pandoc --columns=10000 --mathml -f markdown -t html $glossary > tmp1

# This table needs a few things fixed.

# 1. Replace line like this: <td>7</td>
#    with line like this:    <td id="7">7</td>
cat tmp1 | sed 's/<td>\([0-9]*\)<\/td>/<td id="\1">\1<\/td>/' > tmp2

# 2. Remove the even/odd classes on the rows.
cat tmp2 | sed 's/ class="even"//' > tmp1
cat tmp1 | sed 's/ class="odd"//' > tmp2

# Append to the output.
cat tmp2 >> $output

pandoc -f markdown -t html $references > tmp1
# Replace line like this: <p>1. Bates, R. L. and J. A. Jackson.
# with line like this:    <p id="ref1">Bates, R. L. and J. A. Jackson.
cat tmp1 | sed 's/<p>\([0-9]*\)/<p id="ref\1">\1/' > tmp2
cat tmp2 >> $output

pandoc -f markdown -t html $epa_intro >> $output
pandoc -f markdown -t html $license   >> $output
pandoc -f markdown -t html $contact   >> $output

cat $footer >> $output

if [ -z "${CI+x}" ]; then
    # CI is unset or zero so we are running locally.
    echo "Moving output to tmp/$output"
    mv $output tmp/
else
    mv $output docs/index.html
fi

# Cleanup
rm -f tmp1
rm -f tmp2

