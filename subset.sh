#!/bin/bash

#Select a subset of 50 samples to work with for the assembly and analysis 
mkdir subset

# Directory with your trimmed reads
trimmed_dir="HOME/neosegone/microbe_raw_reads/trimmed_reads"

# Output directory for subset
subset_dir="HOME/neosegone/microbe_raw_reads/subset"
mkdir -p "$subset_dir"

# Get unique sample IDs by stripping everything after "_R1"
SAMPLES=$(ls $trimmed_dir/*_R1.fastq.gz | sed 's/_R1.fastq.gz//' | xargs -n1 basename)

# Randomly pick 50 samples
SELECTED=$(echo "$SAMPLES" | shuf | head -n 50)

# Copy both R1 and R2 for each selected sample
for SAMPLE in $SELECTED; do
    cp "$trimmed_dir/${SAMPLE}_R1.fastq.gz" "$subset_dir/"
    cp "$trimmed_dir/${SAMPLE}_R2.fastq.gz" "$subset_dir/"
done
