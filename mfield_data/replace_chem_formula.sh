#!/bin/bash

# Script to replace short parts of chemical formulae in the Fields glossary.
# Author: Mike Lake
# Date: 18 March 2023
#
# You can check what will be replaced with grep's color option i.e.
# $ grep --color PO4 epa_mfield_2002_utf8.md

input="epa_mfield_2002_utf8.md"

# Comment out ONLY ONE of the below then run this script.
# Comment out each change when finished and comment as "done".
# Note: Using vim, insert mode, Ctrl-v u 4char code.
#before='H2O' ; after='H₂O'     # done
#before='SO4' ; after='SO₄'     # done
#before='CO3' ; after='CO₃'     # done
#before='PO4' ; after='PO₄'     # done 21 
#before='Mn7O14' ; after='Mn₇O₁₄' # done 1
#before='NH4'  ; after='NH₄'    # done 5
#before='H2PO' ; after='H₂PO'   # done 1
#before='H2'   ; after='H₂'     # done 3
#before='Na2'  ; after='Na₂'    # done 3
#before='NO3'  ; after='NO₃'    # done 4
#before=')2'   ; after=')₂'     # done 23
#before=')3'   ; after=')₃'     # done 7
#before=')4'   ; after=')₄'     # done 9
#before=')5'   ; after=')₅'     # done 2
#before=')6'   ; after=')₆'     # done 6
#before=')7'   ; after=')₇'     # done 1
#before=')8'   ; after=')₈'     # done 1
#before='O4'   ; after='O₄'     # done 6
#before='Ca5'  ; after='Ca₅'    # done 4
#before='Al3'  ; after='Al₃'    # done 2
#before='Zn3'  ; after='Zn₃'    # done 1
#before='Zn7'  ; after='Zn₇'    # done 1
#before='CaF2' ; after='CaF₂'   # done 1
#before='Mg3'  ; after='Mg₃'    # done 2
#before='H4'   ; after='H₄'     # done 2
# Ca4MgAl4  done
# Zn4Si2O7  done
# Fe2O3     done
# Zn4       done
# Zn2       done   
# Fe6       done 
# Ca9       done 

# Check we have entered char or chars.
if [[ "$before" == '' || "$after" == '' ]]; then
    echo 'Both before and after strings must be non-empty. Exiting.'    
    echo "before=$before  after=$after"
    exit
fi

echo -n "$before to $after : instances replaced = "
cat $input | grep -e "$before" | wc -l

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
#echo -n "Instances after: "
#cat $input | grep -e "$before" | wc -l

