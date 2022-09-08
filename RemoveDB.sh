#! /bin/bash
#********************** Hello From Drop Database ********************
cd ./Databases
read -p "Please Enter DataBase You Want to Remove it: " DB
if [[ $DB =~ ^[a-zA-Z]+[a-zA-Z_0-9]+$ ]];then
    if [ -e $DB ];then
        echo "The Database is exsit.!!"
        read -p "Do you want remove it?" ans
        if [ $ans == 'y' -o  $ans == "Y" ];then
            sudo rm -r $DB
            echo "Database Deleted Successfully !!!!!!!!"
        elif [ $ans == 'n' -o $ans == "N" ];then
            echo "Thank You !!!!!!!"
            
        fi
    else
        echo "The Database doesn't exit?"
        
    fi
else
    echo "You Entered invalid Database Name!!"
fi