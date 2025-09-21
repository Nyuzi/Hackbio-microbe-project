#!/bin/bash

#Detect Antimicrobial genes 
#first install required package abricate
conda create -y -p $HOME/my_env -c bioconda -c conda-forge abricate
conda activate $HOME/my_env

#create a folder "AMR" and run a command to output AMR results
mkdir -p AMR
abricate /neosegone/microbe_raw_reads/trimmed_reads/HOME/neosegone/microbe_raw_reads/assemblies/contigs.fasta -o AMR
abricate /home/yossra_bioinformatics/neosegone/microbe_raw_reads/trimmed_reads/HOME/neosegone/microbe_raw_reads/assemblies/SRR27013269_Genome_Sequencing_of_Listeria_monocytogenes_SA_outbreak_2017/contigs.fasta > AMR/SRR27013268_amr.tab


#Run a script on all contigs to identify AMR genes
for f in */contigs.fasta; do
    sample=$(basename $(dirname $f))
    echo "Running abricate on $sample"
    abricate "$f" > AMR/${sample}_amr.tab
done

