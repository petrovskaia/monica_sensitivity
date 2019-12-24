#!/bin/bash
for a in $(cat first_batch.txt)
do
 	monica run $a
done
