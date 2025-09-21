#!/bin/bash

mkdir -p AMR

# Loop over every contigs.fasta and run for two databases: resfinder and vfdb
for f in $(find . -type f -name "contigs.fasta"); do
    sample=$(basename $(dirname "$f"))     # folder name = sample id
    echo "Processing $sample"

    # AMR (ResFinder)  -> output: AMR/<sample>_resfinder.tab
    abricate --db resfinder "$f" > AMR/${sample}_resfinder.tab

    # AMR (NCBI) as alternative
    abricate --db ncbi "$f" > AMR/${sample}_ncbi.tab

    # Virulence / Toxins (VFDB)
    abricate --db vfdb "$f" > AMR/${sample}_vfdb.tab
done

# Summary for resfinder
abricate --summary AMR/*_resfinder.tab > AMR/resfinder_summary.tab

# Summary for ncbi
abricate --summary AMR/*_ncbi.tab > AMR/ncbi_summary.tab

# Summary for vfdb (virulence/toxin)
abricate --summary AMR/*_vfdb.tab > AMR/vfdb_summary.tab

#Open summaries 
less -S AMR/vfdb_summary.tab
