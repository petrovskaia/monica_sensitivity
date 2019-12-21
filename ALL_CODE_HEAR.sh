#this script helps us to divide all of our sim files in txt files with its names 
cd ~/monica/sensitivity/sim/input_files
find . -name "sim_SOC*json" > ~/monica/sensitivity/sim/all_sim.txt
cd ~/monica/sensitivity/sim
split -l 1000 all_sim.txt batch --additional-suffix=.txt
mkdir batch_and_slurm_files
mv batch*txt ./batch_and_slurm_files
ls ./batch_and_slurm_files > ~/monica/sensitivity/sim/allbatch.txt
cd ./batch_and_slurm_files
for i in $(cat ~/monica/sensitivity/sim/allbatch.txt)
do
        echo "#!/bin/bash
 for a in \$(cat $i); do monica run ~/monica/sensitivity/sim/input_files/\$a; done" >$i.sl
done
ls batch*sl > allslurm.txt
split -l 25 allslurm.txt sl --additional-suffix=.txt
date>~/monica/sensitivity/sim/time_of_start.txt
for a in $(cat slaa.txt); do sbatch -N 1 -c 20 -p cpu $a; done
for a in $(cat slab.txt); do sbatch -N 2 -c 20 -p cpu $a; done
for a in $(cat slac.txt); do sbatch -N 3 -c 20 -p cpu $a; done
for a in $(cat slad.txt); do sbatch -N 4 -c 20 -p cpu $a; done
date>~/monica/sensitivity/sim/time_of_finish.txt
