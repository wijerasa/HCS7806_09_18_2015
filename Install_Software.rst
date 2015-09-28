
How to Install Software on Linux
================================

1. Install Software From Your Distribution’s Repositories
2. Downloading and Unpacking a Binary Archive
3. Compileing From Source

Software we need
----------------

*Quality Control*
~~~~~~~~~~~~~~~~~

-  `Fastqc <http://www.bioinformatics.babraham.ac.uk/projects/fastqc/>`__
-  `sickle <https://github.com/najoshi/sickle>`__
-  `scythe <https://github.com/najoshi/scythe>`__

*Alignment Software*
~~~~~~~~~~~~~~~~~~~~

-  `Tophat2 <>`__

1. Install Software From Your Distribution’s Repositories
----------------------------------------------------------

*First Search:*


*sudo apt-cache policy [software\_name]*

.. code-block:: bash

   $ sudo apt-cache policy fastqc
    [sudo] password for swijeratne:
    fastqc:
      Installed: (none)
      Candidate: 0.10.1+dfsg-2
      Version table:
         0.10.1+dfsg-2 0
            500 http://us.archive.ubuntu.com/ubuntu/ trusty/universe amd64 Packages


    



*Then Install:*


.. code:: python

    sudo apt-get install fastqc

2. Downloading and Unpacking a Binary Archive
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To download tophat2
`binaries <https://ccb.jhu.edu/software/tophat/index.shtml>`__, from
your home directory type

.. code:: python

    cd Software

Then,

.. code:: python

    wget https://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.0.Linux_x86_64.tar.gz

.. code:: python

    tar -xvf tophat-2.1.0.Linux_x86_64.tar.gz

.. code:: python

    cd tophat-2.1.0.Linux_x86_64/ && ls -ls

To execute tophat2,

.. code:: python

    ./tophat2

3. Compileing From Source
~~~~~~~~~~~~~~~~~~~~~~~~~

Go back to *Software* directory by typing,

.. code:: python

    cd ../

Download sickle and and scythe

.. code:: python

    wget https://github.com/najoshi/sickle/archive/master.zip

Unzip master file

.. code:: python

    unzip master.zip 

Remove master.zip from your directory

.. code:: python

    rm master.zip

Download *scythe* and unzip as above

.. code:: python

    wget https://github.com/najoshi/scythe/archive/master.zip

*Compile sickle and scythe*
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: python

    cd sickel-master

.. code:: python

    make 

.. code:: python

    ls -ls 

Do the same for the scythe
