#!/bin/bash

itens=("dc" "svc" "bc" "routes" "ds" "rolebinding" "secrets" "imagestream" "users" "identity")
touch dump/restore.txt
rm dump/*.yaml
object=$(ls dump) && echo -e "${object}" >> dump/restore.txt

for i in "${itens[@]}"
do
  while read line; do  
    oc new-project "${line}"
    oc create -f dump/"${line}"
    oc new-app ${i}-"${line}" -n "${line}"
  done < dump/restore.txt
done


