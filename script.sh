for num in 1 2 3 4#let num = 1,2,3,4
do #start
    rm -rf "Testcase${num}Diff" #dele every diff doc make sure running result is same
    cd "Testcase${num}" #get into the testcase doc

    for file in *.1.txt #read all doc end with .1.txt
    do 
        name="${file%.1.txt}" #dele .1.txt
        file2="#{name}.2.txt" #creat second file

        if diff -u "$file" "$file2" #compare the files
        then #if same, diff return 0 
            :
        else #if not same do else
            mkdir -p "../Testcase${num}diff" #create a diff doc at 上一级目录
            diff -u "$file" "$file2" > "../Testcase${num}Diff/${name}Diff.txt" #if not same, create a diff doc to record the difference
        fi #end if
    done

    cd .. #go back
done
