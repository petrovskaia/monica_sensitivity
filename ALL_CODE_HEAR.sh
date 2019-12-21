#this scripts generate site.json (soil input data) files for MONICA model 
# and divide them into 1000-files batches, then generate slurm instructions (n=100)
cd ~/monica/sensitivity/sim/
#python script for JSON pipeline
./writting_100k.py
mkdir input_files
#moving all sim and site files in one dir
mv site_SOC* ./input_files/
mv sim_SOC* ./input_files/
cd ~/monica/sensitivity/sim/input_files
#make txt file with all sim files names
find . -name "sim_SOC*json" > ~/monica/sensitivity/sim/all_sim.txt
cd ~/monica/sensitivity/sim
#splitting 100k sim names file into 1 k sim names files
split -l 1000 all_sim.txt batch --additional-suffix=.txt
mkdir batch_and_slurm_files
mv batch*txt ./batch_and_slurm_files
cd ./batch_and_slurm_files
#creating file with all batch name files
ls batch*txt > ~/monica/sensitivity/sim/allbatch.txt
#generate slurm instructions, number slurm = number batches
for i in $(cat ~/monica/sensitivity/sim/allbatch.txt)
do
        echo "#!/bin/bash
 for a in \$(cat $i); do monica run ~/monica/sensitivity/sim/input_files/\$a; done" >$i.sl
done
ls batch*sl > allslurm.txt
#Divide 100 slurm files in 4 groups (n=25) for 4 nodes
split -l 25 allslurm.txt sl --additional-suffix=.txt
#mv sl*.txt ~/monica/sensitivity/sim/
#Save time of starting work
date>~/monica/sensitivity/sim/time_of_start.txt
for a in $(cat slaa.txt); do sbatch -N 1 -c 20 -p cpu $a; done
for a in $(cat slab.txt); do sbatch -N 2 -c 20 -p cpu $a; done
for a in $(cat slac.txt); do sbatch -N 3 -c 20 -p cpu $a; done
for a in $(cat slad.txt); do sbatch -N 4 -c 20 -p cpu $a; done
#Save time of finish work
date>~/monica/sensitivity/sim/time_of_finish.txt