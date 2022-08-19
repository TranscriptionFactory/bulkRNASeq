#!/bin/bash

for fn in AR{1..30};
do
samp="${fn}"
salmon quant -i "location_to_reference_genome" -l A \
         -1 ${samp}_1.fq.gz \
         -2 ${samp}_2.fq.gz \
         --gcBias -o quants/${samp}_quant
done 