
all_pass=1 #所有Testcase都通过，1 表示通过

for num in 1 2 3 4 #依次检查四个 Testcase
do
    folder="Testcase${num}" #创建原始文件夹
    output="Testcase${num}Diff" #保存diff doc
    pass=1 #Testcase 默认为通过
    has_diff=0 #0 表示目前没有发现差异

    for file in "$folder"/*.1.txt # 遍历所有 .1.txt 文件
    do
        name="${file%.1.txt}" # 删除 .1.txt 后缀，获得共同文件名
        file2="${name}.2.txt" # 找到对应的 .2.txt 文件
        name="${name##*/}" # 删除路径，只保留文件名
        result="$output/${name}Diff.txt" # 对应的 Diff 输出文件

        if [ ! -f "$file2" ] # 检查有没有第二个文件
        then
            pass=0 # 失败
        elif cmp -s "$file" "$file2" # 检查两个文件是否相同
        then
            if [ -f "$result" ] #检查有没有 Diff doc
            then
                pass=0 # 失败
            fi
        else
            has_diff=1 # 发现两个文件存在差异

            if [ ! -f "$result" ] # 检查有没有 Diff doc
            then
                pass=0 # 缺少输出文件，检查失败
            else
                if diff -u "$file" "$file2" | cmp -s - "$result"
                then
                    : #比较结果正确，无操作
                else
                    pass=0 #不正确
                fi
            fi
        fi
    done

    if [ "$has_diff" -eq 1 ] # 如果发现文件有差异
    then
        if [ ! -d "$output" ] # 检查 Diff 不存在
        then
            pass=0 # 失败
        fi
    else #如果没差
        if [ -d "$output" ] # 如果存在diff 文件
        then
            pass=0 # 失败
        fi
    fi

    if [ "$pass" -eq 1 ] # 如果通过
    then
        echo "Testcase${num}: PASS" # 输出 PASS
    else
        echo "Testcase${num}: FAIL" # 输出 FAIL
        all_pass=0 # 记录有 Testcase 失败
    fi
done

if [ "$all_pass" -eq 1 ] # 检查全部 Testcase 是否通过
then
    exit 0 # 所有 Testcase 正确
else
    exit 1 # 至少一个 Testcase 错误
fi
