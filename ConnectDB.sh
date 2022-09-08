#! /bin/bash
#********************** Connect to Database ********************

read -p "Please, Enter Your DB name: " DBname
if [[ $DBname =~ ^[a-zA-Z]+[a-zA-Z_0-9]+$ ]];then
    if [[ -e $DBname ]];then
        echo "DB Exist"
        cd ./$DBname
        echo "*******************************"
        echo "Hello From Inside $DBname Database!!"
        echo "*******************************"
        select choice in "Create Table" "List Table" "Drop Table" "Insert Table" "Select From Table" "Delete From Table" "Update Table" "MainMenu"
        do
            case $choice in
            "Create Table" )
                echo "*****************************************"
                echo "Create $DBname Tables!!"
                echo "*****************************************"
                ../../CreateTables.sh
            ;;
            "List Table" )
                echo "*****************************************"
                echo "List $DBname Tables!!"
                echo "*****************************************"
                ls -lF | grep -v /
            ;;
            "Drop Table" )
                echo "*****************************************"
                echo "Drop $DBname Tables!!"
                echo "*****************************************"
                ../../DropTable.sh
            ;;
            "Insert Table" )
                echo "*****************************************"
                echo "Insert Data in $DBname Tables!!"
                echo "*****************************************"
                ../../InsertData.sh 
            ;;
            "Select From Table" )
                echo "*****************************************"
                echo "Select Data from $DBname Tables!!"
                echo "*****************************************"
                ../../SelectFromTable.sh
            ;;
            "Delete From Table" )
                echo "*****************************************"
                echo "Delete Data from $DBname Tables!!"
                echo "*****************************************"
                ../../DeleteFromTable.sh
                
            ;;
            "Update Table" )
                echo "*****************************************"
                echo "Update Data into $DBname Tables!!"
                echo "*****************************************"
                ../../UpdateFromTable.sh
            ;;
            "MainMenu" ) 
                echo "***************** Welcome again from Main Menu!! 😍 **************"
                exit
            ;;
            *)
                echo "You Entered Invalid Choice, please try again!!"
            esac
        done
    else
        echo "DataBase Dosen't Exist!!"
        echo  "Enter another DB"
    fi
else
    echo "Your Entered Invalid Database name !!!"
    echo "Please Try Again!! Thank You 🍁"
fi
