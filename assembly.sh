#!/bin/bash

# Directory containing your subset reads
subset_dir="HOME/neosegone/microbe_raw_reads/subset"

# Output directory for assemblies
assembly_dir="HOME/neosegone/microbe_raw_reads/assemblies"
mkdir -p "$assembly_dir"

# Get sample IDs (strip _R1.fastq.gz)
SAMPLES=$(ls $subset_dir/*_R1.fastq.gz | sed 's/_R1.fastq.gz//' | xargs -n1 basename)

# Run SPAdes for each sample
for SAMPLE in $SAMPLES; do
    R1="$subset_dir/${SAMPLE}_R1.fastq.gz"
    R2="$subset_dir/${SAMPLE}_R2.fastq.gz"
    outdir="$assembly_dir/$SAMPLE"

    echo "Running SPAdes for $SAMPLE..."
    spades.py -1 "$R1" -2 "$R2" -o "$outdir" --threads 8 --memory 32

    if [[ $? -eq 0 ]]; then
        echo "Assembly finished for $SAMPLE (results in $outdir)"
    else
        echo "Error in assembly for $SAMPLE" >&2
    fi
done

echo "All assemblies complete!"

#Assess the assembly
mkdir quast_report
quast.py */contigs.fasta -o quast_report

#Download the quast_report html file to your PC
#Download the assembly_graph.fastg to your PC and view with bandage
#Download 3 to 4 samples 
scp -r yossra_bioinformatics@135.181.163.242:/home/yossra_bioinformatics/neosegone/microbe_raw_reads/trimmed_reads/HOME/neosegone/microbe_raw_reads/assemblies/SRR27013268_Genome_Sequencing_of_Listeria_monocytogenes_SA_outbreak_2017/assembly_graph.fastg \

#Bandage link 
https://rrwick.github.io/Bandage

#Download the application on your PC and and upload the graphs 
#Click on a piece of the sequence then copy selected node sequences to the clipboard
#Open NCBI on your browser and paste the selected node 
#Note: The blastn results does confirm that it is Listeria Monocytogens strain, the size is about 3M, simialr to the bandage total length
