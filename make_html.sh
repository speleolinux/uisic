#!/bin/bash

# Script to generate HTML page from the Markdown document.
# Author: Mike Lake
# Date: March 2023

# Assets such as styles, icons etc, plus header and footer.
styles="assets/styles.css"
header="assets/header.html"
footer="assets/footer.html"

# Main Content of the Glossary

# This is the complete glossary.
input="glosssary_content/glossary_table.md"
# Uncomment this to use a shortened glossary for testing.
#input="glossary_content/glossary_table_short.md"

references="glossary_content/references.md"
epa_intro="glossary_content/epa_intro.md"
license="glossary_content/license.md"
contact="glossary_content/contact.md"

# Final output file for publishing.
output="UIS_Glossary.html"

######
# Main
######

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
echo '<style>' >> $output
cat $styles >> $output
echo '</style>' >> $output
cat assets/start.html | sed "s/VERSION_DATE/$version/" >> $output

# Create the main HTML table data.
# We use columns=10000 to reduce the column width on the term column.
pandoc --columns=10000 --mathml -f markdown -t html $input > tmp1

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
cat tmp1 >> $output

pandoc -f markdown -t html $epa_intro >> $output
pandoc -f markdown -t html $license   >> $output
pandoc -f markdown -t html $contact   >> $output

cat $footer >> $output

# Use this for Git CI. 
mv $output docs/index.html
# Use this for local updating and comment out the above.
#mv $output tmp/

# Cleanup
rm -f tmp1
rm -f tmp2

