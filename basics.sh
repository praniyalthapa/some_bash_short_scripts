for ((i=0; i<3; i++))
do
    echo "Enter your favourite tool $(($i+1))"
    read tool
    array+=("$tool")  # Append the input to the array
done

for ((i=0; i<3; i++))
do
    echo "Tool $((i+1)): ${array[$i]}"
done
