
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

-  `Tophat2 <https://ccb.jhu.edu/software/tophat/index.shtml>`_

Ways ti Install Software
-------------------------

1. Install Software From Your Distribution’s Repositories
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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


.. warning:: Not all the Linux distributions have fastqc in their repos. If you see *Unable to locate package* warning you have to use following method to install your software. 



*Then Install:*


.. code-block:: bash

    $ sudo apt-get install fastqc

2. Downloading and Unpacking a Binary Archive
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To download tophat2
`binaries <https://ccb.jhu.edu/software/tophat/index.shtml>`__, from
your home directory type

.. code-block:: bash

    $ cd Software

Then,

.. code-block:: bash

    $ wget https://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.0.Linux_x86_64.tar.gz

.. code-block:: bash

    $ tar -xvf tophat-2.1.0.Linux_x86_64.tar.gz

.. code-block:: bash

    $ cd tophat-2.1.0.Linux_x86_64/ && ls -ls

To execute tophat2,

.. code-block:: bash

    $ ./tophat2

3. Compileing From Source
~~~~~~~~~~~~~~~~~~~~~~~~~

Go back to *Software* directory by typing,

.. code-block:: bash

    $ cd ../

Download sickle and and scythe

.. code-block:: bash

    $ wget https://github.com/najoshi/sickle/archive/master.zip

or to download github repo,

.. code-block:: bash

    $ git clone https://github.com/najoshi/sickle.git

Unzip master file if you use *wget* method 

.. code-block:: bash

    $ unzip master.zip


Remove master.zip from your directory

.. code-block:: bash

    $ rm master.zip

.. Note:: If you clone the github repo you can skip above steps

Clone *scythe* using "git clone" command 

.. code:: bash

    $ git clone https://github.com/najoshi/scythe.git


*Compile sickle and scythe*


.. code-block:: bash

    $ cd sickel-master

.. code-block:: bash

    $ make 

.. code-block:: bash

    $ ls -ls 

Do the same for the scythe,

.. code-block:: bash

    $ cd scythe

.. code-block:: bash

    $ make all 

.. code-block:: bash

    $ ls -ls 

Now, add both binaries to *PATH* so you can access them anywhere,

.. code-block:: bash

    $ sudo ln -s /home/yourusername/RNA-Seq/Software/sickel-master/sickle /usr/local/bin
    $ sudo ln -s /home/yourusername/RNA-Seq/Software/scythe//scythe /usr/local/bin
