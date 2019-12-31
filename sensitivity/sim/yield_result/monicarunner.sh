monica run sim_*
rm sim*
rm site*
cat ./total_result/*out* | head -4 | tail -1 >> sugar-beet-2011.csv
cat ./total_result/*out* | head -5 | tail -1 >> spring-barley-2012.csv
cat ./total_result/*out* | head -6 | tail -1 >> winter-wheat-2014.csv
cat ./total_result/*out* | head -7 | tail -1 >> sugar-beet-2014.csv
cat ./total_result/*out* | head -8 | tail -1 >> soybean-000-2015.csv
cat ./total_result/*out* | head -9 | tail -1 >> winter-wheat-2016.csv
cat ./total_result/*out* | head -10 | tail -1 >> sugar-beet-2017.csv
rm ./total_result/*out*
