#! /bin/bash
#********************** Creating Database ********************
shopt -s extglob
read -p "Please, Enter Your DB name: " DBname
cd ./Databases
if [[ -e $DBname ]];then
    echo "This Database is Exist"
    echo "****************************************"
else
    if [[ $DBname =~ ^[a-zA-Z]+[a-zA-Z_0-9]+$ ]];then
        sudo mkdir $DBname
        echo "Your Database created Successfully !!!!!"
        
    else
        echo "You Enter Invalid name for your DB!!!!!"
       
    fi
fi
