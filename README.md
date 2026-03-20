## 请下载 NGS_batch.zip 及下述额外下载 shell 文件使用

## run_pattern for handle base editors NGS data under mounts of target, single target version from https://github.com/zfcarpe/Cas9Sequencing
 
## 新增模块 ##

* 增加 barcode_split_tips.sh 用于NGS库根据特异性引物进行拆分
* （额外下载）增加 run_all.sh 对多个NGS库进行拆分，仅支持 Illumina 平台测序结果
* （额外下载）增加 sort.sh 将拆分的多个库中按照给定的关键词将靶点区分
* （额外下载）增加 run_pattern.sh 使具有多个靶位点的情况下，通过提供的 pattern.txt 信息批量分析不同靶点
* 增加 countPer.sh 使每个位置碱基频率得以计算
* （可选）增加 clean.sh 去除 summary 以外结果，减少存储占用

## output ##
All the result are saved in the dir ./fl_result

**./fl_result/count/**: edit products and their count number

**./fl_result/extract/**: all the sequences could be extract by recoginze pattern

**./fl_result/indel/**: idel sequences

**./fl_result/summary/**: 在批量处理中，由于 clean.sh 的添加仅保留该结果并被重命名，以减少存储占用，若需要其它结果请在 run_pattern.sh 中禁用 clean.sh

```
*_seqscan.txt: counts of differenty types of nulceotide of each sites in edit region
*_productsum.txt: products and their counts of given edit sites
* SumPer.txt: frequency of each site of target
```




