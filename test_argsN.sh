#!/bin/bash

input_file1=data/first_test1.txt
input_file2=data/second_test1.txt


echo "--- args Test - ---"

chmod +x Levenshtein.sh

./Levenshtein.sh $input_file1 $input_file2 > /dev/null

if [[ $? -eq 0 ]]
then
    echo "Test №1 passed!"
else
    echo "Test №1 failed"
    echo "Input: $input_file1 $input_file2"
    exit 1
fi

