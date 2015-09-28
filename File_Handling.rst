
File Handling Through the Terminal
==================================

Displaying Content of a Compressed gunzip File
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

\*\* *zcat [filename.gz]* \*\*
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



De-compressing gunzip File
~~~~~~~~~~~~~~~~~~~~~~~~~~

\*\* *gzip -d [filename.gz]* \*\*
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



Displaying Content of a File
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. cat -display whole content of a file on the screen
2. less -display contents of a file onto the screen a page at a time
3. head -display first ten lines of a file to the screen
4. tail -display last ten lines of a file to the screen

\*\* *cat [filename]* \*\*
^^^^^^^^^^^^^^^^^^^^^^^^^^



\*\* *less [filename]* \*\*
^^^^^^^^^^^^^^^^^^^^^^^^^^^



\*\* *head [filename]* \*\*
^^^^^^^^^^^^^^^^^^^^^^^^^^^



\*\* *tail [filename]* \*\*
^^^^^^^^^^^^^^^^^^^^^^^^^^^



Renaming a File
~~~~~~~~~~~~~~~

\*\* \_ mv [orginalfile.txt] [newnamefile.txt]\_ \*\*
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



Searching the Contents of a File
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

\*\* \_ grep [options] [word\_to\_find] [filename] \_\*\*
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



Concatenating two or more files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

\*\* \_ cat [fist\_file.txt] [second\_file.txt] [thrid\_file.txt] .... [N\_file.txt] > [output\_file.txt]\_\*\*
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



Finally, Compress that File!!
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

\*\* \_ gzip [filetocompress] \_\*\*
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



Excercise
---------

1. Count the number of sequnces in a fastq.gz file > **Hint:** Use zcat
   and pip ("\|") the output to **grep -c** [word\_to\_grep]
