#!/bin/bash
for a in $(cat second_batch.txt)
do
 	monica run $a
done
