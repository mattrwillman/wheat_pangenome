#!/bin/bash

#SBATCH --job-name="pangenome_wheat"            #name of the job submitted
#SBATCH -p atlas                      #name of the queue you are submitting job to
#SBATCH -A gbru_wheat2
#SBATCH -N 1                            #number of nodes in this job
#SBATCH -n 12                           #number of cores/tasks in this job
#SBATCH -t 7-00:00:00                                   #time allocated for this job hours:mins:seconds
#SBATCH --mail-user=mrwillma@ncsu.edu   #email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -o "stdout.%x.%j.%N"               #standard out %x adds job name and %j adds job number to outputfile name and %N adds the node
#SBATCH -e "stderr.%x.%j.%N"               #optional but it prints our standard error

#apptainer pull docker://quay.io/comparative-genomics-toolkit/cactus:v2.8.4
#git clone https://github.com/USDA-ARS-GBRU/PanPipes.git
#wget https://raw.githubusercontent.com/ComparativeGenomicsToolkit/cactus/master/examples/yeastPangenome.txt

module load apptainer
module load miniconda3

cd /home/matthew.willman/90daydata/Cactus_test

apptainer exec cactus_v2.8.4.sif cactus-pangenome ./js wheatPangenome.txt --reference Hilliard --outDir wheat-pg --outName wheat-pg --vcf --giraffe --viz --draw

#apptainer exec cactus_v2.8.4.sif cactus-hal2maf --chunkSize 1000000 --refGenome Hilliard ./js wheat-pg/chrom-alignments/chr1A_RagTag.hal wheat-pg/chrom-alignments/chr1A_RagTag.maf

#source activate biopython_env

#python3 PanPipes/utilities/maf2xmfa.py -i wheat-pg/chrom-alignments/chr1A_RagTag.maf -o wheat-pg/chrom-alignments/chr1A_RagTag.xmfa

