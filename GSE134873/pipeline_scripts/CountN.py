#!/usr/bin/python3.6


import sys
import io
import fileinput

def read(fastq):
    read = {}
    with open(fastq, 'r') as handle:
        for lineno, line in enumerate(handle):
            if lineno % 2 != 0:
                if (lineno - 1) % 4 == 0:
                    a_dict = {lineno:line[0:len(line)-1]} #len(line) - 1 removes the newline character
                    read.update(a_dict)
    return(read)

def countN(read):
    count = 0
    count = sum([1 for value in read.values() if str(value)[0] == 'N'])
    print(count)

def read2(fastq):
    read = {}
    with fileinput.input(fastq) as f:
        for line_num, line in enumerate(f, start=1):
            if lineno % 2 != 0:
                if (lineno - 1) % 4 == 0:
                    a_dict = {lineno:line[0:len(line)-1]} #len(line) - 1 removes the newline character
                    read.update(a_dict)
    return(read)
        
    
if __name__ == "__main__":
    if len(sys.argv) > 1:
        reads = read(sys.argv[1])
        countN(reads)
    else:
        reads = read2(sys.stdin)
        countN(reads)



