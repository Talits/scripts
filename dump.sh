#!/bin/bash

mkdir dump && cd dump


itens=( "dc" "svc" "bc" "routes" "pvc" "pv" "ds" "rolebinding" )

touch env.txt

for i in "${itens[@]}"
do

  object=$(oc get ${i} | cut -d' ' -f1 | grep -vi "NAME")
  echo -e "${object}" >> env.txt
  while read line; do

    mkdir "${line}"
    oc export ${i}/"${line}" -o yaml --as-template=${i} >> ${i}-"${line}".yaml
    mv ${i}-"${line}".yaml "${line}"

  done < env.txt
done



