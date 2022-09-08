while [ true ]
do
    read -p "Enter Table You want to UPdate it from: " table_name
     echo "********************** List Of Columns Names ************************"
    if [[ $table_name =~ ^[a-zA-Z]+[a-zA-Z_.0-9]+$ ]];then
        if [[ -f $table_name ]];then
            break
        else
            echo "This table doesn't Exsit !!, Please enter another name."
        fi
    else
        echo "You Enter Invalid Table Name !!!"
        echo "Please Try Again!!"
    fi
done
while [ true ]
do
    read -a col_names <<< `awk -F':' '{print $1}' "$table_name meta_data.txt"`
    read -a col_datatypes <<< `awk -F':' '{print $2}' "$table_name meta_data.txt"`
    read -a col_constraints <<< `awk -F':' '{print $3}' "$table_name meta_data.txt"`
    
    select cname in ${col_names[@]} "ExitToPrevious"
    do
        if [ $cname == "ExitToPrevious" ];then
                exit
        fi
        lnum=($(grep -n $cname "$table_name meta_data.txt" | cut -d: -f1))
        echo ${col_names[lnum-1]}
        echo ${col_datatypes[lnum-1]}
        echo ${col_constraints[lnum-1]}

        read -p "Enter PK value of the record you want to Update it: " value

        if [[ `awk -F':' '{if($1=='$value'){print '$value'}}' "$table_name"` == $value ]];then

            read -r -p "Enter updated value of PK $value: " new_value
            if [ ${col_datatypes[lnum-1]} == "int" ];then
                while ! [[ $new_value =~ ^[0-9]+$ ]]
                do
                    echo "You Entered Invalid value, Please Enter Integer value!!"
                    read -p "Enter Integer Column Value: " new_value
                done
                while [[ `cut -d: -f1 $table_name | grep $new_value | head -1` == $new_value ]]
                do    
                    echo "You Entered Repeated ID and it's Invalid"
                    read -p "Enter Column Value: " new_value
                    while ! [[ $new_value =~ ^[0-9]+$ ]] 
                    do
                        echo "You Entered Invalid value, Please Enter Integer value!!"
                        read -p "Enter Integer Column Value: " new_value
                    done
                done
            fi
            old_value=`awk -F: '{if($1=='$value')print $'$(($lnum-1))'}' "$table_name"`
            echo $old_value
            sudo sed -i ''"$value"'s/'"$old_value"'/'"$new_value"'/g' "$table_name"
            echo "Record Updated successfuly!!!!"
            break
        else
            echo "You Entered ID not Found!!, please Enter valid ID"
        fi
        
    done
done