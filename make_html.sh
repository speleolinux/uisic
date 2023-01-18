#!/bin/bash

# Script to generate HTML page from the Markdown document.

input="mfield_data/epa_mfield_2002_utf8_short.md"
styles="assets/styles.css"
header="assets/header.html"
footer="assets/footer.html"
output="epa_mfield_2002_utf8_short.html"
tmp="tmp.txt"

today=$(date +"%A, %d %B %Y at %H:%M %p")

cat $header > $output
echo '<style type="text/css">' >> $output
cat $styles >> $output
echo '</style>' >> $output
cat assets/start.html | sed "s/UPDATE_DATE/$today/" >> $output

pandoc $input --columns=10000 > $tmp
# Replace line like this: <td>7</td>
# With lines like this:   <td id="7">7</td>
cat $tmp | sed 's/<td>\([0-9]*\)<\/td>/<td id="\1">\1<\/td>/' >> $output

cat $footer >> $output
rm -f $tmp

