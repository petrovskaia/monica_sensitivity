echo "#!/bin/bash
for a in \$(cat slaa.txt); do sbatch  -N 1 -c 1 -p cpu \$a; done
for a in \$(cat slab.txt); do sbatch  -N 2 -c 1 -p cpu \$a; done
for a in \$(cat slac.txt); do sbatch  -N 3 -c 1 -p cpu \$a; done
for a in \$(cat slad.txt); do sbatch  -N 4 -c 1 -p cpu \$a; done" > 4slurms.sl

