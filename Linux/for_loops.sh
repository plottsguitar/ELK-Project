#!/bin/bash

states=('Ohio' 'Colorado' 'Texas' 'Wisconsin' 'Tennessee' 'Minnesota')
num=$(seq 0 9)
ls_output=$(ls)

for state in ${states[@]}
do
  if [ $state == 'Ohio' ];
  then
    echo "This state is ok"
  else
    echo "Not a fan..."
  fi
done

for num in ${num[@]}
do
  if [ $num = 1 ] || [ $num = 4 ] || [ $num = 7 ]
  then
    echo $num
  fi
done

for x in ${ls_output[@]}
do
  echo $x
done

