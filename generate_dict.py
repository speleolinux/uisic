#!/usr/bin/env python3

'''
Program to read UISIC dictionary CSV files and create the 
"table" portion of a HTML page to display the dictionary.

Author: Mike Lake
Date: 12 March 2023

TODO:
 - pronunciations are not yet included

'''

import sys, os, csv

###############
# Configuration
###############

DEBUG = True

# The languages variable is a dictionary, the keys being the language code.
# Note: When the language tables are read in from CSV the values here will
# be replaced. Edit this when you wish to add another language.
# Note: This is a global variable.
languages = {
"AR":"Arabic",
"BG":"Bulgarian",
"DE":"German",
"EN":"English",
"ES":"Spanish",
"FA":"Farsi/Persian",
"FR":"French",
"GR":"Greek",
"HR":"Croatian",
"HU":"Hungarian",
"ID":"Bahasa Indonesia",
"IT":"Italian",
"JA":"Japanese",
"KO":"Korean",
"LA":"Latin",
"LT":"Lithuanian",
"NL":"Dutch",
"PL":"Polish",
"PT":"Portuguese",
"RO":"Romanian",
"RU":"Russian",
"SE":"Swedish",
"SK":"Slovak",
"SL":"Slovenian",
"SR":"Serbian",
"TR":"Turkish",
"UK":"Ukrainian",
"ZH":"Chinese"
}

###########
# Functions
###########

def read_subject_names():
    '''
    TODO
    '''
    print("\nReading in the Subject English Name (SUUENNAM) table ...")
    print("\nReading in the Subject french Name (SUUFRNAM) table ...")
    subj_names_en = 'SUUENNAM.CSV'
    subj_names_fr = 'SUUFRNAM.CSV'

def read_languages(base_dir, languages):
    '''
    This reads in the contents of all the language files with names like
    EN.CSV, AR,CSV ... ZH.CSV

    This is what the EN.CSV looks like:
      0,1,"English: This Concept 0 is only for testing your browser's rendering of characters"
      0,2,"all sample characters shown here should agree with their description here"
      0,3,"character encoding is UTF-8."
      1,1,"littoral cave"
      1,2,"sea cave"
      2,1,"clay"
      .......
      344,1,"residual hill in polje"

    '''
    print('\nDEBUG; Reading in language tables:') if DEBUG else None
    for key in languages.keys():
        # If debugging we print the key and its current, default value, so the
        # user knows what language is being read. However when read the values
        # will be replaced with the contents of the language file as a string.
        print(key, '=', languages[key], sep=' ', end=' ') if DEBUG else None

        # Check if a language file for this language can be found.
        lang_file = os.path.join(base_dir, key + '.CSV')

        if not os.path.exists(lang_file):
            print('ERROR: missing file ', lang_file, 'for language', key)
        else:
            print('reading ', lang_file) if DEBUG else None
            # For key e.g. 'EN' we will store the English terms in the value
            # of this variable i.e. languages['EN'] would be the long string:
            # '0,1,"English: This Concept 0 ...\n 0,2,"all sample characters..\n'
            with open(lang_file, 'r') as file:
                languages[key] = file.read()

    # Return the changed languages dictionary.
    return languages

def print_language(concept, languages, lang_code):
    '''
    Inputs: - A concept number, e.g. 
            - The languages dictionary containing all the languages.
            - A language code to select one of these languages as uppercase, e.g. EN
    Output: A formatted string of the data, for this concept and language 
            e.g. "en: littoral cave; sea cave"
    '''
    entry = []
    for row in csv.reader(languages[lang_code].splitlines(), delimiter=',', quotechar='"'):
        if int(row[0]) == concept:
            # e.g. if concept = 1 and for English.
            # 1,1,"littoral cave"   <== row[2] = "littoral cave"
            # 1,2,"sea cave"        <== row[2] = "sea cave"
            if row[2]:
                entry.append(row[2])
            # In example entry[] is now ['littoral cave', 'sea cave']
            # Uncomment the line below for detailed debugging.
            # print('   row=',row, '\n   row[2]=',row[2], '\n   => entry=',entry, sep='')
    # Print lang_code(lower case) and string from the concatenated entry list. 
    print(lang_code.lower(), ': ', '; '.join(entry), sep='' )


def main():

    global languages

    # Base directory where the CSV files reside.
    base_dir='lextables'

    # Master table
    master_filename = 'CO0000.CSV'

    # Path to the master table.
    master = os.path.join(base_dir, master_filename)
    
    # Read in all the language tables.
    languages = read_languages(base_dir, languages)
    
    if DEBUG:
        print('\nDEBUG: Printing one concept in one language table:')
        print_language(1, languages, 'EN')
        print('\nDEBUG: Printing one of the language tables as CSV:')
        print(languages['EN']) if DEBUG else None
        print('\nDEBUG: Printing one of the language tables as a list:')
        for row in csv.reader(languages['JA'].splitlines(), delimiter=',', quotechar='"'):
            print('length=', len(row), row)
    
    # Now we read in the master table and iterate over each concept.
    with open(master, newline='') as csvfile:
        reader = csv.reader(csvfile, delimiter=',', quotechar='"')
        for row in reader:
            # Concept zero can be skipped by uncommenting these lines.
            #if row[0] == '0':
            #    print('Skipping row zero.')
            #    continue
    
            # The first integer is the concept number.
            # Save this and then remove it from the row list.
            concept = int(row.pop(0))
    
            # The second and subsequent integers are the subject codes
            # which we concatenate into a string.
            subject = ''.join(row)
    
            #print('\nConcept=', concept, ' Subject Code=', subject, sep='')
            print('\n------------------------------------------------------------------------', end='')
            print('\n', concept, ':', sep='')
    
            # We wish to print English first!
            print_language(concept, languages, 'EN')
    
            # Now print the other languages.
            for key in languages.keys():
                if key == 'EN':
                    continue
                print_language(concept, languages, key)


if __name__ == '__main__':
    main()

