while [ true ]
do
    read -p "Enter Table You want to Delete it from: " table_name
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
    read -p "Enter ID (PK) value to Delete Row by it: " value
    record_num=`awk -F':' '{if($1=='$value'){print NR}}' "$table_name"`
    if [ $record_num ];then
        sudo sed -i ''$record_num'd' "$table_name"
        echo "Record deleted successfuly!!!!"
        break
    else
        echo "You Entered ID not Found!!, please Enter valid ID"
    fi
done
