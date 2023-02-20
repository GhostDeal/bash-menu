#!/bin/bash

#######################
# SIAEF MenuBox v1.0  #
#######################

function MenuDisplay {
    local Formatting_Set_Reverse="\e[7m"
    local Reset_Color="\e[0m"
    local Color_Green="\e[38;5;49m"
    local Color_Orange="\e[38;5;214m"
    local Clear_Screen="\033c"
    local SubTitle="$1"
    shift
    local options=("$@")
    local cur=0
    local index=0
    local count=${#options[@]}
    local esc=$(echo -en "\e")

    while true
    do
        echo -en $Clear_Screen
        echo -e ""
        echo -e "   \e[48;5;27m                           Menu Box                          $Reset_Color"
        echo -e ""
        echo -e "   $Color_Green > $Reset_Color$Color_Orange$SubTitle$Reset_Color"
        echo -e ""

        # list all options
        index=0
        for out_text in "${options[@]}"
        do
            if [ "$index" == "$cur" ]
            then
                echo -e "     $Color_Green[X]$Reset_Color $Formatting_Set_Reverse$out_text$Reset_Color" # mark & highlight the current option
            else
                echo -e "     [ ] $out_text"
            fi
            index=$(( $index + 1 ))
        done
        
        # wait for user to key in arrows
        read -s -n3 key 
        
        # up arrow
        if [[ $key == $esc[A ]]  
        then
            cur=$(( $cur - 1 )) 
            if [ $cur -eq -1 ] 
            then
                cur=$(( $count - 1 ))
            fi
        fi

        # down arrow
        if [[ $key == $esc[B ]]
        then
            cur=$(( $cur + 1 ))
            if [ $cur -eq $count ]
            then
                cur=0
            fi
        fi

        # read delimiter - ENTER
        if [[ $key == "" ]] 
        then
		    # export the user selection (without color)
		    Selection="$(sed -r "s/\x1B(\[[0-9;]*[JKmsu]|\(B)//g" <<< "${options[$cur]}")"
		    Cursor=$cur
		    return 0
        fi
    done
}

function Menu() {
    selection=(
	"Choice 01"
    	"Choice 02"
	"Choice 03"
	"Second Menu"
	"Exit"
    )
    MenuDisplay "Main Menu" "${selection[@]}"
    
    case $Cursor in
        0) echo "You chosen => " $Selection ; sleep 2 ;;
        1) echo "You chosen => " $Selection ; sleep 2 ;;
        2) echo "You chosen => " $Selection ; sleep 2 ;;
		3) Second_Menu ;;
        *) exit 0 ;;
    esac
}

function Second_Menu() {
    selection=(
	"Choice A"
    	"Choice B"
	"Choice C"
	"<= Previous"
	"Exit"
    )
    MenuDisplay "Second Menu" "${selection[@]}"
    
    case $Selection in
        "Choice A") echo "You chosen => " $Selection ; sleep 2 ;;
        "Choice B") echo "You chosen => " $Selection ; sleep 2 ;;
        "Choice C") echo "You chosen => " $Selection ; sleep 2 ;;
	"<= Previous") Menu ;;
        *) exit 0 ;;
    esac
}

while true
do
	Menu
done
