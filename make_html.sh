#!/bin/bash

# Script to generate HTML page from the Markdown document.

input="mfield_data/epa_mfield_2002_utf8_short.md"
styles="assets/styles.css"
header="assets/header.html"
footer="assets/footer.html"
output="epa_mfield_2002_utf8.html"

# Added H:M to ensure file is changed.
# Otherwise the index.html has not changed and the git push
# will fail, reporting back that the CI has failed.
today=$(date +"%A, %d %B %Y at %H:%M %p")

export TZ="Australia/Sydney"

cat $header > $output
echo '<style type="text/css">' >> $output
cat $styles >> $output
echo '</style>' >> $output
cat assets/start.html | sed "s/UPDATE_DATE/$today/" >> $output

# Create the main HTML table data.
pandoc $input --columns=10000 > tmp1

# This table needs a few things fixed.

# 1. Replace line like this: <td>7</td>
#    with line like this:    <td id="7">7</td>
cat tmp1 | sed 's/<td>\([0-9]*\)<\/td>/<td id="\1">\1<\/td>/' > tmp2

# 2. Remove the even/odd classes on the rows.
cat tmp2 | sed 's/ class="even"//' > tmp1
cat tmp1 | sed 's/ class="odd"//' > tmp2

# Append to the output.
cat tmp2 >> $output
cat $footer >> $output

mv $output docs/index.html

# Cleanup
rm -f tmp1
rm -f tmp2

