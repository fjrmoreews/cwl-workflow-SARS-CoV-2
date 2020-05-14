if ! type bwa > /dev/null; then
  echo "Please install bwa (available in bioconda)"
  exit 125
fi

if ! type samtools > /dev/null; then
  echo "Please install samtools (available in bioconda)"
  exit 125
fi

mkdir ./static;

wget -c -O ./static/hg38.fna.gz ftp://ftp.ncbi.nlm.nih.gov/refseq/H_sapiens/annotation/GRCh38_latest/refseq_identifiers/GRCh38_latest_genomic.fna.gz;
cd ./static && gunzip hg38.fna.gz && bwa index hg38.fna && samtools faidx hg38.fna
