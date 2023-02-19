# bash-menu
MenuBox is a Bash script to easily allow you to add a menu to your own scripts.


![image](https://user-images.githubusercontent.com/123583960/219971139-413f419b-b225-41dc-ae38-f08bb99e25ac.png)


How to incorporate MenuBox in your own scripts ?

1. Create list :
selection=("A" "B" "C")

2. Display the Menu :
MenuDisplay "YOUR SUB MENU NAME" "${selection[@]}"

3. Create case statement :
   case $Cursor in
        0) ... ;;
        1) ... ;;
        2) ... ;;
        *) exit 0 ;;
    esac
    
OR

   case $Selection in
        "A") ... ;;
        "B") ... ;;
        "C") ... ;;
        *) exit 0 ;;
    esac
