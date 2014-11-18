#!/bin/bash
# Word List Manipulator (wlm)
# Version 0.9 last edit 13-05-2013 23:00
# Build: 0905
# Credits to ; 
# ============
# Gitsnik, because he's awesome :)
# Pureh@te as used and learned a lot from his wordlist_tool script.
# Members at unix.com, have always received expert help there.
# http://cfajohnson.com/shell/ssr/08-The-Dating-Game.shtml for datelist updates.
# Google ;)
# =============
# Google code source: http://code.google.com/p/wordlist-manipulator/source/browse/wlm
#
#FIXED SETTINGS 
RED=$(tput setaf 1 && tput bold)
GREEN=$(tput setaf 2 && tput bold)
STAND=$(tput sgr0)
BLUE=$(tput setaf 6 && tput bold)
CURR_VERS=$(sed -n 3p $0 | cut -c 11-13)
CURR_BUILD=$(sed -n 4p $0 | cut -c 10-13)
#
#Check if running as root
if [[ $UID -ne 0 ]]; then
echo "$GREEN$0$STAND should be run as root for best / most stable results."
echo -ne "Continue anyway ? y/n "
read proceed
	if [[ "$proceed" == "y" || "$proceed" == "Y" ]] ; then
	echo
	else 
	exit 1
	fi
fi
#
#
#--------------
# MENU ITEM 1 
#==============
# CASE OPTIONS 
###############
function f_case {
clear
echo $STAND"Wordlist Manipulator" 
echo $BLUE"Case options"
echo $STAND"--------------------" 
echo "1 Change case of first letter
2 Change case of last letter 
3 Change all lower case to upper case
4 Change all upper case to lower case
5 Invert case (lower to upper, upper to lower)

Q Back to menu
"
echo -ne $STAND"Enter choice from above menu: "$GREEN
read case_menu
if [ "$case_menu" == "q" ] || [ "$case_menu" == "Q" ] ; then 
echo $STAND""
f_menu
elif [[ "$case_menu" != [1-5] ]]; then
echo $RED"must be an entry from the above menu $STAND" 
sleep 1
f_case
fi 

#
# Option 1
# Changing first letter to lower or upper case
# --------------------------------------------
if [ $case_menu = "1" ] ; then
echo ""
echo $BLUE"Change first letter to lower case or upper case"$STAND
echo $STAND""
f_inout
    echo -ne $STAND"Change all first letters to upper case or lower case ? U / L "$GREEN 
    read first_letter
	until [[ "$first_letter" == "u" ]] || [[ "$first_letter" == "l" ]] || [[ "$first_letter" == "U" ]] || [[ "$first_letter" == "L" ]] ; do
	echo -ne $RED"Please enter either U or L for upper or lower case$STAND U / L "$GREEN
	read first_letter
	done
    echo $STAND"Working .."
    if [ "$first_letter" == "l" ] || [ "$first_letter" == "L" ] ; then
    sudo sed 's/^./\l&/' $wlm_infile > $wlm_outfile
    elif [ "$first_letter" == "u" ] || [ "$first_letter" == "U" ] ; then
    sudo sed 's/^./\u&/' $wlm_infile > $wlm_outfile
    fi
    echo $STAND""
f_complete
#
# Option 2
# Changing last letter to lower or upper case
# -------------------------------------------
elif [ $case_menu = "2" ] ; then
echo ""
echo $BLUE"Change last letter to lower case or upper case"$STAND
echo $STAND""
f_inout
    echo -ne $STAND"Change all last letters to upper case or lower case ? U / L "$GREEN 
    read last_letter
	until [[ "$last_letter" == "u" ]] || [[ "$last_letter" == "l" ]] || [[ "$last_letter" == "U" ]] || [[ "$last_letter" == "L" ]] ; do
	echo -ne $RED"Please enter either U or L for upper or lower case$STAND U / L "$GREEN
	read last_letter
	done
    echo $STAND"Working .."
    if [ "$last_letter" == "l" ] || [ "$last_letter" == "L" ] ; then
    sudo sed 's/.$/\l&/' $wlm_infile > $wlm_outfile
    elif [ "$last_letter" == "u" ] || [ "$last_letter" == "U" ] ; then
    sudo sed 's/.$/\u&/' $wlm_infile > $wlm_outfile
    fi
    echo $STAND""
f_complete
#
# Option 3
# Change all lower case to upper case
# -----------------------------------
elif [ $case_menu = "3" ] ; then
echo ""
echo $BLUE"Change all lower case to Upper case"$STAND
echo $STAND""
f_inout
    echo $STAND"Working .."
    sudo tr '[:lower:]' '[:upper:]' < $wlm_infile > $wlm_outfile
    echo $STAND""
f_complete
#
# Option 4 
# Change all upper case to lower case
# -----------------------------------
elif [ $case_menu = "4" ] ; then
echo ""
echo $BLUE"Change all Upper case to lower case"$STAND
echo $STAND""
f_inout
    echo $STAND"Working .."
    sudo tr '[:upper:]' '[:lower:]' < $wlm_infile > $wlm_outfile
    echo $STAND""
f_complete
#
# Option 5 
# Invert case from original input
# --------------------------------
elif [ $case_menu = "5" ] ; then
echo ""
echo $BLUE"Invert case from original input"$STAND
echo $STAND""
f_inout
    echo $STAND"Working .."
    sudo tr 'a-z A-Z' 'A-Z a-z' < $wlm_infile > $wlm_outfile
    echo $STAND""
f_complete
fi
}
#
#
#--------------
# MENU ITEM 2 
#==============
# COMBINATION OPTIONS 
#####################
f_combine () {
clear
echo $STAND"Wordlist Manipulator" 
echo $BLUE"Combination options"
echo $STAND"--------------------" 
echo "1 Combine words from 1 list to each word in another list
2 Combine all wordlists in a directory to 1 wordlist

Q Return to menu
"
echo -ne $STAND"Enter choice from above menu: "$GREEN
read comb_menu
if [ "$comb_menu" == "q" ] || [ "$comb_menu" == "Q" ] ; then 
echo $STAND""
f_menu
elif [[ "$comb_menu" != [1-2] ]]; then
echo $RED"must be an entry from the above menu $STAND" 
sleep 1
f_combine
fi 
#
# Option 1
# Combine words from 1 list to each word in another list
# ------------------------------------------------------
if [ "$comb_menu" == "1" ] ; then
  echo ""
  echo $BLUE"Combine words from one wordlist to all words in another wordlist"
  echo $STAND""
  echo -ne $STAND"Enter /path/to/wordlist to which you want words appended: "$GREEN 
  read comb_infile1
  while [ ! -f $comb_infile1 ] ; do 
  echo -ne $RED"File does not exist, enter /path/to/file: "$GREEN
  read comb_infile1
  done
  echo -ne $STAND"Enter /path/to/wordlist to append to $BLUE$comb_infile1$STAND: "$GREEN 
  read comb_infile2
  while [ ! -f $comb_infile2 ] ; do 
  echo -ne $RED"File does not exist, enter /path/to/file: "$GREEN
  read comb_infile2
  done
  echo -ne $STAND"Enter desired output file name: "$GREEN 
  read wlm_outfile
  if [ -f $wlm_outfile ] ; then
  echo -ne $RED"File already exists, overwrite ? y/n "$GREEN
  read over
	if [ "$over" == "y" ] || [ "$over" == "Y" ] ; then
	echo $RED"Existing file $GREEN$wlm_outfile$RED will be overwritten"
	sleep 1
	else
	echo $STAND"Process cancelled, returning to menu"
	f_menu
	fi
  fi
echo $STAND"Working .."
sudo awk > $wlm_outfile 'NR == FNR {
  l2[FNR] = $0
  fnr = FNR; next
  }
{
  for (i = 0; ++i <= fnr;)
    print $0 l2[i]
  }' $comb_infile2 $comb_infile1
echo $STAND""
f_complete
#
# Option 2
# Combine all wordlists in a directory
# ------------------------------------
elif [ "$comb_menu" == "2" ] ; then 
echo ""
echo $BLUE"Combine all wordlists in a directory to 1 wordlist."
echo $STAND""
    echo -ne $STAND"Enter directory where the wordlists are stored \n(ie. /root/wordlists) : "$GREEN
    read directory
    while [ ! -d "$directory" ] || [ "$directory" == "" ] ; do 
    echo $RED"Directory does not exist or cannot be found"$STAND 
    echo -ne $STAND"Enter existing directory: " 
    read directory
    done
    ls $directory > files_temp
    echo $STAND"! Note that ALL files in directory $GREEN$directory$STAND will be combined;"$BLUE
    cat files_temp
    echo $STAND""
    echo -ne $STAND"Continue or Quit ? C / Q "$GREEN
    read go_for_it
    if [ "$go_for_it" == "c" ] || [ "$go_for_it" == "C" ] ; then
    rm files_temp
    echo $STAND ""
    else 
    echo $STAND""
    echo "Quitting .."
    rm files_temp
    sleep 0.5
    exit
    fi 
   echo -ne $STAND"Enter desired output file name: "$GREEN
    read wlm_outfile
    if [ -f $wlm_outfile ] ; then
    echo -ne $RED"File already exists, add data to existing file ? y/n "$GREEN
    read over
	if [ "$over" == "y" ] || [ "$over" == "Y" ] ; then
	echo $STAND"Working.."
	sleep 1
	else
	echo $STAND"Process cancelled, returning to menu"
	sleep 1
	f_menu
	fi
    fi
        sudo cat $directory/* >> "$wlm_outfile"
	echo $STAND""
f_complete
fi
}
#
#
#--------------
# MENU ITEM 3
#============
# PREPENDING / PREFIXING OPTIONS
################################
f_prefix () {
clear
echo $STAND"Wordlist Manipulator" 
echo $BLUE"Prefix options"
echo $STAND"--------------------" 
echo "1 Prefix numeric values in sequence to a wordlist (ie. 0 - 99999)
2 Prefix fixed number of numeric values in sequence to a wordlist (ie. 00000 - 99999)
3 Prefix word / characters to a wordlist

Q Back to menu"
echo -ne $STAND"Enter choice from above menu: "$GREEN
read pref_menu
if [ "$pref_menu" == "q" ] || [ "$pref_menu" == "Q" ] ; then 
echo $STAND""
f_menu
elif [[ "$pref_menu" != [1-3] ]]; then
echo $RED"must be an entry from the above menu $STAND" 
sleep 1
f_prefix
fi 
#
# Option 1
# Prefix numbers in sequence to a list
# ------------------------------------
if [ "$pref_menu" == "1" ] ; then 
echo $STAND""
echo $BLUE"Prefix numeric values in sequence to a wordlist (ie. 0 - 99999)"
echo $STAND""
echo -ne $STAND"Enter /path/to/wordlist to prefix numbers to: "$GREEN 
read pref_nums
	while [ ! -f "$pref_nums" ] ; do 
	echo -ne $RED"File does not exist, enter /path/to/file: "$GREEN
	read pref_nums
	done
#Check if any '%' characters in the file which could cause errors
grep "%" $pref_nums > prefnums_errors
exist=$(sed -n '$=' prefnums_errors)
if [ "$exist" == "" ] ; then
rm prefnums_errors
elif [ "$exist" != "" ] ; then
echo $RED"Lines with '%' character exist in file which will not be processed"
echo -ne $STAND"View these lines ? y/n "$GREEN
read view
  if [ "$view" == "y" ] || [ "$view" == "Y" ] ; then 
  cat prefnums_errors
  else 
  echo $STAND""
  fi
rm prefnums_errors
fi
#
#Enter output file to write the changes to
echo -ne $STAND"Enter desired output file name: "$GREEN
read pref_nums_out
if [ -f "$pref_nums_out" ] ; then
	echo -ne $RED"File already exists, overwrite ? y/n "$GREEN
	read over
	if [ "$over" == "y" ] || [ "$over" == "Y" ] ; then
	echo $RED"Existing file $GREEN$pref_nums_out$RED will be overwritten"$STAND
	else
	echo $STAND"Process cancelled, returning to menu"
	sleep 1
	f_menu
	fi
fi
echo -ne $STAND"Enter how many numeric values you want to Prefix (max 5): "$GREEN
read numbs
echo $STAND"Working .."
 	if [ "$numbs" == 1 ] ; then 
 	for i in $(cat $pref_nums); do seq -f "%01.0f$i" 0 9; done > "$pref_nums_out"
 	elif [ "$numbs" == 2 ] ; then 
 	for i in $(cat $pref_nums); do seq -f "%01.0f$i" 0 99; done > "$pref_nums_out"
 	elif [ "$numbs" == 3 ] ; then 
 	for i in $(cat $pref_nums); do seq -f "%01.0f$i" 0 999; done > "$pref_nums_out"
 	elif [ "$numbs" == 4 ] ; then 
 	for i in $(cat $pref_nums); do seq -f "%01.0f$i" 0 9999; done > "$pref_nums_out"
 	elif [ "$numbs" == 5 ] ; then 
 	for i in $(cat $pref_nums); do seq -f "%01.0f$i" 0 99999; done > "$pref_nums_out"
	fi
echo $STAND""
echo "$GREEN$pref_nums_out$STAND has been created; "
head -n 3 $pref_nums_out
echo ".." 
tail -n 3 $pref_nums_out
echo $STAND""
	echo -ne $STAND"hit Enter to return to menu or q/Q to quit "$GREEN
	read return
	if [ "$return" == "" ] ; then 
		echo $STAND"" 
	elif [ "$return" == "q" ] || [ "$return" == "Q" ]; then 
		echo $STAND""
		exit
	fi
#
# Option 2
# Prefix fixed number of numberic values to a list
# ------------------------------------------------
elif [ "$pref_menu" == "2" ] ; then
echo $STAND""
echo $BLUE"Prefix fixed number of numeric values in sequence to a wordlist (ie. 00000 - 99999)"
echo $STAND""
echo -ne $STAND"Enter /path/to/wordlist to prefix numbers to: "$GREEN 
read pref_numf
	while [ ! -f $pref_numf ] ; do 
	echo -ne $RED"File does not exist, enter /path/to/file: "$GREEN
	read $pref_numf
	done
#Check if any '%' characters in the file which could cause errors
grep "%" $pref_numf > prefnumf_errors
exist=$(sed -n '$=' prefnumf_errors)
if [ "$exist" == "" ] ; then
rm prefnumf_errors
elif [ "$exist" != "" ] ; then
echo $RED"Lines with '%' character exist in file which will not be processed"
echo -ne $STAND"View these lines ? y/n "$GREEN
read view
  if [ "$view" == "y" ] || [ "$view" == "Y" ] ; then 
  cat prefnumf_errors
  else 
  echo $STAND""
  fi
rm prefnumf_errors
fi
#
#Enter output file to write the changes to
echo -ne $STAND"Enter desired output file name: "$GREEN
read pref_numf_out
if [ -f $pref_numf_out ] ; then
	echo -ne $RED"File already exists, overwrite ? y/n "$GREEN
	read over
	if [ "$over" == "y" ] || [ "$over" == "Y" ] ; then
	echo $RED"Existing file $GREEN$pref_numf_out$RED will be overwritten"$STAND
	else
	echo $STAND"Process cancelled, returning to menu "
	sleep 1
	f_menu
	fi
fi
echo -ne $STAND"Enter how many numeric values you want to Prefix (max 5): "$GREEN
read numbf
echo $STAND"Working .."
 	if [ "$numbf" == 1 ] ; then 
 	for i in $(cat $pref_numf); do seq -f "%0$numbf.0f$i" 0 9; done > "$pref_numf_out"
 	elif [ "$numbf" == 2 ] ; then 
 	for i in $(cat $pref_numf); do seq -f "%0$numbf.0f$i" 0 99; done > "$pref_numf_out"
 	elif [ "$numbf" == 3 ] ; then 
 	for i in $(cat $pref_numf); do seq -f "%0$numbf.0f$i" 0 999; done > "$pref_numf_out"
 	elif [ "$numbf" == 4 ] ; then 
 	for i in $(cat $pref_numf); do seq -f "%0$numbf.0f$i" 0 9999; done > "$pref_numf_out"
 	elif [ "$numbf" == 5 ] ; then 
 	for i in $(cat $pref_numf); do seq -f "%0$numbf.0f$i" 0 99999; done > "$pref_numf_out"
	fi
echo $STAND""
echo "$GREEN$pref_numf_out$STAND has been created; "
head -n 3 $pref_numf_out
echo ".." 
tail -n 3 $pref_numf_out
echo $STAND""
	echo -ne $STAND"hit Enter to return to menu or q/Q to quit "$GREEN
	read return
	if [ "$return" == "" ] ; then 
		echo $STAND"" 
	elif [ "$return" == "q" ] || [ "$return" == "Q" ]; then 
		echo $STAND""
		exit
	fi
#
# Option 3
# Prefix word / characters to a list
# ----------------------------------
elif [ "$pref_menu" == "3" ] ; then 
echo $STAND""
echo $BLUE"Prefix word / characters to a wordlist"
echo $STAND""
f_inout
echo -ne $STAND"Enter word/characters you want prefixed: "$GREEN
read pref_char
echo $STAND"Working .."
sudo sed "s/^./"$pref_char"&/" "$wlm_infile" > "$wlm_outfile" 
echo $STAND""
f_complete
fi
}
#
#
#------------
# MENU ITEM 4
#============
# APPENDING / SUFFIXING OPTIONS
###############################
f_suffix () {
clear
echo $STAND"Wordlist Manipulator" 
echo $BLUE"Suffix options"
echo $STAND"--------------------" 
echo "1 Suffix numeric values in sequence to a wordlist (ie. 0 - 99999)
2 Suffix fixed number of numeric values in sequence to a wordlist (ie. 00000 - 99999)
3 Suffix word / characters to a wordlist

Q Back to menu
"
echo -ne $STAND"Enter choice from above menu: "$GREEN
read suf_menu
if [ "$suf_menu" == "q" ] || [ "$suf_menu" == "Q" ] ; then 
echo $STAND""
f_menu
elif [[ "$suf_menu" != [1-3] ]]; then
echo $RED"must be an entry from the above menu $STAND" 
sleep 1
f_suffix
fi 
#
# Option 1
# Suffix numbers in sequence to a list
# ------------------------------------
if [ "$suf_menu" == "1" ] ; then 
echo $STAND""
echo $BLUE"Suffix numeric values in sequence to a wordlist (ie. 0 - 99999)"
echo $STAND""
echo -ne $STAND"Enter /path/to/wordlist to suffix numbers to: "$GREEN 
read suf_nums
	while [ ! -f $suf_nums ] ; do 
	echo -ne $RED"File does not exist, enter /path/to/file: "$GREEN
	read suf_nums
	done
#Check if any '%' characters in the file which could cause errors
grep "%" $suf_nums > sufnums_errors
exist=$(sed -n '$=' sufnums_errors)
if [[ "$exist" == "" ]] ; then
rm sufnums_errors
	elif [ "$exist" != "" ] ; then
	echo $RED"Lines with '%' character exist in file which will not be processed"
	echo -ne $STAND"View these lines ? y/n "$GREEN
	read view
  	if [ "$view" == "y" ] || [ "$view" == "Y" ] ; then 
  	cat sufnums_errors
  	else 
  	echo $STAND""
	fi
rm sufnums_errors
fi
#Enter output file to write the changes to
echo -ne $STAND"Enter desired output file name: "$GREEN
read suf_nums_out
if [ -f $suf_nums_out ] ; then
	echo -ne $RED"File already exists, overwrite ? y/n "$GREEN
	read over
	if [ "$over" == "y" ] || [ "$over" == "Y" ] ; then
	echo $RED"Existing file $GREEN$suf_nums_out$RED will be overwritten"$STAND
	else
	echo $STAND"Process cancelled, returning to menu"
	sleep 1
	f_menu
	fi
fi
echo -ne $STAND"Enter how many numeric values you want to suffix (max 5): "$GREEN
read numbs
echo $STAND"Working .."
 	if [ "$numbs" == 1 ] ; then 
 	for i in $(cat $suf_nums); do seq -f "$i%01.0f" 0 9; done > "$suf_nums_out"
 	elif [ "$numbs" == 2 ] ; then 
 	for i in $(cat $suf_nums); do seq -f "$i%01.0f" 0 99; done > "$suf_nums_out"
 	elif [ "$numbs" == 3 ] ; then 
 	for i in $(cat $suf_nums); do seq -f "$i%01.0f" 0 999; done > "$suf_nums_out"
 	elif [ "$numbs" == 4 ] ; then 
 	for i in $(cat $suf_nums); do seq -f "$i%01.0f" 0 9999; done > "$suf_nums_out"
 	elif [ "$numbs" == 5 ] ; then 
 	for i in $(cat $suf_nums); do seq -f "$i%01.0f" 0 99999; done > "$suf_nums_out"
	fi
echo $STAND""
echo "$GREEN$suf_nums_out$STAND has been created; "
head -n 3 $suf_nums_out
echo ".." 
tail -n 3 $suf_nums_out
echo $STAND""
	echo -ne $STAND"hit Enter to return to menu or q/Q to quit "$GREEN
	read return
	if [ "$return" == "" ] ; then 
		echo $STAND"" 
	elif [ "$return" == "q" ] || [ "$return" == "Q" ]; then 
		echo $STAND""
		exit
	fi
#
# Option 2
# Suffix fixed number of numberic values to a list
# ------------------------------------------------
elif [ "$suf_menu" == "2" ] ; then
echo $STAND""
echo $BLUE"Suffix fixed number of numeric values in sequence to a wordlist (ie. 00000 - 99999)"
echo $STAND""
echo -ne $STAND"Enter /path/to/wordlist to suffix numbers to: "$GREEN 
read suf_numf
	while [ ! -f $suf_numf ] ; do 
	echo -ne $RED"File does not exist, enter /path/to/file: "$GREEN
	read suf_numf
	done
#Check if any '%' characters in the file which could cause errors
grep "%" $suf_numf > sufnumf_errors
exist=$(sed -n '$=' sufnumf_errors)
if [ "$exist" == "" ] ; then
rm sufnumf_errors
elif [ "$exist" != "" ] ; then
echo $RED"Lines with '%' character exist in file which will not be processed"
echo -ne $STAND"View these lines ? y/n "$GREEN
read view
  if [ "$view" == "y" ] || [ "$view" == "Y" ] ; then 
  cat sufnumf_errors
  else 
  echo $STAND""
  fi
rm sufnumf_errors
fi
#Enter output file to write the changes to
echo -ne $STAND"Enter desired output file name: "$GREEN
read suf_numf_out
if [ -f $suf_numf_out ] ; then
	echo -ne $RED"File already exists, overwrite ? y/n "$GREEN
	read over
	if [ "$over" == "y" ] || [ "$over" == "Y" ] ; then
	echo $RED"Existing file $GREEN$suf_numf_out$RED will be overwritten"$STAND
	else
	echo $STAND"Process cancelled, returning to menu"
	sleep 1
	f_menu
	fi
fi
echo -ne $STAND"Enter how many numeric values you want to Suffix (max 5): "$GREEN
read numbf
echo $STAND"Working .."
 	if [ "$numbf" == 1 ] ; then 
 	for i in $(cat $suf_numf); do seq -f "$i%0$numbf.0f" 0 9; done > "$suf_numf_out"
 	elif [ "$numbf" == 2 ] ; then 
 	for i in $(cat $suf_numf); do seq -f "$i%0$numbf.0f" 0 99; done > "$suf_numf_out"
 	elif [ "$numbf" == 3 ] ; then 
 	for i in $(cat $suf_numf); do seq -f "$i%0$numbf.0f" 0 999; done > "$suf_numf_out"
 	elif [ "$numbf" == 4 ] ; then 
 	for i in $(cat $suf_numf); do seq -f "$i%0$numbf.0f" 0 9999; done > "$suf_numf_out"
 	elif [ "$numbf" == 5 ] ; then 
 	for i in $(cat $suf_numf); do seq -f "$i%0$numbf.0f" 0 99999; done > "$suf_numf_out"
	fi
echo $STAND""
echo "$GREEN$suf_numf_out$STAND has been created; "
head -n 3 $suf_numf_out
echo ".." 
tail -n 3 $suf_numf_out
echo $STAND""
	
	echo -ne $STAND"hit Enter to return to menu or q/Q to quit "$GREEN
	read return
	if [ "$return" == "" ] ; then 
		echo $STAND"" 
	elif [ "$return" == "q" ] || [ "$return" == "Q" ]; then 
		echo $STAND""
		exit
	fi
#
# Option 3
# Suffix word / characters to a list
# ----------------------------------
elif [ "$suf_menu" == "3" ] ; then 
echo $STAND""
echo $BLUE"Suffix word / characters to a wordlist"
echo $STAND""
f_inout
echo -ne $STAND"Enter word/characters you want suffixed: "$GREEN
read suf_char
echo $STAND"Working .."
sudo sed "s/.$/&"$suf_char"/" "$wlm_infile" > "$wlm_outfile" 
echo $STAND""
f_complete
fi
}
#
#
#------------
# MENU ITEM 5
#============
# INCLUDING CHARACTERS /WORD
############################
f_inclu () {
clear
echo $STAND"Wordlist Manipulator" 
echo $BLUE"Inclusion options"
echo $STAND"--------------------" 
echo "1 Include characters/word as from a certain position from START of word.
2 Include characters as from a certain position from END of word.

Q Back to menu
"
echo -ne $STAND"Enter choice from above menu: "$GREEN
read incl_menu
if [ "$incl_menu" == "q" ] || [ "$incl_menu" == "Q" ] ; then 
echo $STAND""
f_menu
elif [[ "$incl_menu" != [1-2] ]]; then
echo $RED"must be an entry from the above menu $STAND" 
sleep 1
f_inclu
fi 
#
# Option 1
# Include characters from start of word
# -------------------------------------
if [ "$incl_menu" == "1" ] ; then 
echo $STAND""
echo $BLUE"Include characters/word as from a certain position from START of word"
echo $STAND""
f_inout
echo -ne $STAND"Enter the word/characters you want included in each word: "$GREEN
read inclu_char
echo -ne $STAND"Enter from what position (after how many characters)
the word/characters should be included: "$GREEN
read inclus_pos
echo $STAND"Working .."
sudo sed "s/^.\{$inclus_pos\}/&$inclu_char/" "$wlm_infile" > "$wlm_outfile" 
echo $STAND""
f_complete
#
# Option 2
# Include Characters
# ------------------
elif [ "$incl_menu" == "2" ] ; then 
echo $STAND""
echo $BLUE"Include characters as from a certain position from END of word"
echo $STAND
f_inout
echo -ne $STAND"Enter the word/characters you want included in each word: "$GREEN
read inclu_char
echo -ne $STAND"Enter before what position (before how many characters before end of word)
the word/characters should be included: "$GREEN
read inclus_pos
echo $STAND"Working .."
sudo sed "s/.\{$inclus_pos\}$/$inclu_char&/" "$wlm_infile" > "$wlm_outfile" 
echo $STAND""
f_complete
fi 
}
#
#
#------------
# MENU ITEM 6
#============
# SUBSTITION OPTIONS
####################
f_subs () {
clear
echo $STAND"Wordlist Manipulator" 
echo $BLUE"Substitution options"
echo $STAND"--------------------" 
echo "1 Substitute/Replace characters from START of word.
2 Substitute/Replace characters from END of word.
3 Substitute/Replace characters at a certain position.

Q Back to menu
"
echo -ne $STAND"Enter choice from above menu: "$GREEN
read subs_menu
if [ "$subs_menu" == "q" ] || [ "$subs_menu" == "Q" ] ; then 
echo $STAND""
f_menu
elif [[ "$subs_menu" != [1-3] ]]; then
echo $RED"must be an entry from the above menu $STAND" 
sleep 1
f_subs
fi 
#
# Option 1
# Substitute characters from start of word
# ----------------------------------------
if [ "$subs_menu" == "1" ] ; then 
echo $STAND""
echo $BLUE"Substitute/Replace characters from START of word"
echo $STAND""
f_inout
echo -ne $STAND"Enter the word/characters you want to replace substituted characters with: "$GREEN
read subs_char
echo -ne $STAND"Enter the number of characters from start of word to replace: "$GREEN
read subs_num
echo $STAND"Working .." 
sudo sed "s/^.\{$subs_num\}/$subs_char/" "$wlm_infile" > "$wlm_outfile" 
echo $STAND""
f_complete
#
# Option 2
# Substitute characters before end of word
# ----------------------------------------
elif [ "$subs_menu" == "2" ] ; then 
echo $STAND""
echo $BLUE"Substitute/Replace characters from END of word"
echo $STAND""
f_inout
echo -ne $STAND"Enter the word/characters you want to replace the sustituted characters with: "$GREEN
read subs_char
echo -ne $STAND"Enter the number of characters at the end of word you want to replace: "$GREEN
read subs_num
echo $STAND"Working .." 
sudo sed "s/.\{$subs_num\}$/$subs_char/" "$wlm_infile" > "$wlm_outfile" 
echo $STAND""
f_complete
#
# Option 3
# Substitute / replace characters in a certain position
# -----------------------------------------------------
elif [ "$subs_menu" == "3" ] ; then 
echo $STAND""
echo $BLUE"Substitute/Replace characters at a certain position"
echo $STAND""
f_inout
echo -ne $STAND"Enter the word/characters you want to replace the sustituted characters with: "$GREEN
read subs_char
echo -ne $STAND"Enter the start position of characters you want to replace (ie. 2)
(position 1 will start from 2nd character, position 4 will start from 5th character, etc): "$GREEN
read subs_poss
echo -ne $STAND"Enter how many characters after start position you want to replace (ie.2); "$GREEN
read subs_pose
echo $STAND"Working .."
sudo sed -r "s/^(.{$subs_poss})(.{$subs_pose})/\1$subs_char/" "$wlm_infile" > "$wlm_outfile" 
echo $STAND""
f_complete
fi
}
#
#
#------------
# MENU ITEM 7
#============
# OPTIMIZATION OPTIONS 
######################
f_tidy () {
clear
echo $STAND"Wordlist Manipulator" 
echo $BLUE"Optimization options"
echo $STAND"--------------------" 
echo "1 Full optimization of wordlist.
2 Optimize wordlist for WPA.
3 Sort wordlist on length of words.

Q Back to menu
"
echo -ne $STAND"Enter choice from above menu: "$GREEN
read tidy_menu
if [ "$tidy_menu" == "q" ] || [ "$tidy_menu" == "Q" ] ; then 
echo $STAND""
f_menu
elif [[ "$tidy_menu" != [1-3] ]]; then
echo $RED"must be an entry from the above menu $STAND" 
sleep 1
f_tidy
fi 
#
# Option 1 
# Full optimization of wordlist
# -----------------------------
if [ "$tidy_menu" == "1" ] ; then 
echo $STAND""
echo $BLUE"Full optimization of wordlist"
echo $STAND""
f_inout
##full optimize##
echo -en $STAND"Enter a minimum password length: "$GREEN
read min
echo -en $STAND"Enter a maximum password length: "$GREEN
read max
echo $STAND""
echo -en $STAND"Hit return to start processing the file "$STAND
read return
if [ "$return" == "" ]; then
echo $GREEN">$STAND Removing duplicates from the file.."
cat $wlm_infile | uniq > working.tmp

echo $GREEN">$STAND Deleting words which do not meet length requirement.."
pw-inspector -i working.tmp -o working1.tmp -m $min -M $max

echo $GREEN">$STAND Removing all non ascii chars if they exist.."
tr -cd '\11\12\40-\176' < working1.tmp > working.tmp

echo $GREEN">$STAND Removing all comments.."
sed '1p; /^[[:blank:]]*#/d; s/[[:blank:]][[:blank:]]*#.*//' working.tmp > working1.tmp

echo $GREEN">$STAND Removing any leading white spaces, tabs and CRLF from the file.."
sed -e 's/^[ \t]*//' working1.tmp > working.tmp
dos2unix -f -q working.tmp

echo $GREEN">$STAND One more pass to sort and remove any duplicates.."
cat working.tmp | sort | uniq > working1.tmp

sudo mv working1.tmp $wlm_outfile
echo $GREEN">$STAND Cleaning up temporary files.."

rm -rf working*.tmp
fi
echo $STAND""
f_complete
#
# Option 2 
# Optimization of wordlist for WPA
# --------------------------------
elif [ "$tidy_menu" == "2" ] ; then 
echo $STAND""
echo $BLUE"Optimization of wordlist for WPA/WPA2"
echo $STAND""
f_inout
echo "Working .." 
pw-inspector -i $wlm_infile -o /root/temp_outfile -m 8 -M 63
sudo cat /root/temp_outfile | sort | uniq > $wlm_outfile
rm -rf /root/temp_outfile
echo $STAND""
f_complete
#
# Option 3
# --------
elif [ "$tidy_menu" == "3" ] ; then 
echo $STAND""
echo $BLUE"Sort wordlist based on wordsize/length"$STAND
echo "(can speed up cracking process with some programmes)"
echo $STAND""
f_inout
echo "Working .." 
sudo awk '{ print length(), $0 | "sort -n" }' $wlm_infile | sed 's/[^ ]* //' > $wlm_outfile
f_complete
fi
}
#
#
#------------
# MENU ITEM 8
#============
# SPLIT FUNCTIONS
##################
f_split () {
clear
echo $STAND"Wordlist Manipulator"
echo $BLUE"Split wordlists"
echo $STAND"--------------------"

echo "1 Split wordlists into user defined max linecount per split file.
2 Split wordlists into user defined max sizes per split file.

Q Back to menu
"
echo -ne $STAND"Enter choice from above menu: "$GREEN
	read split_menu
	if [ "$split_menu" == "q" ] || [ "$split_menu" == "Q" ] ; then 
	echo $STAND""
	f_menu
	elif [[ "$split_menu" != [1-3] ]]; then
	echo $RED"must be an entry from the above menu $STAND" 
	sleep 1
	f_split
	fi 
#
# Option 1
# Split files by linecount 
#-------------------------
if [ "$split_menu" == "1" ] ; then 
echo $STAND""
echo $BLUE"Split wordlists into user defined max linecount per split file"
echo $STAND""
echo -ne $STAND"Enter /path/to/wordlist to split : "$GREEN 
read split_in
	while [ ! -f "$split_in" ] ; do 
	echo -ne $RED"File does not exist, enter /path/to/file: "$GREEN
	read split_in
	done
#Enter output file to write the changes to
echo -ne $STAND"Enter output files' prefix: "$GREEN
read split_out
echo $STAND""
#
# Test for existence of prefixed files in working directory
echo "Checking for existing files in working directory with same pre-fix.."
sleep 0.5
find $split_out* > exist_temp
exist=$(sed -n '$=' exist_temp)
if [ "$exist" == "" ] ; then
echo $GREEN"No files with same prefix found in working directory, proceding.."
rm exist_temp
echo $STAND""
elif [ "$exist" != "" ] ; then
echo $RED"Files with same prefix found in working directory; "$STAND
cat exist_temp
echo $STAND""
# Delete existing files with same prefix before starting so as  
echo -ne $STAND"Delete above files before proceding ? y/n "$GREEN
read delete
	if [ "$delete" == "y" ] || [ "$delete" == "Y" ] ; then 
		echo $STAND"deleting existing files.."		
		sleep 0.5
		echo $STAND""	
		for line in $(cat exist_temp) ; do  
		rm $line
		done
	else
		echo ""	
		echo $STAND"Returning to menu.."
		rm exist_temp
		sleep 1
		f_split
	fi
rm exist_temp
fi
#
#
B=$( stat -c %s $split_in )
KB=$( echo "scale=2;$B / 1024" | bc )
MB=$( echo "scale=2;($B/1024)/1024" | bc )
GB=$( echo "scale=2;(($B/1024)/1024)/1024" | bc )
echo -e $STAND"Wordlist $GREEN$split_in$STAND size: $KB KB$STAND  $GREEN$MB MB$STAND  $GB GB$STAND"
linecount=$(wc -l $split_in | cut -d " " -f 1)
echo "Wordlist $GREEN$split_in$STAND Linecount: $GREEN$linecount$STAND" 
echo ""
echo -ne $STAND"Enter number of lines you want per each split file: "$GREEN
read lines_in
#Calculate the number of files resulting from user input
est_count=$(echo "scale=3;$linecount / $lines_in" | bc) 
	if [ "$est_count" != *.000 ] ; then 
	size=$(echo "$linecount/$lines_in+1" | bc)
	elif [ "$est_count" == *.000 ] ; then 
	size=$(echo "$linecount/$lines_in" | bc)
	fi
#
echo -ne $STAND"This will result in an estimated $GREEN$size$STAND files, continue ? y/n "$GREEN
read go_for_it
	if [ "$go_for_it" == "y" ] || [ "$go_for_it" == "Y" ] ; then 
	echo ""
	echo $STAND"Working .."
	else echo $STAND"Quitting to menu"
	sleep 0.5
	f_split
	fi
SFX=$(echo $size | wc -c)
SFX=$(echo $[$SFX -1])
split -a$SFX -d -l $lines_in $split_in $split_out
echo ""
ls $split_out* > split_out_temp
echo $STAND ""
echo $STAND"The following files have been created"
echo $STAND"-------------------------------------"$STAND
for line in $(cat split_out_temp) ; do 
B=$( stat -c %s $line )
KB=$( echo "scale=2;$B / 1024" | bc )
MB=$( echo "scale=2;($B/1024)/1024" | bc )
GB=$( echo "scale=2;(($B/1024)/1024)/1024" | bc )
echo -e "$GREEN$line$STAND   $KB KB \t $GREEN$MB MB$STAND \t $GB GB$STAND" 
done
echo $STAND""
rm split_out_temp
echo -ne $STAND"hit Enter to return to menu or q/Q to quit "$GREEN
read return
    if [ "$return" == "" ] ; then 
    echo $STAND""
    f_menu
    elif [ "$return" == "q" ] || [ "$return" == "Q" ] ; then
    echo $STAND""
    exit
    fi
echo $STAND""
#
# Option 2
# Split files by size 
#--------------------
elif [ "$split_menu" == "2" ] ; then 
echo $STAND""
echo $BLUE"Split wordlists into user defined max size (in MB) per split file"
echo $STAND""
echo -ne $STAND"Enter /path/to/wordlist to split : "$GREEN 
read split_in
	while [ ! -f "$split_in" ] ; do 
	echo -ne $RED"File does not exist, enter /path/to/file: "$GREEN
	read split_in
	done
#Enter output file to write the changes to
echo -ne $STAND"Enter output files' prefix: "$GREEN
read split_out
echo $STAND""
#
# Test for existence of same prefix in working directory
echo "Checking for existing files in working directory with same pre-fix.."
sleep 0.5
find $split_out* > exist_temp
exist=$(sed -n '$=' exist_temp)
if [ "$exist" == "" ] ; then
echo $GREEN"No files with same prefix found in working directory, proceding.."
rm exist_temp
echo $STAND""
elif [ "$exist" != "" ] ; then
echo $RED"Files with same prefix found in working directory; "$STAND
cat exist_temp
echo $STAND""
echo -ne $STAND"Delete above files before proceding ? y/n "$GREEN
read delete
	if [ "$delete" == "y" ] || [ "$delete" == "Y" ] ; then 
		echo $STAND"deleting existing files.."		
		sleep 0.5
		echo $STAND""	
		for line in $(cat exist_temp) ; do  
		rm $line
		done
	else
		echo ""	
		echo $STAND"Returning to menu.."
		rm exist_temp
		sleep 1
		f_misc
	fi
rm exist_temp
fi
#Wordlist size
B=$( stat -c %s $split_in )
KB=$( echo "scale=2;$B / 1024" | bc )
MB=$( echo "scale=2;($B/1024)/1024" | bc )
GB=$( echo "scale=2;(($B/1024)/1024)/1024" | bc )
echo $STAND"File size of $GREEN$split_in$STAND ;" 
echo $STAND"Bytes     = $RED$B" 
echo $STAND"Kilobytes = $RED$KB"
echo $STAND"Megabytes = $RED$MB"
echo $STAND"Gigabytes = $RED$GB"
echo $STAND""
echo -ne "Enter max size of each split file in Megabytes (whole numbers only!): "$GREEN
read split_size
est_size=$(echo "scale=3;$MB / $split_size" | bc) 
	if [ "$est_size" != *.000 ] ; then 
	size=$(echo "$MB/$split_size+1" | bc)
	elif [ "$est_size" == *.000 ] ; then 
	size=$(echo "$MB/$split_size" | bc)
	fi
#est_size=$(printf "%.0f" $(echo "scale=2;$MB/$split_size" | bc))
echo -ne $STAND"This will result in an estimated $GREEN$size$STAND files, continue ? y/n "$GREEN
read go_for_it
	if [ "$go_for_it" == "y" ] || [ "$go_for_it" == "Y" ] ; then 
	echo ""
	echo $STAND"Working .."
	else echo $STAND"Quitting to menu"
	sleep 1
	f_split
	fi
#split_size_b=$( echo "(($split_size * 1024) * 1024)" | bc )
split -d -C "$split_size"M $split_in $split_out
ls $split_out* > split_out_temp
echo $STAND ""
echo $STAND"The following files have been created"
echo $STAND"-------------------------------------"$STAND
for line in $(cat split_out_temp) ; do 
B=$( stat -c %s $line )
KB=$( echo "scale=2;$B / 1024" | bc )
MB=$( echo "scale=2;($B/1024)/1024" | bc )
GB=$( echo "scale=2;(($B/1024)/1024)/1024" | bc )
echo -e "$GREEN$line$STAND   $KB KB \t $GREEN$MB MB$STAND \t $GB GB$STAND" 
done
echo $STAND""
rm split_out_temp
echo -ne $STAND"hit Enter to return to menu or q/Q to quit "$GREEN
read return
    if [ "$return" == "" ] ; then 
    echo $STAND""
    f_menu
    elif [ "$return" == "q" ] || [ "$return" == "Q" ] ; then
    echo $STAND""
    exit
    fi
echo $STAND""
fi
}
#
#
#------------
# MENU ITEM 9
#============
# REMOVAL / DELETION OPTIONS 
############################
f_delete () {
clear
echo $STAND"Wordlist Manipulator"
echo $BLUE"Removal/Character removal options"
echo $STAND"---------------------------------"

echo "1 Remove X number of characters from start of word.
2 Remove X number of characters from end of word.
3 Remove specific characters globally from words.
4 Remove words containing specific characters.
5 Remove lines with X number of identical adjacent characters.
6 Remove lines existing in 1 list from another list.
  (dont use on large lists, work in progress)
7 Remove words which do NOT have X number of numeric values.
8 Removing words which have X number of repeated characters.
9 Remove words of a certain length.
10Remove characters from and including specified character.
	
Q Back to menu
"
#Check to ensure correct menu entry
echo -ne $STAND"Enter choice from above menu: "$GREEN
	read del_menu
	if [ "$del_menu" == "q" ] || [ "$del_menu" == "Q" ] ; then 
	echo $STAND""
	f_menu
	elif [[ "$del_menu" -gt 10 ]]; then
	echo $RED"must be an entry from the above menu $STAND" 
	sleep 1
	f_delete
	fi 

# Option 1
# Removing X number of characters from start of word
# --------------------------------------------------
if [ "$del_menu" == "1" ] ; then 
echo $STAND""
echo $BLUE"Remove X number of characters from start of word"$STAND
echo $STAND""
f_inout
echo -ne $STAND"Enter how many characters you want to remove from start of word: "$GREEN
read dels_char
echo $STAND"Working .."
sudo sed "s/^.\{$dels_char\}//" $wlm_infile > $wlm_outfile
echo $STAND""
f_complete
#
# Option 2
# Removing X number of characters from end of word
# ------------------------------------------------
elif [ "$del_menu" == "2" ] ; then 
echo $STAND""
echo $BLUE"Remove X number of characters from end of word"$STAND
echo $STAND""
f_inout
echo -ne "Enter how many characters you want to remove from end of word: " 
read pos_char
echo $STAND"Working .."
sudo sed "s/.\{$pos_char\}$//" $wlm_infile > $wlm_outfile
echo $STAND""
f_complete
#
# Option 3
# Removing specific characters globally from wordlist
# ---------------------------------------------------
elif [ "$del_menu" == "3" ] ; then 
echo $STAND""
echo $BLUE"Remove specific character globally from words in wordlist"
echo $STAND""
f_inout
echo -ne "Enter the character you want removed globally from wordlist: "$GREEN
read char_remove
grep $char_remove $wlm_infile > rem_temp
rem_count=$(wc -l rem_temp | cut -d " " -f 1) 
  if [ "$rem_count" == "0" ] ; then 
    echo $STAND"Character $GREEN$char_remove$STAND was not found in $GREEN$wlm_infile$STAND."
    echo -ne $STAND"hit Enter to return to menu or q/Q to quit "$GREEN
    read return
    if [ "$return" == "" ] ; then 
    echo $STAND""
    f_delete
    elif [ "$return" == "q" ] || [ "$return" == "Q" ] ; then
    echo $STAND""
    exit
    fi
  fi
echo $STAND"Working .."
rm rem_temp
sudo sed "s/$char_remove//g" $wlm_infile > $wlm_outfile
echo $STAND""
f_complete
#
# Option 4
# Removing words containing specific characters from wordlist
# -----------------------------------------------------------
elif [ "$del_menu" == "4" ] ; then 
echo $STAND""
echo $BLUE"Remove words containing specific character from wordlist"
echo $STAND""
f_inout
echo -ne $STAND"Enter the character to check for: "$GREEN
read char_remove
grep $char_remove $wlm_infile > rem_temp
rem_count=$(wc -l rem_temp | cut -d " " -f 1)
if [ "$rem_count" == "0" ] ; then 
  echo $STAND"Character $GREEN$char_remove$STAND was not found in $GREEN$wlm_infile$STAND" 
  echo -ne $STAND"hit Enter to return to menu or q/Q to quit "$GREEN
  read return
    if [ "$return" == "" ] ; then 
    echo $STAND""
    f_delete
    elif [ "$return" == "q" ] || [ "$return" == "Q" ] ; then
    echo $STAND""
    exit
    fi
fi
echo "$GREEN$rem_count$STAND words will be removed."
echo $STAND"Working .." 
sudo sed "/$char_remove/d" $wlm_infile > $wlm_outfile
rm rem_temp
echo $STAND""
f_complete
#
# Option 5
# Remove words with more than X number of identical adjacent characters from wordlist
# -----------------------------------------------------------------------------------
elif [ "$del_menu" == "5" ] ; then 
echo $STAND""
echo $BLUE"Remove words with more than X number of identical adjacent charaters from wordlist"
echo $STAND""
f_inout
echo -ne $STAND"Enter how many identical adjacent characters should be allowed: "$GREEN
read ident_numb
echo $STAND"Working .."
sudo sed "/\([^A-Za-z0-9_]\|[A-Za-z0-9]\)\1\{$ident_numb,\}/d" $wlm_infile > $wlm_outfile
echo $STAND""
f_complete
#
# Option 6
# Remove words existing in one list from another list
# ---------------------------------------------------
elif [ "$del_menu" == "6" ] ; then
echo $STAND""
echo $BLUE"Remove words existing in 1 list from another list"
echo "Very simple/bad coding on this..use on SMALL files only"
echo $STAND""
#Enter wordlist file to process
echo -ne $STAND"Enter /path/to/wordlist to process: "$GREEN 
read wlm_infile
	while [ ! -f $wlm_infile ] || [ "$wlm_infile" == "" ] ; do 
	echo -ne $RED"File does not exist, enter /path/to/file: "$GREEN
	read wlm_infile
	done
echo $STAND"Enter /path/to/wordlist which contains the words to check for"
echo -ne $STAND"(Words in this list will be removed from wordlist to process): "$GREEN
read read_in
#Enter output file to write the changes to
echo -ne $STAND"Enter desired output file name: "$GREEN
read wlm_outfile
if [ -f $wlm_outfile ] ; then
	echo -ne $RED"File already exists, overwrite ? y/n "$GREEN
	read over
	if [ "$over" == "y" ] || [ "$over" == "Y" ] ; then
	echo $RED"Existing file $GREEN$wlm_outfile$RED will be overwritten"$STAND
	else
	echo $STAND"Process cancelled, returning to menu"
	sleep 1
	f_menu
	fi
fi
echo "Working .."
sudo grep -v -x -f $read_in $wlm_infile > $wlm_outfile
echo $STAND""
f_complete
#
# Option 7
# Removing words which do not have X number of numeric values
# -----------------------------------------------------------
elif [ "$del_menu" == "7" ] ; then
echo $STAND""
echo $BLUE"Remove words which do not have X number of numeric values"
echo $STAND""
f_inout
echo -ne $STAND"Enter how many numeric values should be allowed: "$GREEN
read ident_numb
echo $STAND"Working .."
sudo nawk 'gsub("[0-9]","&",$0)=='$ident_numb'' $wlm_infile > $wlm_outfile
echo $STAND""
f_complete
#
# Option 8
# Removing words which have N number of repeated characters
# ----------------------------------------------------------
elif [ "$del_menu" == "8" ] ; then 
echo $STAND""
echo $BLUE"Remove words which have X number of repeated characters"
echo $STAND""
f_inout
#Enter characters to check for
echo $STAND"Enter the character you don't want repeated more than N times"
echo -ne "(Hit enter for any character): " $GREEN
read rep_char
if [ "$rep_char" == "" ] ; then
#Enter how many times it may occur in the words
echo -ne $STAND"How many times may characters be repeated in a word: "$GREEN
read rep_time
echo ""
echo "Working.."
sudo sed "/\(.\)\(.*\1\)\{$rep_time,\}/d" $wlm_infile > $wlm_outfile
fi
if [ "$rep_char" != "" ] ; then 
echo -ne $STAND"How many times may $GREEN$rep_char$STAND be repeated in a word: "$GREEN
read rep_time
echo ""
echo $STAND"Working.."
sudo sed "/\($rep_char\)\(.*\1\)\{$rep_time,\}/d" $wlm_infile > $wlm_outfile
fi
echo $STAND""
f_complete
#
# Option 9
# Removing words which have a certain length
# ------------------------------------------
elif [ "$del_menu" == "9" ] ; then 
echo $STAND""
echo $BLUE"Remove all words with X length from the list"
echo $STAND""
f_inout
#Enter the length of words you want removed
echo -ne $STAND"Enter the length of words you want removed from wordlist: "$GREEN
read LEN_REM
echo $STAND"Working.." 
sudo awk "length != $LEN_REM" $wlm_infile > $wlm_outfile
echo ""
f_complete
#
# Option 10
# Remove all characters after and including a certain character
# example: password:12345, remove as from : --> password
# -------------------------------------------------------------
elif [ "$del_menu" == "10" ] ; then 
echo $STAND""
echo $BLUE"Remove all characters after and including a specified character"
echo $STAND""
f_inout
#Enter the length of words you want removed
echo -ne $STAND"Enter the character from when you want the rest removed: "$GREEN
read REM_REM
echo $STAND"Working.." 
sudo sed "s/\($REM_REM\).*//" $wlm_infile > $wlm_outfile
echo ""
f_complete
fi
}
#
#
#-------------
# MENU ITEM 10
#=============
# MISCELLANEOUS OPTIONS 
#######################
f_misc () {
clear
echo $STAND"Wordlist Manipulator"
echo $BLUE"Miscellaneous Fun"
echo $STAND"--------------------"
echo "1 Check what size a crunch created wordlist would be.
2 Create a date wordlist
3 Strip SSIDs from a kismet generated .nettxt file.
4 Basic leetify options for wordlists.
5 Create all possible (leetify) permutations of a wordlist (Gitsnik's permute.pl).
6 Decode / Encode text with ROT18
7 Decode / Encode text with ROT47
8 Check all possible shift values to decode a Caesar cipher shifted text

Q Back to menu
"
echo -ne $STAND"Enter choice from above menu: "$GREEN
	read misc_menu
	if [ "$misc_menu" == "q" ] || [ "$misc_menu" == "Q" ] ; then 
	echo $STAND""
	f_menu
	elif [[ "$misc_menu" != [1-8] ]]; then
	echo $RED"must be an entry from the above menu $STAND" 
	sleep 1
	f_misc
	fi 
##
## Option 1
## CRUNCH_SIZE
##============
if [ "$misc_menu" == "1" ] ; then 
clear
echo $BLUE"Crunch_Size ;)"$STAND
echo $STAND"Check what size a newly created wordlist would be"
echo "when creating a wordlist with for instance 'crunch'."
echo "This only calculates based on the same min max word length"
echo $STAND""
echo $STAND"Choose the number of characters that will be used making the wordlist"
echo $STAND"====================================================================="
echo "Example ;"
echo $RED"10 $STAND = Numeric only"
echo $RED"16 $STAND = Hexadecimal"
echo $RED"26 $STAND = Alpha only"
echo $RED"33 $STAND = Special characters including space"
echo $RED"36 $STAND = Alpha + Numeric"
echo $RED"52 $STAND = Lowercase+Uppercase alpha"
echo $RED"62 $STAND = Lower+Uppercase alpha + Numeric"
echo $RED"95 $STAND = Lower+Uppercase alpha +Numeric+SpecialCharacters including space"
echo
echo -ne $STAND"Enter number of characters to be used: "$RED
read X
echo -ne $STAND"Enter length of words/passphrases: "$RED
read Y
echo $STAND"How many passwords/second can your system handle ?"$STAND
echo -ne $STAND"(or hit Enter to simply ignore this query)  "$RED
read passec

# Calculations based on binary sizes ;
# For comma seperated values for groups of 3 digits pipe the below calculation out through sed ;
# sed -r ':L;s=\b([0-9]+)([0-9]{3})\b=\1,\2=g;t L'
B=$( echo "scale=3;($X^$Y)*($Y+1)" | bc )
KB=$( echo "scale=3;($X^$Y)*($Y+1) / 1024" | bc )
MB=$( echo "scale=3;(($X^$Y)*($Y+1)/1024)/1024" | bc )
GB=$( echo "scale=3;((($X^$Y)*($Y+1)/1024)/1024)/1024" | bc )
TB=$( echo "scale=3;(((($X^$Y)*($Y+1)/1024)/1024)/1024)/1024" | bc )
PB=$( echo "scale=3;((((($X^$Y)*($Y+1)/1024)/1024)/1024)/1024)/1024" | bc )
#
# Calculation for number of results ;
# For comma seperated values for groups of 3 digits pipe the below calculation out through sed ;
# sed -r ':L;s=\b([0-9]+)([0-9]{3})\b=\1,\2=g;t L'
NMBR=$( echo "($X^$Y)" | bc )
echo $STAND""
#
# Outcome of calculations ;
if [ "$passec" == "" ] ; then 
echo $STAND"Estimated number of words/passphrases in wordlist: $GREEN$NMBR$STAND"
echo $STAND""
elif [ "$passec" != "" ] ; then
hours=$( echo "scale=2;((($NMBR/$passec)/60)/60)" | bc )
days=$( echo "scale=2;(((($NMBR/$passec)/60)/60)/24)" | bc )
echo $STAND"Estimated number of words/passphrases in wordlist: $GREEN$NMBR$STAND"
echo $STAND"Estimated duration to go through full list: $GREEN$hours$STAND hours ($GREEN$days$STAND days)"
echo $STAND""
fi
#
echo $STAND"Estimated wordlist size ; "	
echo $GREEN"B  $STAND(Bytes)     = $GREEN$B"
echo $GREEN"KB $STAND(Kilobytes) = $GREEN$KB"
echo $GREEN"MB $STAND(Megabytes) = $GREEN$MB"
echo $GREEN"GB $STAND(Gigabytes) = $GREEN$GB"
echo $GREEN"TB $STAND(Terabytes) = $GREEN$TB"
echo $GREEN"PB $STAND(Petabytes) = $GREEN$PB"
echo $STAND""
#
echo -ne $STAND"hit Enter to return to menu or q/Q to quit "$GREEN
read return
    if [ "$return" == "" ] ; then 
    echo $STAND""
    elif [ "$return" == "q" ] || [ "$return" == "Q" ] ; then
    echo $STAND""
    exit
    fi
##
## Option 2
## Datelist
## ========
elif [ "$misc_menu" == "2" ] ; then 
clear
echo $BLUE"TAPE's
     | |     | |      | (_)   | |  
   __| | __ _| |_  ___| |_ ___| |_ 
  / _  |/ _  | __|/ _ \ | / __| __|
 | (_| | (_| | |_ | __/ | \__ \ |_ 
  \____|\____|\__|\___|_|_|___/\__|
v0.7a$STAND"
echo $BLUE"30 days hath September, April, June and November.."
echo $STAND""
echo $BLUE"Create a wordlist from a range of dates"
echo $STAND"======================================="

#Enter startdate
echo -ne $STAND"Enter startdate in format yyyy-mm-dd: "$GREEN
read startdate
startyear=$(echo $startdate | cut -d - -f 1)
startmonth=$(echo $startdate | cut -d - -f 2)
startday=$(echo $startdate | cut -d - -f 3)
#Check for incorrect start date entry
syear_len=$(echo "$startyear" | wc -L)
if [[ "$syear_len" -ne 4 ]] ; then 
echo $RED"Begin year error: $startyear$STAND, year entries must have 4 digits"
sleep 2
f_misc
fi
if [[ "$startmonth" -lt "01" || "$startmonth" -gt "12" ]] ; then
echo $RED"Begin month error: $startmonth$STAND, months can only be between 01 - 12"
sleep 2
f_misc
fi
if [[ "$startday" -lt "01" || "$startday" -gt "31" ]] ; then
echo $RED"Begin day error: $startday$STAND, days can only be between 01 - 31"
sleep 2
f_misc
fi
#
#Enter enddate 
echo -ne $STAND"Enter enddate in formate yyyy-mm-dd: "$GREEN
read enddate
endyear=$(echo $enddate | cut -d - -f 1)
endmonth=$(echo $enddate | cut -d - -f 2)
endday=$(echo $enddate | cut -d - -f 3)
#Check for incorrect end date entry
eyear_len=$(echo "$endyear" | wc -L)
if [[ "$eyear_len" -ne 4 ]] ; then 
echo $RED"End year error: $endyear$STAND, year entries must have 4 digits"
sleep 2
f_misc
fi
if [[ "$endmonth" -lt "01" || "$endmonth" -gt "12" ]] ; then
echo $RED"End month error: $endmonth$STAND, months can only be between 01 - 12"
sleep 2
f_misc
fi
if [[ "$endday" -lt "01" || "$endday" -gt "31" ]] ; then
echo $RED"End day error: $endday$STAND, days can only be between 01 - 31"
sleep 2
f_misc
fi
#
#
#
# Output file to save the date wordlist to
echo -ne $STAND"Enter desired output file name: "$GREEN 
read date_outfile
while [ "$date_outfile" == "" ] ; do 
echo -ne $RED"Enter desired output file name: "$GREEN
read date_outfile
done
if [ -f $date_outfile ] ; then
echo -ne $RED"File already exists, overwrite ? y/n "$GREEN
read over
	if [ "$over" == "y" ] || [ "$over" == "Y" ] ; then
	echo $RED"Existing file $GREEN$date_outfile$RED will be overwritten$STAND"
	else
	echo $STAND"Process cancelled, quitting"
	sleep 1
	exit
	fi
fi
#
#
#
# Desired output format
echo $STAND""
echo $STAND"Enter desired output format as below;"
echo -ne $STAND"ddmmyy / ddmmyyyy / mmddyy / mmddyyyy / yymmdd / yyyymmdd: "$GREEN
read format

until [ "$format" == "ddmmyy" ] || [ "$format" == "ddmmyyyy" ] || [ "$format" == "yymmdd" ] || [ "$format" == "yyyymmdd" ] || [ "$format" == "mmddyyyy" ] || [ "$format" == "mmddyy" ]; do
	echo $RED"Please enter a correct output format;"
	echo -ne $STAND"ddmmyy / ddmmyyyy / mmddyy / mmddyyyy / yymmdd / yyyymmdd: "$GREEN
	read format
	done
#
#
#
# Desired Spacing character, if any 
echo $STAND""
echo -ne $STAND"Enter spacing character or hit enter for no spacing character: "$GREEN
read space
echo $STAND"Working .."
#
#
#
#List the years
echo $startyear > dates_years
while [ "$startyear" != "$endyear" ] ; do 
startyear=$(expr $startyear + 1) 
echo $startyear >> dates_years
done
#
#
#
echo "$GREEN>$STAND Listing range of years and months .."
#Add a '-' spacer to simplify later manipulations
sed 's/^.\{4\}/&-/' -i dates_years
#Add months to list of years
for i in $(cat dates_years) ; do seq -f $i%02.0f 01 12 ; done > dates_months
sed 's/.$/&-/' -i dates_months
#
#
#
#Add days to list of years & months
echo "$GREEN>$STAND Checking for leapyears and listing correct days per month .."
for i in $(cat dates_months)
	do
	mnth=$(echo $i | cut -d - -f 2)
	year=$(echo $i | cut -d - -f 1)
	if [[ "$mnth" == "02" ]] ; then
		if [[ `expr "$year" % 4` == 0 && `expr "$year" % 100` != 0 ]] ; then
		seq -f $i%02.0f 01 29
		elif [[ `expr "$year" % 4` == 0 && `expr "$year" % 100` != 0 && `expr "$year" % 400` == 0 ]] ; then
		seq -f $i%02.0f 01 29
		else
		seq -f $i%02.0f 01 28
		fi
	elif [[ "$mnth" == "04" || "$mnth" == "06" || "$mnth" == "09" || "$mnth" == "11" ]] ; then 
	seq -f $i%02.0f 01 30
	elif [[ "$mnth" == "01" || "$mnth" == "03" || "$mnth" == "05" || "$mnth" == "07" || "$mnth" == "08"  || "$mnth" == "10"|| "$mnth" == "12" ]] ; then 
	seq -f $i%02.0f 01 31 
	fi
	done > datelist_temp
#
#
#
#Remove dates before/after start/end date.
sed -n "/$startdate/,/$enddate/p" datelist_temp > date_list1_temp
#
#
# Ensure correct format and spacing character in output
echo "$GREEN>$STAND Creating desired format with spacing character (if any) .. "
# format ddmmyy
if [ "$format" == "ddmmyy" ] ; then
	if [ -n "$space" ] && [ "$space" == "/" ] ; then
	sed 's/^..//' -i date_list1_temp
	awk -F- '{print $3 $2 $1}' date_list1_temp > dates_sort.txt
	sudo sed 's/\(.\{2\}\)/&\//;s/\(.\{5\}\)/&\//' dates_sort.txt > "$date_outfile"
	rm date_list1_temp && rm dates_sort.txt
	elif [ -n "$space" ] ; then
	sed 's/^..//' -i date_list1_temp
	awk -F- '{print $3 $2 $1}' date_list1_temp > dates_sort.txt
 	sudo sed "s/\(.\{2\}\)/&"$space"/;s/\(.\{5\}\)/&$space/" dates_sort.txt > "$date_outfile"
	rm date_list1_temp && rm dates_sort.txt
 	elif [ -z "$space" ] ; then
	sed 's/^..//' -i date_list1_temp
	sudo awk -F- '{print $3 $2 $1}' date_list1_temp > "$date_outfile"
	rm date_list1_temp
	fi
# format ddmmyyyy
elif [ "$format" == "ddmmyyyy" ] ; then
	if [ -n "$space" ] && [ "$space" == "/" ] ; then
	awk -F- '{print $3 $2 $1}' date_list1_temp > dates_sort.txt
	sudo sed 's/\(.\{2\}\)/&\//;s/\(.\{5\}\)/&\//' dates_sort.txt > "$date_outfile"
	rm date_list1_temp && rm dates_sort.txt
	elif [ -n "$space" ] ; then
	awk -F- '{print $3 $2 $1}' date_list1_temp > dates_sort.txt
 	sudo sed "s/\(.\{2\}\)/&"$space"/;s/\(.\{5\}\)/&$space/" dates_sort.txt > "$date_outfile"
	rm date_list1_temp && rm dates_sort.txt
 	elif [ -z "$space" ] ; then
	sudo awk -F- '{print $3 $2 $1}' date_list1_temp > "$date_outfile"
	rm date_list1_temp
	fi
# format yymmdd
elif [ "$format" == "yymmdd" ] ; then
	if [ -n "$space" ] && [ "$space" == "/" ] ; then
	sed 's/^..//' -i date_list1_temp
	sudo sed 's/-/\//g' date_list1_temp > "$date_outfile"
	rm date_list1_temp
	elif [ -n "$space" ] ; then
	sed 's/^..//' -i date_list1_temp
	sudo sed "s/-/$space/g" date_list1_temp > "$date_outfile"
	rm date_list1_temp
 	elif [ -z "$space" ] ; then
	sed 's/^..//' -i date_list1_temp
	sudo awk -F- '{print $1 $2 $3}' date_list1_temp > "$date_outfile"
	rm date_list1_temp
	fi
# format yyyymmdd
elif [ "$format" == "yyyymmdd" ] ; then
	if [ -n "$space" ] && [ "$space" == "/" ] ; then
	sudo sed 's/-/\//g' date_list1_temp > "$date_outfile"
	rm date_list1_temp
	elif [ -n "$space" ] ; then
	sudo sed "s/-/$space/g" date_list1_temp > "$date_outfile"
	rm date_list1_temp
	elif [ -z "$space" ] ; then
	sudo awk -F- '{print $1 $2 $3}' date_list1_temp > "$date_outfile"
	rm date_list1_temp
	fi
#format mmddyyyy
elif [ "$format" == "mmddyyyy" ] ; then
if [ -n "$space" ] && [ "$space" == "/" ] ; then
	awk -F- '{print $2 $3 $1}' date_list1_temp > dates_sort.txt
	sudo sed 's/\(.\{2\}\)/&\//;s/\(.\{5\}\)/&\//' dates_sort.txt > "$date_outfile"
	rm date_list1_temp && rm dates_sort.txt
	elif [ -n "$space" ] ; then
	awk -F- '{print $2 $3 $1}' date_list1_temp > dates_sort.txt
 	sudo sed "s/\(.\{2\}\)/&"$space"/;s/\(.\{5\}\)/&$space/" dates_sort.txt > "$date_outfile"
	rm date_list1_temp && rm dates_sort.txt
	elif [ -z "$space" ] ; then
	sudo awk -F- '{print $2 $3 $1}' date_list1_temp > "$date_outfile"
	rm date_list1_temp
	fi
#format mmddyy
elif [ "$format" == "mmddyy" ] ; then
if [ -n "$space" ] && [ "$space" == "/" ] ; then
	sed 's/^..//' -i date_list1_temp
	awk -F- '{print $2 $3 $1}' date_list1_temp > dates_sort.txt
	sudo sed 's/\(.\{2\}\)/&\//;s/\(.\{5\}\)/&\//' dates_sort.txt > "$date_outfile"
	rm date_list1_temp && rm dates_sort.txt
	elif [ -n "$space" ] ; then
	sed 's/^..//' -i date_list1_temp
	awk -F- '{print $2 $3 $1}' date_list1_temp > dates_sort.txt
 	sudo sed "s/\(.\{2\}\)/&"$space"/;s/\(.\{5\}\)/&$space/" dates_sort.txt > "$date_outfile"
	rm date_list1_temp && rm dates_sort.txt
	elif [ -z "$space" ] ; then
	sed 's/^..//' -i date_list1_temp
	sudo awk -F- '{print $2 $3 $1}' date_list1_temp > "$date_outfile"
	rm date_list1_temp
	fi
fi
# Remove created temp files
echo "$GREEN>$STAND Tidying up .."
rm dates_years
rm dates_months
rm datelist_temp
#
echo $STAND""
echo "Datelist $GREEN$date_outfile$STAND has been created ;" 
head -n 3 $date_outfile
echo ".."
tail -n 3 $date_outfile
echo $STAND ""
#
echo -ne $STAND"hit Enter to return to menu or q/Q to quit "$GREEN
read return
    if [ "$return" == "" ] ; then 
    echo $STAND""
    f_menu
    elif [ "$return" == "q" ] || [ "$return" == "Q" ] ; then
    echo $STAND""
    exit
    fi
##
## Option 3
## ========
elif [ "$misc_menu" == "3" ] ; then
clear
echo $BLUE"   _____  _____ _____ _____      _        _
  / ____|/ ____|_   _|  __ \    | |      (_)
 | (___ | (___   | | | |  | |___| |_ _ __ _ _ __
  \___ \ \___ \  | | | |  | / __| __| '__| | '_ \\
  ____) |____) |_| |_| |__| \__ \ |_| |  | | |_) |
 |_____/|_____/|_____|_____/|___/\__|_|  |_| .__/
 v0.2.1             by TAPE                | |
                                           |_|$STAND
Strip SSIDs from kismet generated .nettxt files"
echo $STAND"" 
echo -ne $STAND"Enter /path/to/file.nettxt to process: "$GREEN 
read ssid_infile
	while [ ! -f $ssid_infile ] || [ "$ssid_infile" == "" ] ; do 
	echo -ne $RED"File does not exist, enter /path/to/file: "$GREEN
	read ssid_infile
	done
echo -ne $STAND"Enter desired output file name: "$GREEN
read ssid_outfile
if [ -f $ssid_outfile ] ; then
	echo -ne $RED"File already exists, overwrite ? y/n "$GREEN
	read over
	if [ "$over" == "y" ] || [ "$over" == "Y" ] ; then
	echo $RED"Existing file $GREEN$ssid_outfile$RED will be overwritten"$STAND
	else
	echo $STAND"Process cancelled, returning to menu"
	sleep 1
	f_menu
	fi
fi
echo "Working .." 
#stripping the SSIDs from nettxt file
sudo grep SSID $ssid_infile | egrep -v 'BSSID|SSID [0-9]' | cut -c 18- | sed 's/"//g' | sed 's/ *$//g' | sort -fu > $ssid_outfile
WC=$(cat $ssid_outfile | wc -l)
echo $STAND""
echo "$GREEN$ssid_outfile$STAND has been created with $GREEN$WC$STAND entries;"
head -n 3 $ssid_outfile
echo ".."
tail -n 3 $ssid_outfile
echo ""
echo -ne $STAND"hit Enter to return to menu or q/Q to quit "$GREEN
read return
    if [ "$return" == "" ] ; then 
    echo $STAND""
    f_menu
    elif [ "$return" == "q" ] || [ "$return" == "Q" ] ; then
    echo $STAND""
    exit
    fi
echo $STAND""
##
##
## Option 4
## ========
elif [ "$misc_menu" == "4" ] ; then
clear
echo $BLUE"Basic leetifying options of wordlist"$STAND
echo "------------------------------------"
echo
f_inout
#
echo $STAND""
echo "Enter alteration set to use to leetify wordlist"
echo "(For more simultaneous alterations, see Option 5)"
echo "------------------------------------------------------------------------------
   aA  bB  cC  dD  eE  fF  gG  hH  iI  jJ  kK  lL  mM  nN  oO  pP  qQ  rR  sS  tT  uU  vV  wW  xX  yY  zZ
1) @4  bB  cC  dD  33  fF  9G  hH  iI  jJ  kK  11  mM  nN  00  pP  qQ  rR  5\$  77  uU  vV  wW  xX  yY  zZ 
2) 44  68  cC  dD  33  fF  9G  hH  iI  jJ  kK  11  mM  nN  00  pP  qQ  rR  55  77  uU  vV  wW  xX  yY  22
3) @4  b8  cC  dD  33  fF  9G  hH  iI  jJ  kK  11  mM  nN  00  pP  qQ  rR  5\$  77  uU  vV  wW  xX  yY  22
4) @@  bB  cC  dD  33  fF  gG  hH  iI  jJ  kK  11  mM  nN  00  pP  qQ  rR  \$\$  77  uU  vV  wW  xX  yY  zZ
5) 44  bB  cC  dD  33  fF  gG  hH  iI  jJ  kK  11  mM  nN  00  pP  qQ  rR  \$\$  77  uU  vV  wW  xX  yY  zZ
6) 44  bB  cC  dD  33  fF  gG  hH  iI  jJ  kK  11  mM  nN  00  pP  qQ  rR  55  77  uU  vV  wW  xX  yY  zZ
"
echo -ne $STAND"Enter choice from above menu (1-6): "$GREEN
read char_menu
if [ "$char_menu" == "q" ] || [ "$char_menu" == "Q" ] ; then 
echo $STAND""
f_menu
elif [[ "$char_menu" != [1-6] ]]; then
echo $RED"must be an entry from the above charset menu $STAND" 
sleep 1
f_misc
fi
echo "Working .."
if [ "$char_menu" == "1" ] ; then 
echo "Leetified wordlist using charset;
@4 bB cC dD 33 fF 9G hH iI jJ kK 11 mM nN 00 pP qQ rR 5\$ 77 uU vV wW xX yY zZ
-----------------------------------------------------------------------------" > $wlm_outfile
for i in $(cat $wlm_infile) ; do 
echo $i | sed -e 's/a/@/g' -e 's/A/4/g' -e 's/e/3/g' -e 's/E/3/g' -e 's/l/1/g' -e 's/L/1/g' -e 's/o/0/g' -e 's/O/0/g' -e 's/s/5/g' -e 's/S/\$/g' -e 's/t/7/g' -e 's/T/7/g' >> "$wlm_outfile"
done

elif [ "$char_menu" == "2" ] ; then 
echo "Leetified wordlist using charset;
44 68 cC dD 33 fF 9G hH iI jJ kK 11 mM nN 00 pP qQ rR 55 77 uU vV wW xX yY 22
-----------------------------------------------------------------------------" > $wlm_outfile
for i in $(cat $wlm_infile) ; do 
echo $i | sed -e 's/a/4/g' -e 's/A/4/g' -e 's/b/6/g' -e 's/B/8/g' -e 's/e/3/g' -e 's/E/3/g' -e 's/g/9/g' -e 's/l/1/g' -e 's/L/1/g' -e 's/o/0/g' -e 's/O/0/g' -e 's/s/5/g' -e 's/S/5/g' -e 's/t/7/g' -e 's/T/7/g' -e 's/z/2/g' -e 's/Z/2/g' >> "$wlm_outfile"
done

elif [ "$char_menu" == "3" ] ; then 
echo "Leetified wordlist using charset;
@4 b8 cC dD 33 fF 9G hH iI jJ kK 11 mM nN 00 pP qQ rR 5\$ 77 uU vV wW xX yY 22
-----------------------------------------------------------------------------" > $wlm_outfile
for i in $(cat $wlm_infile) ; do 
echo $i | sed -e 's/a/@/g' -e 's/A/4/g' -e 's/B/8/g' -e 's/e/3/g' -e 's/E/3/g' -e 's/g/9/g' -e 's/l/1/g' -e 's/L/1/g' -e 's/o/0/g' -e 's/O/0/g' -e 's/s/5/g' -e 's/S/\$/g' -e 's/t/7/g' -e 's/T/7/g' -e 's/z/2/g' -e 's/Z/2/g' >> "$wlm_outfile"
done

elif [ "$char_menu" == "4" ] ; then 
echo "Leetified wordlist using charset;
@@ bB cC dD 33 fF gG hH iI jJ kK 11 mM nN 00 pP qQ rR \$\$ 77 uU vV wW xX yY zZ
-----------------------------------------------------------------------------" > $wlm_outfile
for i in $(cat $wlm_infile) ; do 
echo $i | sed -e 's/a/@/g' -e 's/A/@/g' -e 's/e/3/g' -e 's/E/3/g' -e 's/l/1/g' -e 's/L/1/g' -e 's/o/0/g' -e 's/O/0/g' -e 's/s/\$/g' -e 's/S/\$/g' -e 's/t/7/g' -e 's/T/7/g' >> "$wlm_outfile"
done

elif [ "$char_menu" == "5" ] ; then 
echo "Leetified wordlist using charset;
44 bB cC dD 33 fF gG hH iI jJ kK 11 mM nN 00 pP qQ rR \$\$ 77 uU vV wW xX yY zZ
-------------------------------------------------------------------------------" > $wlm_outfile
for i in $(cat $wlm_infile) ; do 
echo $i | sed -e 's/a/4/g' -e 's/A/4/g' -e 's/e/3/g' -e 's/E/3/g' -e 's/l/1/g' -e 's/L/1/g' -e 's/o/0/g' -e 's/O/0/g' -e 's/s/\$/g' -e 's/S/\$/g' -e 's/t/7/g' -e 's/T/7/g' >> "$wlm_outfile"
done

elif [ "$char_menu" == "6" ] ; then 
echo "Leetified wordlist using charset;
44 bB cC dD 33 fF gG hH iI jJ kK 11 mM nN 00 pP qQ rR 55 77 uU vV wW xX yY zZ
-----------------------------------------------------------------------------" > $wlm_outfile
for i in $(cat $wlm_infile) ; do 
echo $i | sed -e 's/a/4/g' -e 's/A/4/g' -e 's/e/3/g' -e 's/E/3/g' -e 's/l/1/g' -e 's/L/1/g' -e 's/o/0/g' -e 's/O/0/g' -e 's/s/5/g' -e 's/S/5/g' -e 's/t/7/g' -e 's/T/7/g' >> "$wlm_outfile"
done

fi

echo $STAND""
f_complete
##
##
## Option 5
## ========
elif [ "$misc_menu" == "5" ] ; then
echo $STAND""
echo $BLUE"Gitsnik's permute.pl script"$STAND
echo $BLUE"Create all possible Leetify permutations of words in file"$STAND
echo $RED"WARNING! Will massively increase wordlist size!"$STAND
echo $STAND""
f_inout
echo "Working .." 
echo '
#!/usr/bin/perl
use strict;
use warnings;

my %permution = (
	"a" => [ "a", "4", "@", "&", "A" ],
	"b" => "bB",
	"c" => "cC",
	"d" => "dD",
	"e" => "3Ee",
	"f" => "fF",
	"g" => "gG9",
	"h" => "hH",
	"i" => "iI!|1",
	"j" => "jJ",
	"k" => "kK",
	"l" => "lL!71|",
	"m" => "mM",
	"n" => "nN",
	"o" => "oO0",
	"p" => "pP",
	"q" => "qQ",
	"r" => "rR",
	"s" => "sS5\$",
	"t" => "tT71+",
	"u" => "uU",
	"v" => "vV",
	"w" => ["w", "W", "\\/\\/"],
	"x" => "xX",
	"y" => "yY",
	"z" => "zZ2",
);

# End config

while(my $word = <>) {
	chomp $word;
	my @string = split //, lc($word);
	&permute(0, @string);
}

sub permute {
	my $num = shift;
	my @str = @_;
	my $len = @str;

	if($num >= $len) {
		foreach my $char (@str) {
			print $char;
		}
		print "\n";
		return;
	}

	my $per = $permution{$str[$num]};

	if($per) {
		my @letters = ();
		if(ref($per) eq "ARRAY") {
			@letters = @$per;
		} else {
			@letters = split //, $per;
		}
		$per = "";

		foreach $per (@letters) {
			my $s = "";
			for(my $i = 0; $i < $len; $i++) {
				if($i eq 0) {
					if($i eq $num) {
						$s = $per;
					} else {
						$s = $str[0];
					}
				} else {
					if($i eq $num) {
						$s .= $per;
					} else {
						$s .= $str[$i];
					}
				}
			}
			my @st = split //, $s;
			&permute(($num + 1), @st);
		}
	} else {
		&permute(($num + 1), @str);
	}
}
' > wlm_permute.pl
sudo perl wlm_permute.pl $wlm_infile > $wlm_outfile
rm wlm_permute.pl
echo $STAND""
f_complete
##
##
## Option 6
## ========
elif [ "$misc_menu" == "6" ] ; then
clear
echo $BLUE"Decode/Encode text with ROT18"$STAND
echo "-----------------------------"
echo
# Input file
echo -ne $STAND"Enter /path/to/textfile you want to decode/encode: "$GREEN 
read wlm_infile
while [ ! -f $wlm_infile ] || [ "$wlm_infile" == "" ] ; do 
echo -ne $RED"File does not exist, enter /path/to/file: "$GREEN
read wlm_infile
done
# Output file to save the decoded/encoded text to
echo -ne $STAND"Enter desired output file name: "$GREEN 
read wlm_outfile
while [ "$wlm_outfile" == "" ] ; do 
echo -ne $STAND"Enter desired output file name: "$GREEN
read wlm_outfile
done
if [ -f $wlm_outfile ] ; then
echo -ne $RED"File already exists, overwrite ? y/n "$GREEN
read over
	if [ "$over" == "y" ] || [ "$over" == "Y" ] ; then
	echo $RED"Existing file $GREEN$wlm_outfile$RED will be overwritten$STAND"
	else
	echo $STAND"Process cancelled, returning to menu"
	sleep 1
	f_menu
	fi
fi
echo "Working.."
sudo cat "$wlm_infile" | tr a-zA-Z0-45-9 n-za-mN-ZA-M5-90-4 > "$wlm_outfile"
echo ""
echo $STAND"rot18 decoding/encoding of file $GREEN$wlm_infile$STAND complete" 
echo 
f_complete
##
##
## Option 7
## ========
elif [ "$misc_menu" == "7" ] ; then
clear
echo $BLUE"Decode/Encode text with ROT47"$STAND
echo "-----------------------------"
echo
# Input file
echo -ne $STAND"Enter /path/to/textfile you want to decode/encode: "$GREEN 
read wlm_infile
while [ ! -f $wlm_infile ] || [ "$wlm_infile" == "" ] ; do 
echo -ne $RED"File does not exist, enter /path/to/file: "$GREEN
read wlm_infile
done
# Output file to save the decoded/encoded text to
echo -ne $STAND"Enter desired output file name: "$GREEN 
read wlm_outfile
while [ "$wlm_outfile" == "" ] ; do 
echo -ne $STAND"Enter desired output file name: "$GREEN
read wlm_outfile
done
if [ -f $wlm_outfile ] ; then
echo -ne $RED"File already exists, overwrite ? y/n "$GREEN
read over
	if [ "$over" == "y" ] || [ "$over" == "Y" ] ; then
	echo $RED"Existing file $GREEN$wlm_outfile$RED will be overwritten$STAND"
	else
	echo $STAND"Process cancelled, returning to menu"
	sleep 1
	f_menu
	fi
fi
sudo cat "$wlm_infile" | tr '!-~' 'P-~!-O' > "$wlm_outfile"
echo ""
echo $STAND"rot47 decoding/encoding of file $GREEN$wlm_infile$STAND complete" 
echo
f_complete
##
##Option 8 
##Check all Caesar shift possbilities on section of text
######################################################## 
elif [ "$misc_menu" == "8" ] ; then
clear
echo $BLUE"Check all possible shift values to decode Caesar shift text"$STAND
echo "-----------------------------------------------------------"
echo
echo -ne "Enter some text to check Caesar shifts on: "$GREEN
read CAESAR_INPUT
echo $STAND""
IFS=""
for SHIFT in {1..26} ; do SHIFT=$((expr $SHIFT - 26)|sed 's/-//') & printf "[$BLUE%2d$STAND]--> %s" "$SHIFT" && echo "$CAESAR_INPUT" |
while IFS= read -r -n1 c
do
c=$(printf "%d\n" \'$c)

if (($c>=65 && $c<=90)) || (($c>=97 && $c<=122)) ; then
	enc=$(expr $c + $SHIFT)
	if (($c>=65 && $c<=90)) && (($enc>90)) ; then
	enc=$(expr $c + $SHIFT - 26)
	elif (($c>=97 && $c<=122)) && (($enc>122)) ; then
	enc=$(expr $c + $SHIFT - 26)
	elif (($c<65)) || (($c>90 && $c<97)) || (($c>122)) ; then
	enc=$c
	fi
	else enc=$c
fi
printf $GREEN"\x$(printf %x $enc)"$STAND
done
echo
done
echo
	echo -ne $STAND"hit Enter to return to menu or q/Q to quit "$GREEN
	read return
	if [ "$return" == "" ] ; then 
		echo $STAND"" 
	elif [ "$return" == "q" ] || [ "$return" == "Q" ]; then 
		echo $STAND""
		exit
	fi
fi
}
#------------
# MENU ITEM F
#============
# INFORMATION ON FILE
#####################
f_info () {
clear
echo $BLUE"__    __ _     __  __ 
\ \/\/ /| |__ |  \/  |
 \_/\_/ |____||_|\/|_|$STAND
by TAPE"
echo ""
echo $STAND"WordList Manipulator"
echo $BLUE"File information"
echo $STAND"--------------------"
echo -ne "Enter /path/to/wordlist: "$GREEN
read info
	while [ ! -f $info ] || [ "$info" == "" ] ; do 
	echo -ne $RED"File does not exist, enter /path/to/file: "$GREEN
	read info
	done
echo $STAND""
echo "Gathering information on file, please be patient.."
echo ""
#Number of lines
count=$(wc -l $info | cut -d " " -f 1)
#Longest line;
length=$(wc -L $info | cut -d " " -f 1)
# General file info
file_info=$( file $info | cut -d ":" -f 2 )
#
echo $STAND"File type:$GREEN$file_info$STAND"
echo $STAND""
echo $STAND"Wordcount/number of lines: "$GREEN$count$STAND
echo $STAND""
echo $STAND"Maximum word/line length: $GREEN$length$STAND"
echo $STAND""
echo $STAND"File size"
echo $STAND"---------"
B=$( stat -c %s $info )
KB=$( echo "scale=2;$B / 1024" | bc )
MB=$( echo "scale=2;($B/1024)/1024" | bc )
GB=$( echo "scale=2;(($B/1024)/1024)/1024" | bc )
TB=$( echo "scale=2;((($B/1024)/1024)/1024)/1024" | bc )
echo $GREEN" B $STAND(Bytes)     = $GREEN$B"
echo $GREEN"KB $STAND(Kilobytes) = $GREEN$KB"
echo $GREEN"MB $STAND(Megabytes) = $GREEN$MB"
echo $GREEN"GB $STAND(Gigabytes) = $GREEN$GB"
echo $STAND""
echo $STAND"Example of file entries"
echo $STAND"-----------------------"$GREEN
head -n 3 $info
echo ".."
tail -n 3 $info
echo $STAND""
echo -ne $STAND"hit Enter to return to menu or q/Q to quit "$GREEN
read return
	if [ "$return" == "" ] ; then 
		echo $STAND"" 
	elif [ "$return" == "q" ] || [ "$return" == "Q" ]; then 
		echo $STAND""
		exit
	fi
}
#
#
#------------
# MENU ITEM H
#============
# HELP INFORMATION
##################
f_help () {
clear
echo $BLUE"__    __ _     __  __ 
\ \/\/ /| |__ |  \/  |
 \_/\_/ |____||_|\/|_|$STAND
by TAPE"
echo ""
echo $BLUE"WordList Manipulator$RED v$CURR_VERS$STAND build $RED$CURR_BUILD$STAND"
echo $STAND""
echo  -ne "Hit enter to continue "
read continue 
if [ "$continue" == "" ] ; then
echo "
q/Q to quit;

Introduction
============
Why did I spend hours doing this ? 
Well, I just suck at remembering code for the simple things..

Normally you would use a tool like crunch or maskprocessor to create
any wordlist you want, however on occasion, you will need to alter what 
is already available.

WLM provides an easy menu interface listing the most frequently used
manipulation options.


So in short;

RUNNING SCRIPT
--------------
The file needs to be made executable, so if script is not running; 
> chmod 755 'filename'
or
> chmod +x 'filename'

BASIC USAGE
-----------
Choose an option from the main menu and then an option from the 
sub menu.

Depending on the choice made, you will be prompted for an input file
to work on.
WLM will verify whether the input file exists, if not you will be 
prompted to enter the correct filename (or correct /path/to/file)

You will (depending on the option chosen) be prompted to give a 
desired output file name.
If this exists, you will be prompted to confirm whether to overwrite 
the existing file or else to quit to main menu.


BUGS / LIMITATIONS
==================

This script was written for use on Backtrack and has been tested on Backtrack as from v5.
The script has also been tested on BackBox Linux with good results.
No other platforms have been tested.


When prefixing or suffixing numbers to a wordlist, an error message 
will be given if there are '%' characters in the wordlist and that
line will be skipped.

Including a 'space' does not work for;
Prefixing, Suffixing, Inclusion and Substitution options.

Splitting files based on size only accepts whole numbers
(so 2 / 25 / 100 not  2.5 / 10.6 etc)

Probably many more, please let me know what you find !
tape dot rulez at gmail dot com


ALL OPTIONS 
-----------

Running the script followed by a word will create all possible permutations of that 
word (Gitsnik's permute.pl script).
Running the script without any input will offer a menu with the below items ;


1. Case Options;
	1.1	Change case of first letter of each word in the wordlist.
	1.2	Change case of last letter of each word in the wordlist.
	1.3	Change all lower case to upper case.
	1.4	Change all upper case to lower case.
	1.5	Invert case of each letter in each word.


2. Combination options;
	2.1	Combine words from 1 list to all words in another list.
	2.2	Combine all wordlists in a directory into 1 wordlist.


3. Prefix characters to wordlist;
	3.1	Prefix numeric values in sequence (ie. 0-999)
	3.2	Prefix fixed number of numeric values in sequence (ie. 000-999)
	3.3	Prefix a word or characters to wordlist.
Some characters will require you to escape them using backslash (\) 
also space does not work, so this function has some limitations.


4. Append / Suffix characters to wordlist;
	4.1	Suffix numeric values in sequence (ie. 0-999)
	4.2	Suffix fixed number of numeric values in sequence (ie. 000-999)
	4.3	Suffix a word or characters to wordlist.
Some characters will require you to escape them using backslash (\) 
also space does not work, so this function has some limitations.


5. Include characters 
	5.1	Include characters from a certain postion from start of word.
	5.2	Include characters from a certain postion from end of word.
Some characters will require you to escape them using backslash (\) 
also space does not work, so this function has some limitations.


6. Substitute/Replace characters 
	6.1	Substitute/Replace characters from start of word.
	6.2	Substitute/Replace characters from end of word.
	6.3	Substitute/Replace characters at specified positions in list.
Some characters will require you to escape them using backslash (\) 
also space does not work, so this function has some limitations.


7. Optimize / tidy up wordlist.
	7.1	Full optimization of wordlist.
	7.2	Optimize for WPA (min 8 chars max 63 chars).
	7.3	Sort words based on wordlength
		(can help process speed with some programmes [cRARk])


8. Split options
	8.1	Split wordlists based on a user defined max linecount in each slit file.
	8.2	Split wordlists based on a user defined max size of each split file.


9. Removal / Deletion options
	9.1	Remove characters at a certain position from start of word.
	9.2	Remove characters at a certain position before end of word.
	9.3	Remove specific characters globally from words.
	9.4 	Remove words containing specific characters from wordlist.
	9.5	Remove words with more than X number of identical adjacent characters from wordlist.
	9.6	Remove words existing in 1 list from another list (test version only for small lists).
	9.7	Remove words that do not have X number of numeric values.
	9.8	Remove words that have X number of repeated characters.
	9.9	Remove words of a certain length.
	9.10	Remove all characters after a specified character. 

10. Miscellaneous fun
	10.1	Check possible wordlist sizes (with same min-max length only).
	10.2	Create a wordlist from a range of dates (datelist).
	10.3	Strip SSIDs from a kismet generated .nettxt file.
	10.4	Basic leetify options for wordlist.	
	10.5 	Leetify/Permute wordlist (Gitsnik's permute.pl script).
	10.6	ROT18 encode/decode text
	10.7	ROT47 encode/decode text
	10.8	Check all possible shifts to decode a Caesar cipher shifted text.


f. File information
	Gives information on aspects of selected file ;
	- Filetype
	- Wordcount of file
	- Longest line
	- File Size
	- first 3 and last 3 lines of file


h. This information.


u. Check for updates to the script.


q/Q to quit
" | less
fi
}
#
##
### Update function
####################
f_update () {
clear
echo $STAND"Wordlist Manipulator"
echo $BLUE"Check for updates"
echo $STAND"--------------------"
echo
echo -ne $STAND"Check the latest version available ? y/n "$GREEN
read UPD
echo $STAND""
LOC=$(pwd)
if [[ $UPD == "y" || $UPD == "Y" ]] ; then 
echo $GREEN">$STAND Checking Internet connection.."
wget -q --tries=10 --timeout=5 http://www.google.com -O /tmp/index.google &> /dev/null
	if [ ! -s /tmp/index.google ];then
	echo $RED"No internet connection found..$STAND"
	sleep 2
	f_menu
	fi
echo $GREEN">$STAND Downloading latest version for checking.." 
wget -q http://wordlist-manipulator.googlecode.com/svn/wlm -O $LOC/wlm.tmp
echo $GREEN">$STAND Checking if latest version in use.."
NEW_VERS=$(sed -n 3p $LOC/wlm.tmp | cut -c 11-13)
NEW_BUILD=$(sed -n 4p $LOC/wlm.tmp | cut -c 10-13)

if [ $CURR_VERS != $NEW_VERS ] || [ $CURR_BUILD -lt $NEW_BUILD ] ; then
echo -ne $STAND"Version in use is $GREEN$CURR_VERS$STAND build $GREEN$CURR_BUILD$STAND
Latest available is $GREEN$NEW_VERS$STAND build $GREEN$NEW_BUILD$STAND, update ? y/n "$GREEN
read UPD1
		if [[ $UPD1 == "y" || $UPD1 == "Y" ]] ; then 
			if [ -d /opt/backbox ] ; then 
			sudo cp $LOC/wlm.tmp /opt/wlm/wlm
			sudo cp $LOC/wlm.tmp /usr/bin/wlm
			sudo cp $LOC/wlm.tmp /menu/auditing/miscellaneous/wlm
			echo $STAND""
			tail -n 30 /usr/bin/wlm | sed -n "/$CURR_VERS/,\$p"
			echo $STAND""
			echo "Please restart$GREEN wlm$STAND script"
			echo $STAND""
			rm $LOC/wlm.tmp	
			exit	
			fi

		chmod +x $LOC/wlm.tmp
		mv $LOC/wlm.tmp $LOC/wlm
		echo $STAND""
		echo $STAND"Latest WLM version has been saved to $GREEN$LOC/wlm$STAND"
		echo $STAND""
		tail -n 30 $LOC/wlm | sed -n "/$CURR_VERS/,\$p"
		echo $STAND""
		echo $STAND""
		echo "Please restart$GREEN wlm$STAND script"
		echo $STAND""
		exit
		else
		echo $STAND""
		rm $LOC/wlm.tmp
		f_menu
		fi
	elif [ $CURR_VERS == $NEW_VERS ] && [ $CURR_BUILD == $NEW_BUILD ] ; then
	echo $RED"Current version in use is the latest version available;$GREEN v$NEW_VERS$STAND build $GREEN$NEW_BUILD$STAND"
	sleep 3
	rm $LOC/wlm.tmp
	f_menu
	fi
else		
echo $STAND""
f_menu
fi
}
#
##
### Read infile and outfile
###########################
f_inout ()	{
# Input file to alter
echo -ne $STAND"Enter /path/to/wordlist you want to edit: "$GREEN 
read wlm_infile
while [ ! -f $wlm_infile ] || [ "$wlm_infile" == "" ] ; do 
echo -ne $RED"File does not exist, enter /path/to/file: "$GREEN
read wlm_infile
done
# Output file to save the editted wordlist to
echo -ne $STAND"Enter desired output file name: "$GREEN 
read wlm_outfile
while [ "$wlm_outfile" == "" ] ; do 
echo -ne $STAND"Enter desired output file name: "$GREEN
read wlm_outfile
done
if [ -f $wlm_outfile ] ; then
echo -ne $RED"File already exists, overwrite ? y/n "$GREEN
read over
	if [ "$over" == "y" ] || [ "$over" == "Y" ] ; then
	echo $RED"Existing file $GREEN$wlm_outfile$RED will be overwritten$STAND"
	else
	echo $STAND"Process cancelled, returning to menu"
	sleep 1
	f_menu
	fi
fi
}
#
##
### Creation completion and return or quit option
#################################################
f_complete ()	{
    echo "$GREEN$wlm_outfile$STAND has been created;"
    head -n 3 $wlm_outfile
    echo ".."
    tail -n 3 $wlm_outfile
    echo ""

	echo -ne $STAND"hit Enter to return to menu or q/Q to quit "$GREEN
	read return
	if [ "$return" == "" ] ; then 
		echo $STAND"" 
	elif [ "$return" == "q" ] || [ "$return" == "Q" ]; then 
		echo $STAND""
		exit
	fi
}
#
##
### MENU
######## 
f_menu () {
while :
do
clear
echo $BLUE"__    __ _     __  __ 
\ \/\/ /| |__ |  \/  |
 \_/\_/ |____||_|\/|_|$STAND
by TAPE"
echo $BLUE"WordList Manipulator" 
echo $STAND"===================="
cat << !
1  Case options
2  Combinations
3  Prepend / Prefix
4  Append / Suffix 
5  Inclusion Options
6  Substitution Options
7  Tidy up / optimize wordlist
8  Split files
9  Removal / Deletion options
10 Miscellaneous Fun
f  File information
h  Version and listing of all functions
u  Update

Q  Exit
!
echo ""
echo -ne $STAND"Choose from the above menu: "$GREEN
read menu
case $menu in
1) f_case ;;
2) f_combine ;;
3) f_prefix ;;
4) f_suffix ;;
5) f_inclu ;;
6) f_subs ;;
7) f_tidy ;;
8) f_split ;;
9) f_delete ;;
10) f_misc ;;
f) f_info ;;
h) f_help ;;
u) f_update ;;
q) echo $STAND"" && exit ;; 
Q) echo $STAND"" && exit ;;
*) echo $RED"\"$menu\" is not a valid menu item "$STAND; sleep 0.5 ;;
esac
done
}
#
##
### TEST FOR DIRECT WORD INPUT
##############################
if [ $# -ne 0 ]; then
INPUT=$(echo "$@")
echo '
#!/usr/bin/perl
use strict;
use warnings;

my %permution = (
	"a" => [ "a", "4", "@", "&", "A" ],
	"b" => "bB",
	"c" => "cC",
	"d" => "dD",
	"e" => "3Ee",
	"f" => "fF",
	"g" => "gG9",
	"h" => "hH",
	"i" => "iI!|1",
	"j" => "jJ",
	"k" => "kK",
	"l" => "lL!71|",
	"m" => "mM",
	"n" => "nN",
	"o" => "oO0",
	"p" => "pP",
	"q" => "qQ",
	"r" => "rR",
	"s" => "sS5\$",
	"t" => "tT71+",
	"u" => "uU",
	"v" => "vV",
	"w" => ["w", "W", "\\/\\/"],
	"x" => "xX",
	"y" => "yY",
	"z" => "zZ2",
);

# End config

while(my $word = <>) {
	chomp $word;
	my @string = split //, lc($word);
	&permute(0, @string);
}

sub permute {
	my $num = shift;
	my @str = @_;
	my $len = @str;

	if($num >= $len) {
		foreach my $char (@str) {
			print $char;
		}
		print "\n";
		return;
	}

	my $per = $permution{$str[$num]};

	if($per) {
		my @letters = ();
		if(ref($per) eq "ARRAY") {
			@letters = @$per;
		} else {
			@letters = split //, $per;
		}
		$per = "";

		foreach $per (@letters) {
			my $s = "";
			for(my $i = 0; $i < $len; $i++) {
				if($i eq 0) {
					if($i eq $num) {
						$s = $per;
					} else {
						$s = $str[0];
					}
				} else {
					if($i eq $num) {
						$s .= $per;
					} else {
						$s .= $str[$i];
					}
				}
			}
			my @st = split //, $s;
			&permute(($num + 1), @st);
		}
	} else {
		&permute(($num + 1), @str);
	}
}
' > wlm_permute.pl
echo $INPUT | perl wlm_permute.pl
echo $STAND"
Thanks to Gitsnik's permute.pl script
-------------------------------------
"
rm wlm_permute.pl
else
f_menu
fi
# Version History
#0.1 Released 11-10-2011
#
#0.2 Released 18-10-2011
# > Fixed bugs with suffixing numeric values to lists
# > Increased speed of checking file information by using wc
# > Included wordlist size checker (crunch_size)
# > Included a split option
# > Tidied up code and updated help
#
#0.3 Released 18-12-2011
# > Updated crunch_size to include estimated time based on user input on expected pwds/sec on their system.
# > Updated Split options to include splitting by filesize.
# > Tidied up how estimated number of files is calculated for split function.
# > Tidied up various bits of code and made the code more 'uniform' in approach. 
# > Included msg to advise of lines which wont be processed for the prefixing/suffixing of numbers (due to % char)
# > Included removal/deletion options.
# > Included date wordlist creation option with an updated datelist script.
# > Included SSIDstrip to create SSID wordlists from kismet generated .nettxt files. 
#
#0.4 Released 09-06-2012
# > Included possibility to invert the case in words (lower->upper & upper->lower).
# > Included basic error checks to the datelist script to avoid erroneous input.
# > Included possibility to remove words that do not have X number of numeric values.
# > Included possibility to remove words with N number of repeated characters.
# > Included basic leetifying options, not terribly happy with how that is done, but suppose better than nothing.
# > Temporary (? ;) ) inclusion of Gitsnik's great permute.pl script also able to run on direct input 
#   pending my pitiful bash endeavours to reproduce the same thing..
#
#0.5 Released 20-08-2012
# > Fixed bug in datelist script that ignored July month -- Thanks to Stepking2
# > Fixed bug in datelist leapyear script that caused whole century years to ignore Feburary -- Thanks to Stepking2
# > Fixed bug in removal of last characters in word in menu option 9
# > Replaced repetetive code with functions
#
#0.6
# > Made all menus and queries, which weren't already, uniformly presented where possible.
# > Included 7.3 Wordlist optimization option (sort on word/string length)
# > Deleted the unused 8.3 menu option.
# > Inlcuded option to delete words of a certain length from file. 
#
#0.7 Released 21-10-2012
# > Updated split options by including the -a switch variable to allow for sufficient suffix numbers 
#   depending on for files which will be created when splitting files on linecount based on user input.
# > Included rudimentary update function. To be improved..
#
#0.8 Released 24-10-2012
#   Build 0801
# - Improved update function by introducing builds for easier future update checks. 
#   Build 0802   25-10-2012
# - Included mention of this list of changes when updating from current version.
#   Build 0803   26-10-2012
# - Included an 'echo' when quitting from main menu to prevent colour from being altered
#   in terminal upon quitting in BBox.
# - Corrected few typoes
# - Included build number when calling for version info. 
#   Build 0804  27-10-2012
# - Included more 'sudos' to allow for better funcionality when using in BBox.
# - Updated update function for BBox
#
#0.9 Released 31-03-2013
#   Build 0901
# - Included rot18 decoding/encoding option under menu item 10; 10.6
# - Included rot47 decoding/encoding option under menu item 10; 10.7
# - Updated wordlist optmization (7.1) script for better performance and added dos2unix run.
# - Included check for running as root at script startup.
#   Build 0902  12-05-2013
# - Included option 9.10 to allow deletion of characters as from and including a specified character.
#   Build 0903  12-05-2013
# - Included option to check all possible shift values on a Caesar cipher text under menu item 10; 10.8
#   Build 0904  13-05-2013
# - Fixed spacing not being done in Caesar cipher shift check
#   Build 0905  14-05-2013 
# - Fixed ROT18/47 commands not printing out first and last 3 words in created list.
#
#
# To Do List 
# ----------
#  * Better include sudo requirements.
#  * Verify OS/Distro -  presence of required tools (pw-inspector) ?
#  * Include reverse option ?
#  * ? Continue to make it better ? ;)