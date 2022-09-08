
select choice in "SelectAll" "SelectSpecificRow" "SelectByConditional" "Exit"
do
    case $choice in 
    "SelectAll")
        while [ true ]
        do 
            read -p "Enter Table Name You want to select From it: " table_name
            if [[ $table_name =~ ^[a-zA-Z]+[a-zA-Z_.0-9]+$ ]];then
                if [[ -f $table_name ]];then
                    read -a col_names <<< `awk -F':' '{print $1}' "$table_name meta_data.txt"`
                    new_col_names=("")
                    for tname in ${col_names[@]}
                    do
                        new_col_names+=("$tname :")
                    done
                    echo ${new_col_names[@]}
                    echo "***********************"
                    cat $table_name
                    break
                else 
                    echo "This table doesn't Exsit !!, Please enter another name."
                fi
            else
                echo "You Enter Invalid Table Name !!!"
                echo "Please Try Again!!"
            fi
        done
    ;;
    "SelectSpecificRow")
        while [ true ]
        do
            read -p "Enter Table you want to select From it: " table_name
            echo "********************** List Of Columns ************************"
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
        read -a col_names <<< `awk -F':' '{print $1}' "$table_name meta_data.txt"`
        select cname in ${col_names[@]} "ExitToPrevious"
        do
            if [ $cname == "ExitToPrevious" ];then
                exit
            fi
            lnum=($(grep -n $cname "$table_name meta_data.txt" | cut -d: -f1))
            read -p "Enter $cname value to select Row by it: " value
            awk -F':' '{if($('$lnum')=='$value'){print $0}}' "$table_name"
        done
    ;;
    #"SelectByConditional")
    #;;
    "Exit")
        exit
    ;;
    *)
        echo "You Entered invalid Option"
    ;;
    esac

done
   
