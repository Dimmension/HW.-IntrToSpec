#!/bin/bash
flag1=1
flag2=1
if [[ ! -n $1 ]] || [[ ! -n $2 ]] 
then
  echo "Недостаточно аргументов!"
  flag1=0
fi
if [[ ! -f $1 ]] || [[ ! -f $2 ]]
then
  echo "Введите существующего файла(.txt)"
  flag2=0
fi
function calc_different(){
  local s1=$1
  local s2=$2
  local n=${#s1}
  local m=${#s2}
  local min=0
  local max=0
  if [[ n -gt m ]]
  then
    max=$n
    min=$m
  else
    max=$m
    min=$n
  fi
  local diff=$(($max-$min))
  local i=0
  for(( i=0; i<min; ++i ))
  do
    if [[ ${s1:i:1} != ${s2:i:1} ]]
    then
      diff=$(($diff+1))
    fi
  done
    total_diff=$(($total_diff+$diff))
}

if [[ $flag1 -gt 0 ]] && [[ $flag2 -gt 0 ]] 
then
#кол-во строк в файле
cnt_str1=0
cnt_str2=0
#разница
total_diff=0
#всего символов
total_symbols1=0
total_symbols2=0

#Чтение 1 файла
while read str
do
  text1[cnt_str1]=$str
  cnt_str1=$(($cnt_str1+1))
  total_symbols1=$(($total_symbols1+${#str}))
done < $1
#Чтение 2 файла
while read str
do
  text2[cnt_str2]=$str
  cnt_str2=$(($cnt_str2+1))
  total_symbols2=$(($total_symbols2+${#str}))

done < $2

add_diff=0
if [[ cnt_str2 -gt cnt_str1 ]]
then
  for(( i=0; i<cnt_str1; ++i ))
  do
    calc_different ${text1[i]} ${text2[i]}
  done
  for(( i=cnt_str1; i<cnt_str2; ++i ))
  do
    add_diff=$(($add_diff+${#text2[i]}))
  done
  else
  for(( i=0; i<cnt_str2; ++i ))
  do
    calc_different ${text1[i]} ${text2[i]}
  done
  for(( i=cnt_str2; i<cnt_str1; ++i ))
  do
    add_diff=$(($add_diff+${#text1[i]}))
  done
fi
total_diff=$(($total_diff+$add_diff))

echo "Количество символов в первом файле - $total_symbols1"
echo "Количество символов во втором файле - $total_symbols2"
echo "Расстояние Левенштейна равно - $total_diff"
fi