cd ~/monica/sensitivity/sim/batch_and_slurm_files/total_result
ls *out* > list_of_yield.txt
touch sugar-beet-2011.csv spring-barley-2012.csv winter-wheat-2014.csv sugar-beet-2014.csv soybean-000-2015.csv winter-wheat-2016.csv sugar-beet-2017.csv
for a in $(cat list_of_yield.txt)
do
        cat $a | head -4 | tail -1 >> sugar-beet-2011.csv
        cat $a | head -5 | tail -1 >> spring-barley-2012.csv
        cat $a | head -6 | tail -1 >> winter-wheat-2014.csv
        cat $a | head -7 | tail -1 >> sugar-beet-2014.csv
        cat $a | head -8 | tail -1 >> soybean-000-2015.csv
        cat $a | head -9 | tail -1 >> winter-wheat-2016.csv
        cat $a | head -10 | tail -1 >> sugar-beet-2017.csv
done
cp sugar-beet-2011.csv spring-barley-2012.csv winter-wheat-2014.csv sugar-beet-2014.csv soybean-000-2015.csv winter-wheat-2016.csv sugar-beet-2017.csv ~/monica/sensitivity/sim/
