#!/bin/bash

#create a folder named qc
mkdir qc

#run qc using fastp
fastqc microbe_raw_reads/ *fastq.gz -o qc/

#Apply multiqc to summarise the results
multiqc qc/ -o qc/

#Download the multiqc report on the cloud shell
scp -r yossra_bioinformatics@135.181.163.242:/home/yossra_bioinformatics/neosegone/microbe_raw_reads/qc/multiqc_report.html ./ 

