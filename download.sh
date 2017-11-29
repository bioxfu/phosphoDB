## download UniProt protein seqenences of Arabidopsis thaliana
mkdir uniprot
cd uniprot
wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/reference_proteomes/README
wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/reference_proteomes/Eukaryota/UP000006548_3702.fasta.gz
wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/reference_proteomes/Eukaryota/UP000006548_3702_additional.fasta.gz
#wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/reference_proteomes/Eukaryota/UP000006548_3702.gene2acc.gz
#wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/reference_proteomes/Eukaryota/UP000006548_3702.idmapping.gz
#wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/reference_proteomes/Eukaryota/UP000006548_3702_DNA.fasq.gz
#wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/reference_proteomes/Eukaryota/UP000006548_3702_DNA.miss.gz
cd ..

## get public data
mkdir public

## download dbPPT database (http://dbppt.biocuckoo.org/)
mkdir public/dbPPT
cd public/dbPPT
wget 'http://dbppt.biocuckoo.org/getfile.php?id=RIZI1POCZYJsAidvbAyIpqB&code=ZDL8b2ZqvhdZ_tZDGvPEzQOVW2rW0VtP78bZ2ChKXPrL0gF' -O dbPPT_all_download.xlsx    
wget 'http://dbppt.biocuckoo.org/getfile.php?id=ohKsEjMcpv5PurbWd_a2OhS&code=.nTdVrAsH-Apkf-pWWi0mh9pk-M1HuytjHJpnQN' -O dbPPT_all_seq.zip
cd -

## download P3DB database (http://p3db.org/)
mkdir public/p3db
cd public/p3db
# download data
wget 'http://p3db.org/download.php?org=at&ref=0&type=pro&downloadbttn=Download' -O p3db-3.5-phosphoprotein-report_Arabidopsis-thaliana.gz
wget 'http://p3db.org/download.php?org=at&ref=0&type=site&downloadbttn=Download' -O p3db-3.5-phosphosite-report_Arabidopsis-thaliana.gz
#wget 'http://p3db.org/download.php?org=at&ref=0&type=nrpep&downloadbttn=Download' -O p3db-3.5-nr-phosphopeptide-report_Arabidopsis-thaliana.gz
#wget 'http://p3db.org/download.php?org=at&ref=0&type=spec&downloadbttn=Download' -O p3db-3.5-phosphopeptide-report_Arabidopsis-thaliana.gz
cd -

# download PhosPhAt database (http://phosphat.uni-hohenheim.de/)
mkdir public/phosphat
cd public/phosphat
wget http://phosphat.uni-hohenheim.de/phosphat_20160120.csv
wget http://phosphat.uni-hohenheim.de/HiConfPred_psites.txt
cd -

