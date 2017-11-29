library(readxl)

argv <- commandArgs(T)
input <- argv[1]
sheet_num <- as.numeric(argv[2])
output <- argv[3]

xls <- read_excel(input, sheet = sheet_num, col_names = F)
write.table(xls, output, sep='\t', quote=F, row.names = F, col.names = F)
