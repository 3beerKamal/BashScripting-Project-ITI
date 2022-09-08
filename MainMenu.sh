#! /bin/bash
#********************** Main Menu ********************
#echo "************** Welcome To DBMS! 😍 ***************"
if [ -e "Databases" ]; then
    echo "*******************************"
    echo "Your Main Menu 😌!!"
    echo "*******************************"
else 
    sudo mkdir ./Databases
    if [ -d "Databases" ];then
        echo "Data Base Created Successfully!!!"
    else
        echo "There's a Problem Happened, Please try again"
    fi
fi

select choice in "Create DB" "ListBDs" "DropDB" "ConnectDB" "Exit"
do 
    case $choice in
    "Create DB" )
        echo "*******************************"
        echo "Hello From Creating DataBase 🤩!!"
        echo "*******************************"
        source CreateDB.sh
    ;;
    "ListBDs" )
        echo "*******************************"
        echo "List Of Your DataBases are 👀 !!"
        echo "*******************************"
        source ListDBs.sh
    ;;
    "DropDB" )
        echo "*******************************"
        echo "Drop any Database 😞!!"
        echo "*******************************"
        source RemoveDB.sh
    ;;
    "ConnectDB" )
        echo "*******************************"
        echo "Connet to Table 💃!!"
        echo "*******************************"
        source ConnectDB.sh
    ;;
    "Exit" )
        echo "*******************************"
        echo "Thank You For Using Or System 😎!!"
        echo "*******************************"
        exit

    ;;
    *)
        echo "You Enter Invalid Choice, please try again"
    esac
done 