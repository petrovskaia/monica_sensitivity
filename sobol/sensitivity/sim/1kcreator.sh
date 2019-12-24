#this script helps us to divide all of our sim files in txt files with its names 
cd ~/monica/sensitivity/sim/
date>./time_of_start.txt
#here file to generate sim and site files
#./writting_100k.py
./writting_sobol_samples.py 
rm -r ~/monica/sensitivity/sim/input_files
mkdir input_files
mv *site_* ./input_files/
mv *sim_* ./input_files/
cd ~/monica/sensitivity/sim/input_files
find . -name "sim_*json" > ~/monica/sensitivity/sim/all_sim.txt
cd ~/monica/sensitivity/sim
split -l 100 all_sim.txt batch --additional-suffix=.txt
rm -r ~/monica/sensitivity/sim/batch_and_slurm_files
mkdir batch_and_slurm_files
mv batch*txt ./batch_and_slurm_files
cd ./batch_and_slurm_files
ls batch*txt > ~/monica/sensitivity/sim/allbatch.txt
for i in $(cat ~/monica/sensitivity/sim/allbatch.txt)
do
        echo "#!/bin/bash
 for a in \$(cat $i); do monica run ~/monica/sensitivity/sim/input_files/\$a; done" >$i.sl
done
ls batch*sl > allslurm.txt
split -l 25 allslurm.txt sl --additional-suffix=.txt
#mv sl*.txt ~/monica/sensitivity/sim/
for a in $(cat slaa.txt); do sbatch  -N 1 -c 1 -p cpu $a; done
for a in $(cat slab.txt); do sbatch  -N 2 -c 1 -p cpu $a; done
for a in $(cat slac.txt); do sbatch  -N 3 -c 1 -p cpu $a; done
for a in $(cat slad.txt); do sbatch  -N 4 -c 1 -p cpu $a; done
date>~/monica/sensitivity/sim/time_of_finish.txt
##ADD HERE "WAIT" CMD TO WAIT ALL SLURM JOBS FINISH
#cd /trinity/home/m.gasanov/monica/sensitivity/sim/batch_and_slurm_files/total_result
#ls *out* > list_of_yield.txt
#touch sugar-beet-2011.csv spring-barley-2012.csv winter-wheat-2014.csv sugar-beet-2014.csv soybean-000-2015.csv winter-wheat-2016.csv sugar-beet-2017.csv
#for a in $(cat list_of_yield.txt)
#do
#     cat $a | head -4 | tail -1 >> sugar-beet-2011.csv
#     cat $a | head -5 | tail -1 >> spring-barley-2012.csv
#     cat $a | head -6 | tail -1 >> winter-wheat-2014.csv
#     cat $a | head -7 | tail -1 >> sugar-beet-2014.csv
#     cat $a | head -8 | tail -1 >> soybean-000-2015.csv
#     cat $a | head -9 | tail -1 >> winter-wheat-2016.csv
#     cat $a | head -10 | tail -1 >> sugar-beet-2017.csv
#done
