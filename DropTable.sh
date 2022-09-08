#******************* Hello From Drop Table *****************

read -p "Please Enter Table Name Which You Want to Delete it: " table_name
ls -F $table_name | grep -v /
if [[ $table_name =~ ^[a-zA-Z]+[a-zA-Z_.0-9]+$ ]];then
    if [[ -f $table_name ]];then
        echo "The Table is exsit.!!"
        read -p "Do you want remove it?" ans
        if [ $ans == 'y' -o  $ans == "Y" ];then
            sudo rm $table_name
            sudo rm "$table_name meta_data.txt"
            echo "Table Deleted Successfully !!!!!!!!"
        elif [ $ans == 'n' -o $ans == "N" ];then
            echo "Thank You !!!!!!!"  
        fi
    else
        echo "The Table doesn't exit?"
        
    fi
else
    echo "You Entered invalid Table Name!!"
fi