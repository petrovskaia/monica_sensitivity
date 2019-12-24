#this script helps us to divide all of our sim files in txt files with its names 
cd ~/monica/sensitivity/sim/creating_json_files
find . -name "sim_SOC*json" > ../all_sim.txt
sed -n '1,25000p' all_sim.txt >../1.txt
sed -n '25001,50000p' all_sim.txt >../2.txt
sed -n '50001,75000p' all_sim.txt >../3.txt
sed -n '75001,$p' all_sim.txt >../4.txt
#sed -n '80001,100000p' all_sim.txt >> fivth_batch.txt
