#!/bin/bash

input_file1=data/first_test2.txt
input_file2=data/second_test2.txt

echo "-- Output Test №2 --"
chmod +x Levenshtein.sh
./Levenshtein.sh $input_file1 $input_file2 > /dev/null

expected=`./Levenshtein.sh $input_file1 $input_file2`
expected_diff=0

while read str
do
  text1[cnt_str1]=$str
  cnt_str1=$(($cnt_str1+1))
  total_symbols1=$(($total_symbols1+${#str}))
done < $input_file1

while read str
do
  text2[cnt_str2]=$str
  cnt_str2=$(($cnt_str2+1))
  total_symbols2=$(($total_symbols2+${#str}))
done < $input_file2

result="Количество символов в первом файле - $total_symbols1 Количество символов во втором файле - $total_symbols2 Разница символов равно - $expected_diff"
if [[ $result == $expected ]]
then
    echo "Test №1 passed!"
else
    echo "Test №1 failed!"
    echo "Expected: $expected"
    echo "Output: $result"
    exit 1
fi