#!/bin/bash

# Find .fq.gz files in the current directory and assign them to variables
echo "Searching for .fq.gz files..."
fq_gz_files=($(ls *.fq.gz 2>/dev/null))

# Check if exactly two .fq.gz files are found
if [[ ${#fq_gz_files[@]} -ne 2 ]]; then
  echo "Error: Exactly two .fq.gz files are required in the current directory."
  exit 1
fi

# Assign the found files to input variables
input_file1=${fq_gz_files[0]}
input_file2=${fq_gz_files[1]}
echo "Found input files: $input_file1 and $input_file2"

# Create directories for the first round of demultiplexing
echo "Creating directories for the first round of demultiplexing..."
mkdir -p fastq_multx_output-1

# First round of demultiplexing
echo "Starting the first round of demultiplexing..."
/home/crispr/fastq-multx/fastq-multx -B barcode.txt -m 1 -b "$input_file1" "$input_file2" -o fastq_multx_output-1/%.R1.fastq -o fastq_multx_output-1/%.R2.fastq
echo "First round of demultiplexing completed."

# Create directories for the second round of demultiplexing
echo "Creating directories for the second round of demultiplexing..."
mkdir -p fastq_multx_output-2

# Second round of demultiplexing with reversed input files
echo "Starting the second round of demultiplexing..."
/home/crispr/fastq-multx/fastq-multx -B barcode.txt -m 1 -b "$input_file2" "$input_file1" -o fastq_multx_output-2/%.R1.fastq -o fastq_multx_output-2/%.R2.fastq
echo "Second round of demultiplexing completed."

# Create directory for merged results
echo "Creating directory for merged results..."
mkdir -p fastq_multx_output

# Generate sample list
echo "Generating sample list..."
ls fastq_multx_output-1/*.R1.fastq | sed 's/.R1.fastq//' | sed 's/fastq_multx_output-1\///' > sample.list
echo "Sample list generated."

# Generate commands to combine R1 files
echo "Generating commands to combine R1 files..."
for i in $(cat sample.list); do
  echo "cat fastq_multx_output-1/$i.R1.fastq fastq_multx_output-2/$i.R2.fastq > ./fastq_multx_output/$i.R1.fastq"
done > command.combine.R1.list
echo "Commands to combine R1 files generated."

# Generate commands to combine R2 files
echo "Generating commands to combine R2 files..."
for i in $(cat sample.list); do
  echo "cat fastq_multx_output-1/$i.R2.fastq fastq_multx_output-2/$i.R1.fastq > ./fastq_multx_output/$i.R2.fastq"
done > command.combine.R2.list
echo "Commands to combine R2 files generated."

# Execute commands to combine R1 files
echo "Executing commands to combine R1 files..."
sh command.combine.R1.list
echo "R1 files combined."

# Execute commands to combine R2 files
echo "Executing commands to combine R2 files..."
sh command.combine.R2.list
echo "R2 files combined."

echo "Script completed successfully."
