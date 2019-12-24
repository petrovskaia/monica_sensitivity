for i in $(cat allbatch.txt)
do
	echo "#!/bin/bash
 for a in \$(cat $i); do monica run ./creating_json_files/\$a; done" >$i.sl
done
