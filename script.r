library(scPipe)

# file path:
fq_R1 = system.file("simu_R1.fastq.gz", package = "scPipe")
fq_R2 = system.file("simu_R2.fastq.gz", package = "scPipe")

sc_trim_barcode("combined.fastq.gz",
                fq_R1,
                fq_R2,
                read_structure = list(bs1=-1, bl1=0, bs2=6, bl2=8, us=0, ul=6))