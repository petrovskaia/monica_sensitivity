cd ~/monica/sensitivity/sim/creating_json_files/resuts
ls out_SOC* > list_of_yield.txt
touch total.csv
for a in $(cat list_of_yield.txt)
do 
	echo $a >>total.csv
	cat $a | tail -27 | head -10>>total.csv
done
