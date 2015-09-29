
Data Analysis in the Terminal
=========================

Quality Control
---------------

*Quaulity Check With Fastqc*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To get help,

.. code-block:: bash

    $ fastqc --help


.. parsed-literal::

    
                FastQC - A high throughput sequence QC analysis tool
    
    SYNOPSIS
    
    	fastqc seqfile1 seqfile2 .. seqfileN
    
        fastqc [-o output dir] [--(no)extract] [-f fastq|bam|sam] 
               [-c contaminant file] seqfile1 .. seqfileN
    
    DESCRIPTION
    
        FastQC reads a set of sequence files and produces from each one a quality
        control report consisting of a number of different modules, each one of 
        which will help to identify a different potential type of problem in your
        data.
        
        If no files to process are specified on the command line then the program
        will start as an interactive graphical application.  If files are provided
        on the command line then the program will run with no user interaction
        required.  In this mode it is suitable for inclusion into a standardised
        analysis pipeline.
        
        The options for the program as as follows:
        
        -h --help       Print this help file and exit
        
        -v --version    Print the version of the program and exit
        
        -o --outdir     Create all output files in the specified output directory.
                        Please note that this directory must exist as the program
                        will not create it.  If this option is not set then the 
                        output file for each sequence file is created in the same
                        directory as the sequence file which was processed.
                        
        --casava        Files come from raw casava output. Files in the same sample
                        group (differing only by the group number) will be analysed
                        as a set rather than individually. Sequences with the filter
                        flag set in the header will be excluded from the analysis.
                        Files must have the same names given to them by casava
                        (including being gzipped and ending with .gz) otherwise they
                        won't be grouped together correctly.
                        
        --nano          Files come from naopore sequences and are in fast5 format. In
                        this mode you can pass in directories to process and the program
                        will take in all fast5 files within those directories and produce
                        a single output file from the sequences found in all files.                    
                        
        --nofilter      If running with --casava then don't remove read flagged by
                        casava as poor quality when performing the QC analysis.
                       
        --extract       If set then the zipped output file will be uncompressed in
                        the same directory after it has been created.  By default
                        this option will be set if fastqc is run in non-interactive
                        mode.
                        
        -j --java       Provides the full path to the java binary you want to use to
                        launch fastqc. If not supplied then java is assumed to be in
                        your path.
                       
        --noextract     Do not uncompress the output file after creating it.  You
                        should set this option if you do not wish to uncompress
                        the output when running in non-interactive mode.
                        
        --nogroup       Disable grouping of bases for reads >50bp. All reports will
                        show data for every base in the read.  WARNING: Using this
                        option will cause fastqc to crash and burn if you use it on
                        really long reads, and your plots may end up a ridiculous size.
                        You have been warned!
                        
        -f --format     Bypasses the normal sequence file format detection and
                        forces the program to use the specified format.  Valid
                        formats are bam,sam,bam_mapped,sam_mapped and fastq
                        
        -t --threads    Specifies the number of files which can be processed
                        simultaneously.  Each thread will be allocated 250MB of
                        memory so you shouldn't run more threads than your
                        available memory will cope with, and not more than
                        6 threads on a 32 bit machine
                      
        -c              Specifies a non-default file which contains the list of
        --contaminants  contaminants to screen overrepresented sequences against.
                        The file must contain sets of named contaminants in the
                        form name[tab]sequence.  Lines prefixed with a hash will
                        be ignored.
    
        -a              Specifies a non-default file which contains the list of
        --adapters      adapter sequences which will be explicity searched against
                        the library. The file must contain sets of named adapters
                        in the form name[tab]sequence.  Lines prefixed with a hash
                        will be ignored.
                        
        -l              Specifies a non-default file which contains a set of criteria
        --limits        which will be used to determine the warn/error limits for the
                        various modules.  This file can also be used to selectively 
                        remove some modules from the output all together.  The format
                        needs to mirror the default limits.txt file found in the
                        Configuration folder.
                        
       -k --kmers       Specifies the length of Kmer to look for in the Kmer content
                        module. Specified Kmer length must be between 2 and 10. Default
                        length is 7 if not specified.
                        
       -q --quiet       Supress all progress messages on stdout and only report errors.
       
       -d --dir         Selects a directory to be used for temporary files written when
                        generating report images. Defaults to system temp directory if
                        not specified.
                        
    BUGS
    
        Any bugs in fastqc should be reported either to simon.andrews@babraham.ac.uk
        or in www.bioinformatics.babraham.ac.uk/bugzilla/
                       
        

.. code-block:: bash

    $ cd RNA-Seq/QC/Fastqc_Out

**Code For Few Samples**


.. code-block:: bash

    $ fastqc -t 4  --outdir  ~/RNA-Seq/QC/Fastqc_Out RNA-Seq/RAW_Data/3290-TM-0001-18_S18_L002_R1_001-2.fastq.gz RNA-Seq/RAW_Data/3290-TM-0001-18_S18_L004_R1_001-2.fastq.gz

**Code For Many Samples**


.. Note:: If your raw data path names end with *.fastq change the *.fastq.gz to *.fastq* in the following code.

.. code-block:: bash

    $ for f in ~/RNA-Seq/RAW_Data/*.fastq.gz; do fastqc --outdir  ~/RNA-Seq/QC/Fastqc_Out -t 4 $f  ; done 

*Explanation*


.. code-block:: bash

    $ for f in ~/RNA-Seq/RAW_Data/*.fastq.gz;


.. Note:: This will pick any file that has file extension .fastq.gz in the */home/yourusername/RNA-Seq/RAW_Data* directory. 

Then,

.. code-block:: bash

    $ do fastqc --outdir  ~/RNA-Seq/QC/Fastqc_Out -t 4 $f 



.. Note:: will execute fastqc on each file in the /home/yourusername/RNA-Seq/RAW\_Data until there is no more .fastq.gz files left in that directory.

.. code-block:: bash

    $ cd ~/ #Go back to home directory

*Adapter Trimming with scythe*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

    $ scythe --help


.. parsed-literal::

    
    Usage: scythe -a adapter_file.fasta sequence_file.fastq
    Trim 3'-end adapter contaminants off sequence files. If no output file
    is specified, scythe will use stdout.
    
    Options:
      -p, --prior		prior (default: 0.300)
      -q, --quality-type	quality type, either illumina, solexa, or sanger (default: sanger)
      -m, --matches-file	matches file (default: no output)
      -o, --output-file	output trimmed sequences file (default: stdout)
      -t, --tag		add a tag to the header indicating Scythe cut a sequence (default: off)
      -n, --min-match	smallest contaminant to consider (default: 5)
      -M, --min-keep	filter sequnces less than or equal to this length (default: 35)
      --quiet		don't output statistics about trimming to stdout (default: off)
      --help		display this help and exit
      --version		output version information and exit
    
      Information on quality schemes:
      phred			PHRED quality scores (e.g. from Roche 454). ASCII with no offset, range: [4, 60].
      sanger		Sanger are PHRED ASCII qualities with an offset of 33, range: [0, 93]. From 
    			NCBI SRA, or Illumina pipeline 1.8+.
      solexa		Solexa (also very early Illumina - pipeline < 1.3). ASCII offset of
    	 		64, range: [-5, 62]. Uses a different quality-to-probabilities conversion than other
    			schemes.
      illumina		Illumina output from pipeline versions between 1.3 and 1.7. ASCII offset of 64,
    			range: [0, 62]


*Unzip your data before this step,*

**gzip -d Code For few Samples**


.. code-block:: bash

    $ gzip -d RNA-Seq/RAW_Data/3290-TM-0001-18_S18_L002_R1_001-2.fastq.gz
    $ gzip -d RNA-Seq/RAW_Data/3290-TM-0001-18_S18_L004_R1_001-2.fastq.gz

.. Note:: Your outputs will be under RNA-Seq/RAW\_Data/

**gzip -d Code For Many Samples**


.. Note:: You have to be in your *HOME* directory to issue following commands. If are not in your *HOME* do,

.. code-block:: bash

    $ cd ~/ 

to go back to your *HOME*.

.. code-block:: bash

    $ for f in RNA-Seq/RAW_Data/*.gz; do gzip -d  $f  ; done

**Scythe Code For Few Samples**


.. code-block:: bash

    $ scythe  -a RNA-Seq/Adaptors/TruSeq_adapters.fasta  -M 50 -o RNA-Seq/QC/Adapter_Removed/Adapt_rem_3290-TM-0001-18_S18_L002_R1_001-2.fastq RNA-Seq/RAW_Data/3290-TM-0001-18_S18_L002_R1_001-2.fastq

    $ scythe  -a RNA-Seq/Adaptors/TruSeq_adapters.fasta  -M 50 -o RNA-Seq/QC/Adapter_Removed/Adapt_rem_3290-TM-0001-18_S18_L004_R1_001-2.fastq  RNA-Seq/RAW_Data//3290-TM-0001-18_S18_L004_R1_001-2.fastq

**Scythe Code For Many Samples**


.. code-block:: bash

    $ for f in RNA-Seq/RAW_Data/*.fastq; do scythe -a RNA-Seq/Adaptors/TruSeq_adapters.fasta -o RNA-Seq/QC/Adapter_Removed/Adapt_rem_${f##*/}   $f  ; done

*Quality Trimming with sickle*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

    sickle se --help


.. parsed-literal::

    
    Usage: sickle se [options] -f <fastq sequence file> -t <quality type> -o <trimmed fastq file>
    
    Options:
    -f, --fastq-file, Input fastq file (required)
    -t, --qual-type, Type of quality values (solexa (CASAVA < 1.3), illumina (CASAVA 1.3 to 1.7), sanger (which is CASAVA >= 1.8)) (required)
    -o, --output-file, Output trimmed fastq file (required)
    -q, --qual-threshold, Threshold for trimming based on average quality in a window. Default 20.
    -l, --length-threshold, Threshold to keep a read based on length after trimming. Default 20.
    -x, --no-fiveprime, Don't do five prime trimming.
    -n, --trunc-n, Truncate sequences at position of first N.
    -g, --gzip-output, Output gzipped files.
    --quiet, Don't print out any trimming information
    --help, display this help and exit
    --version, output version information and exit
    


.. code-block:: bash

    $ sickle se -q 20  -t sanger -f RNA-Seq/QC/Adapter_Removed/Adapt_rem_3290-TM-0001-18_S18_L002_R1_001-2.fastq  -o RNA-Seq/QC/Trimmed/Q_trimmed_3290-TM-0001-18_S18_L002_R1_001-2.fastq



**Sickle Code For Many Samples**

.. code-block:: bash

    $ for f in RNA-Seq/QC/Adapter_Removed/*.fastq; sickle se -q 20  -t sanger  -f $f -o RNA-Seq/QC/Trimmed/Q_trimmed_${f##*/} ; done



Short-reads Alignment with Tophat2
-----------------------------------

Indexing your Genome
~~~~~~~~~~~~~~~~~~

To make bowtie2 indexes for your Genome,

.. code-block:: bash

    $ cd RNA-Seq/Reference/Genome/

.. code-block:: bash

    $ gzip -d Gmax_275_v2.0.gz

.. code-block:: bash

    $ mv Gmax_275_v2.0 Gmax_275_v2.0.fa

.. code-block:: bash

    $ bowtie2-build Gmax_275_v2.0.fa Gmax_275_v2.0


.. WARNING:: THIS WILL TAKE LONG TIME


Aligning Short Reads
~~~~~~~~~~~~~~~~~~~~~~~


To align short reads to Genome using Tophat2,

.. code-block:: bash

    $ cd ~/RNA-Seq

.. code-block:: bash

    $tophat2 --num-threads 4  --output-dir RNA-Seq/Alignment/Tophat2 RNA-Seq/Reference/Genome/Gmax_275_v2.0 RNA-Seq/QC/Trimmed/Q_trimmed_3290-TM-0001-18_S18_L002_R1_001-2.fastq

**Tophat2 Code For Many Samples**


.. code-block:: bash

    $for f in RNA-Seq/QC/Trimmed/*.fastq; do tmp_file="${f##*/}", tophat2 --num-threads 4  --output-dir RNA-Seq/Alignment/${tmp_file%.fastq*} RNA-Seq/Reference/Genome/Gmax_275_v2.0  $f; done

Excercise
----------

1. Run Cufflinks2 on alignment file(SAM)
