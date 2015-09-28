Introduction to Terminal
=========================

Overview of Linux
------------------

.. highlight:: rest

Linux is a free OS and very similiar to the UNIX OS in terms of
concepts, features.

`**Linux Distributions** <https://en.wikipedia.org/wiki/Comparison_of_Linux_distributions>`_

--------------

Linux System Structure
~~~~~~~~~~~~~~~~~~~~~~

Linux system has three main components:

:Kernel: It controls system hardware including memory,
   processors, disks, and I/ O (Input/ Output) devices. It schedules
   processes, enforces security, manages user access, and so on. The
   kernel receives instructions from the shell, engages appropriate
   hardware resources, and acts as instructed.

:Shell: **(This the important part for our class)** The shell is
   a program that accepts and interprets text-mode commands. The user
   provides instructions (commands) to the shell, which are interpreted
   and passed to the kernel for processing.

:Hierarchical directory structure: Linux uses the conventional
   hierarchical directory structure where directories may contain both
   files and sub-directories. Sub-directories may further hold more
   files and sub-directories. A subdirectory, also referred to as a
   child directory, is a directory located under a parent directory. >

   .. image:: images/LSS.png

   - /home/ username/dir1/ subdir1   -root (parent of *home*) 
   - home - sub-directory or child of / (*root*)



--------------

Starting a Shell
----------------

-  `Through
   SSH <https://pods.iplantcollaborative.org/wiki/display/atmman/Logging+In+to+an+Instance>`__
-  Using graphical interface



\*\* [] prompt, waiting for you to start entering commands.\*\*

--------------

Terminal Commands
-----------------

*pwd (Print Working Directory)*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When you first login, you are logged into your home directory
**(/home/username)**.

To find out what is your current working directory, type

.. code-block:: bash

   $ pwd
   /home/kiriya


*mkdir (makding a directory)*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To make a subdirectory called *Software* in your home directory, type

.. code-block:: bash

   $ mkdir Software



\*\* *ls (list)* \*\*
~~~~~~~~~~~~~~~~~~~~~

To see what is inside the home directory, type

*:~$ ls *



\*\* *cd (change directory)* \*\*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To change the current directory to the "Software", type

*:~$ cd Software *



*:~$ cd ../* -by typying this you can go back to where you started.

--------------

Excercise
---------

Use the Terminal commands we already learned to do the following steps.

1. Creat following directory structure in your "Home Directory"

   *RNA-Seq/Reference/Genome*

   *RNA-Seq/Reference/Annotation*

   *RNA-Seq/RAW\_Data*

   *RNA-Seq/Adapters*

   *RNA-Seq/QC/Fastqc\_Out*

   *RNA-Seq/QC/Adapter\_Removed*

   *RNA-Seq/QC/Trimmed*

   *RNA-Seq/Alignment/Tophat2*

**Hint: You might have to use "-p" option to create non-exsisting
intermediate directories**

**Final output:**
