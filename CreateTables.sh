#! /bin/bash
#********************** Create Database Tables ********************


while [ true ]
do
    read -p "Enter table name" table_name
    if [[ $table_name =~ ^[a-zA-Z]+[a-zA-Z_0-9]+$ ]];then
        if ! [[ -f $table_name ]];then
        sudo touch $table_name
        echo "Table Created Successfuly"
        read -p "How Many Columns you want to create?" num_of_fields
        count=0
        while (( $count < $num_of_fields ))
        do
            read -p "Enter column $(($count+1)) Name: " col_name
            if [[ $col_name =~ ^[a-zA-Z]+[a-zA-Z_0-9]+$ ]];then
                if [[ -f "$table_name meta_data.txt" ]];then
                    sudo chmod a+rw "$table_name meta_data.txt"
                    #`awk -F':' '{ while ('$col_name' == $1 ){print "The column already exist, Please try again"}}' "$table_name meta_data.txt"`
                    #while [ $col_name == $(grep $col_name "$table_name meta_data.txt") ]
                    #do
                    #    echo "The column already exist, Please try again!!"
                    #    read -p "Enter column $(($count+1)) Name: " col_name
                    #done
                    while [[ "$(cut -d: -f1 "$table_name meta_data.txt" | grep $col_name | head -1)" == $col_name ]]
                    do        
                            echo "The column already exist, Please try again!!"
                            read -p "Enter column $(($count+1)) Name: " col_name
                    done
                else
                    sudo touch "$table_name meta_data.txt"
                    sudo chmod a+rw "$table_name meta_data.txt"
                    echo "Meta_data file Created Successfully with name $table_name meta_data.txt !!!!!"
                fi
                read -p "KIndly Seclect Column DataType [ 1-int 2-string ]: " choice
                    case $choice in 
                    "int")
                        if [ $count == 0 ];then
                            constraint_of_col="PK"
                        else
                            constraint_of_col="null"
                        fi
                        record="$col_name:$choice:$constraint_of_col"
                        echo $record >> "$table_name meta_data.txt"
                        echo "Data added Successfully!!!!"
                        echo "Column $(($count+1)) name is: $col_name, DataType is $choice and $constraint_of_col"
                        count=$((count+1))
                    ;;
                    "string")
                        if [ $count == 0 ];then
                            constraint_of_col="PK"
                        else
                            constraint_of_col="null"
                        fi
                        record="$col_name:$choice:$constraint_of_col"
                        echo $record >> "$table_name meta_data.txt"
                        echo "Column $(($count+1)) name is: $col_name, DataType is $choice and $constraint_of_col"
                        count=$((count+1))
                    ;;
                    *)
                        echo "Sorry!! you enter invalid Datatype"
                    ;;
                    esac                    
                #searh_col_name=$(grep $col_name $table_name)
                #if [ $col_name == $searh_col_name ];then
                #    echo "This Column Already Exists!!"
                #else 
                #    echo "$i) $col_name" >> $table_name
                #fi
            else
                echo "You Entered Invalid Column Name !!!"
                echo "Please Tty Again!!"
            fi
            if (( $count == $num_of_fields ));then
                echo "Your Data added successfully !!!!"
                break
                exit
            fi
        done
        break
        else 
            echo "This table is Exsit!!, Please enter another name."
        fi
    else
        echo "You Enter Invalid Table Name !!!"
        echo "Please Try Again!!"
    fi
done
