#!/bin/bash

#create a folder with the name trimmed_reads
mkdir trimmed_reads

for SAMPLE in $(ls *_1.fastq.gz | sed 's/_1.fastq.gz//' | xargs -n1 basename); do
  fastp \
    -i ${SAMPLE}_1.fastq.gz \
    -I ${SAMPLE}_2.fastq.gz \
    -o trimmed_reads/${SAMPLE}_R1.fastq.gz \
    -O trimmed_reads/${SAMPLE}_R2.fastq.gz \
    -h trimmed_reads/${SAMPLE}.html \
    -j trimmed_reads/${SAMPLE}.json
done
