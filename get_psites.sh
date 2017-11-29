source activate gmatic

## get phospho site positions
mkdir psites
/home/xfu/R/3.2.4/bin/Rscript script/excel2tsv.R public/dbPPT/dbPPT_all_download.xlsx 1 public/dbPPT/dbPPT_all_download.tsv
grep 'Arabidopsis' public/dbPPT/dbPPT_all_download.tsv|cut -f1,4|sort -k1,1 -k2,2n|groupBy -g 1 -c 2 -o collapse|awk '{print "dbppt:"$0}' > psites/prot2psites.tsv
zcat public/p3db/p3db-3.5-phosphosite-report_Arabidopsis-thaliana.gz|cut -f1,4|grep -v 'P3DB'|sort -k1,1n -k2,2n|groupBy -g 1 -c 2 -o collapse|awk '{print "p3db:"$0}' >> psites/prot2psites.tsv
cat public/phosphat/HiConfPred_psites.txt|grep -v 'PROTEIN_POSITION'|cut -f1,2|sort -k1,1 -k2,2n|groupBy -g 1 -c 2 -o collapse|awk '{print "phosphat:"$0}' >> psites/prot2psites.tsv

## build blastdb
cd uniprot
zcat UP000006548_3702.fasta.gz > UP000006548_3702.fasta
zcat UP000006548_3702_additional.fasta.gz >> UP000006548_3702.fasta
makeblastdb -dbtype prot -in UP000006548_3702.fasta -out UP000006548_3702
grep '>' UP000006548_3702.fasta|sed 's/>//'|sed 's/_ARATH /_ARATH\t/'|sed 's/ OS=/\t/'|sed 's/ GN=/\t/'|sed 's/ PE=/\t/'|cut -f1,2,4 > uniprot_anno
cd -

# unify various protein IDs into UniProt
unzip -p public/dbPPT/dbPPT_all_seq.zip|grep -A1 'Arabidopsis thaliana'|sed 's/>/>dbppt:/'|sed -r 's/@.+//' > psites/phosphoprot.fasta
zcat public/p3db/p3db-3.5-phosphoprotein-report_Arabidopsis-thaliana.gz|grep -v 'P3DB Protein ID'|cut -f1,4|sort|uniq|awk '{print ">p3db:"$1"\n"$2}' >> psites/phosphoprot.fasta 
cat public/phosphat/phosphat_20160120.csv|tr ',' '\t'|cut -f3,19|sort|uniq|groupBy -g 1 -c 2 -o first|awk '{print ">phosphat:"$1"\n"$2}' >> psites/phosphoprot.fasta 

blastp -query psites/phosphoprot.fasta -db uniprot/UP000006548_3702 -out psites/blast_out -num_threads 30 -evalue 1e-5 -outfmt 6 -max_target_seqs 5
cat psites/blast_out|awk '{if($3==100 && $4 == $8 && $7 == $9 && $8 == $10) print}'|sort -k1,1 -k11,11g -k4,4nr -k2,2 > psites/best_hit
cat psites/best_hit|groupBy -g 1 -c 2 -o first|sort -k2,2 -k1,1|groupBy -g 2 -c 1 -o collapse > psites/uniprot2phosphoprot.tsv

# get final table
python script/check_uniprot_psites.py > psites/public_psites.tsv
