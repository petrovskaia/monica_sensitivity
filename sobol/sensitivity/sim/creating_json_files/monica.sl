#!/bin/bash
for a in $(cat allsim.txt)
do
	monica run $a
done
