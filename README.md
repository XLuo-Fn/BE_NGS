* run_pattern for handle base editors NGS data under mounts of target, single target version from https://github.com/zfcarpe/Cas9Sequencing
 
#new mods

* frequency of each site of target calculated by countPer.sh
* run_pattern.sh is program file to handle base editors NGS data under mounts of target, pattern.txt is a required file.

## output ##
All the result are saved in the dir ./fl_result

**./fl_result/count/**: edit products and their count number

**./fl_result/extract/**: all the sequences could be extract by recoginze pattern

**./fl_result/indel/**: idel sequences

**./fl_result/summary/**:

```
*_seqscan.txt: counts of differenty types of nulceotide of each sites in edit region
*_productsum.txt: products and their counts of given edit sites
* SumPer.txt: frequency of each site of target
```




