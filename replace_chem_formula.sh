#!/bin/bash

# Script to replace short parts of chemical formulae in the Fields glossary.

input="epa_mfield_2002_utf8.md"

# Using vim, insert mode, Ctrl-v u 4char code.
#before='H2O' ; after='H₂O'     # done
#before='SO4' ; after='SO₄'     # done
before='' ; after=''

echo -n "$before to $after "
cat $input | grep -e "$before" | wc -l
echo " instances"

cat $input | grep -e "$before" > /dev/null
if [ $? -eq 0 ]; then
    # There are instances to replace. 

    # DEBUGGING:
    #cat $input | sed "s/$before/$after/g" > temp.md

    sed -i "s/$before/$after/g" $input
else
    echo 'No instances replaced.' 
fi

# After running this script:
echo -n "Instances after: "
cat $input | grep -e "$before" | wc -l

