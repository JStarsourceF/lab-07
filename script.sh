for num in 1 2 3 4
do 
    rm -rf "Testcase${num}Diff"
    cd "Testcase${num}"

    for file in *.1.txt
    do 
        name = "${file%.1.txt}"
        file2 = "#{name}.2.txt"

        if diff -u "$file" "$file2" > /dev/null
        then
            :
        else
            mkdir -p "../Testcase${num}diff"
            diff -u "$file" "$file2" > "../Testcase${num}Diff/${name}Diff.txt"
        fi
    done

    cd..
done
