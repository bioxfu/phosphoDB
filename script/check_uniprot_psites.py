from Bio import SeqIO

prot = SeqIO.to_dict(SeqIO.parse('uniprot/UP000006548_3702.fasta', 'fasta'))
width = 7

annot = {}
with open('uniprot/uniprot_anno') as file:
	for line in file:
		lst = line.strip().split('\t')
		annot[lst[0]] = lst[2]+'\t'+lst[1]

psites = {}
with open('psites/prot2psites.tsv') as file:
	for line in file:
		lst = line.strip().split('\t')
		psites[lst[0]] = [int(x) for x in lst[1].split(',')]


with open('psites/uniprot2phosphoprot.tsv') as file:
	for line in file:
		lst = line.strip().split('\t')
		uniprot = lst[0]
		uniprot_anno = annot[uniprot]
		uniprot_seq = prot[uniprot].seq
		dbppt_id = []
		p3db_id = []
		phosphat_id = []
		uniq_sites = []

		for x in lst[1].split(','):
			db = x.split(':')
			if db[0] == 'dbppt':
				dbppt_id.append(db[1])
			elif db[0] == 'p3db':
				p3db_id.append(db[1])
			elif db[0] == 'phosphat':
				phosphat_id.append(db[1])
			if x in psites:
				uniq_sites.extend(psites[x])

		uniq_sites = sorted(set(uniq_sites))

		for site in uniq_sites:
			if site <= len(uniprot_seq):			
				seq = '*' * width + uniprot_seq + '*' * width
				pos = site + width
				pep_start = pos - 1 - width
				pep_end = pos + width
				aa = seq[pos-1]
				pep = seq[pep_start:pep_end]
				
				if aa == 'S' or aa == 'T' or aa == 'Y':
					print("%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s" % (uniprot, uniprot_anno, site, aa, pep, ','.join(dbppt_id), ','.join(p3db_id), ','.join(phosphat_id)))		

