#! /bin/bash
#********************** Insert Data Into Table  ********************


ls -F | grep -v /
while [ true ]
do 
    read -p "Please, Enter Table Name which you want to insert data into it: " table_name
    if [[ $table_name =~ ^[a-zA-Z]+[a-zA-Z_.0-9]+$ ]];then
        if [[ -f $table_name ]];then
            if [ -f "$table_name meta_data.txt" ];then
                sudo chmod a+rwx $table_name
                counter=($(wc -l "$table_name meta_data.txt"))
                read -a col_names <<< `awk -F':' '{print $1}' "$table_name meta_data.txt"`
                read -a col_datatypes <<< `awk -F':' '{print $2}' "$table_name meta_data.txt"`
                read -a col_constraints <<< `awk -F':' '{print $3}' "$table_name meta_data.txt"`
                i=0
                table_data=()
                while [ $i -lt $counter ]
                do
                    echo "$table_name Table contains ${col_names[i]} column while it has dataType is ${col_datatypes[i]} and it's constraints ${col_constraints[i]}"
                    read -p "Enter Column Value: " user_entry
                    #******************************** Validate interger Numbers ***********************************
                    if [ ${col_datatypes[$i]} == "int" ];then
                        while ! [[ $user_entry =~ ^[0-9]+$ ]]
                        do
                                echo "You Entered Invalid value, Please Enter Integer value!!"
                                read -p "Enter Integer Column Value: " user_entry

                        done
                    #********************************* Validate Primary Key ***************************************
                    
                        while [[ `cut -d: -f1 $table_name | grep $user_entry | head -1` == $user_entry ]]
                        do    
                            echo "You Entered Repeated ID and it's Invalid"
                            read -p "Enter Column Value: " user_entry
                            while ! [[ $user_entry =~ ^[0-9]+$ ]] 
                            do
                                echo "You Entered Invalid value, Please Enter Integer value!!"
                                read -p "Enter Integer Column Value: " user_entry
                            done
                        done
                       
                    #******************************** Validate interger Strings ***********************************
                    elif [ ${col_datatypes[i]} == "string" ];then
                        while ! [[ $user_entry =~ ^[A-Z_a-z]+$ ]]
                        do
                                echo "You Entered Invalid value, Please Enter Integer value!!"
                                read -p "Enter Integer Column Value: " user_entry

                        done
                    fi
                    table_data+=("$user_entry:")
                    i=$(($i+1))
                done
                echo "${table_data[@]}" >> $table_name
                break
            else
                echo "This table does't exist !!, Please enter create your meta_data file."
            fi
        else
            echo "This table does't exist !!, Please enter another name."
        fi
    else
        echo "You Enter Invalid Table Name !!!"
        echo "Please Try Again!!"
    fi
done