
Transfer Data To remote Server
==============================

Move Local Files to Remote server
---------------------------------

\*\* *scp (Secure Copy)* \*\* Copy the file "foobar.txt" from the local host to a remote host
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

    scp  /some/local/directory/foobar.txt your_username@remotehost_IP:/home/yourusername/remote_dir

Exercise:
~~~~~~~~~
**

1. Copy any .fastq.gz files from you local machine to
   /home/yourusername/RNA-Seq/RAW\_Data

\*\* *Using Cyberduck* \*\*
~~~~~~~~~~~~~~~~~~~~~~~~~~~



Download Data from URL
----------------------

\*\* *wget* \*\*
~~~~~~~~~~~~~~~~

Users execute the wget command without any option by simply using the
URL of the file to be downloaded in the command line.

.. code:: bash

    wget [URL]

Exercise:
~~~~~~~~~

1. Make a direct link to any of your fastq.gz file in Box.net
2. Download that file into /home/yourusername/RNA-Seq/RAW\_Data using
   wget\_ command

More Downloading..
------------------

1. Download `Gmax
   Chr01 <https://osu.box.com/shared/static/nacr8prhsjsuiofzguj34qhrz74p6mca.fasta>`__
   Fasta file from Box.net to
   /home/yourusername/RNA-Seq/Reference/Genome.
2. Download /TruSeq\_adapters.fasta file from Box.net to
   /home/yourusername/RNA-Seq/Adapters.
