#Structural Derivation of Viral Taxonomic Relationships: SDVTR
#DamianJMagill 2018
#Contact Email: dmagill08@qub.ac.uk

#NOTE

This pipeline serves as a potential guideline for how one may wish to carry out inference of taxonomy from the molecular modelling of conserved proteins. With the steps below and some modifications, the user will be able to use the following pipeline to do just that. Users are free to make whatever modifications they wish, including using different programs than what are included here. 

#PREREQUISITES

I-tasser
NCBI BLAST
Python
TM-Align
Perl
R
gnu-parallel 

#Installation guidelines for Dependencies

Installation of BLAST, Python, Perl, R, gnu-parallel, and TM-Align can be easily achieved via the Ubuntu software centre using "sudo apt-get install <PACKAGE>".

Withg respect to R, for visualisation and formatting capabilities, the libraries "ggplot2", "vegan", and "factoextra" are required. These can be installed with "install.packages("ggplot2")" etc...

For installation of the I-Tasser suite, please proceed to the following page: https://zhanglab.ccmb.med.umich.edu/I-TASSER/download/

Download and unpack the I-Tasser suite as follows: "tar -xvf I-tasser.tar.bz2"

Navigate into the associated folder and run the download_lib.pl script for set up of requisite databases.

#Setup of Databases

A setup.sh script is provided which if run, will download all assemblies of viral genomes from NCBI and will proceed to predict encoded proteins from these. These will then be formatted into a BLAST database. You are free to use whatever database you wish and to skip this step.

#Directory changes for running the pipeline

Before running the pipeline, modifications to file paths will be necessary. In master.sh, the file path "/media/damian/Hybrid/Viral_Structural_Taxonomy/Pipeline_Isolates/Pipeline/Extracted_Sequences/Sequences/models/" should be changed to "yourfilepath/Extracted_Sequences/Sequences/models/"

With respect to the script "I-Tasser.sh", the path to your installation of I-Tasser needs to be provided at "/media/damian/Hybrid/I-TASSER5.1/I-TASSERmod/./runI-TASSER.pl" as well as the path to ITLIB within I-Tasser. Additionally, the data directory "media/damian/Hybrid/Viral_Structural_Taxonomy/Pipeline_Isolates/Pipeline/Extracted_Sequences/Sequences/" needs to be changed to "yourpath/Extracted_Sequences/Sequences/"

In the script blast_extraction.sh, you will need to make sure the path to the BLAST database is correct. If you use the script setup.sh, you should have a database called "viraldb" contained within a folder called Database and no modifications should be necessary. Otherwise, change Database/viraldb to your own database. If using your own database, you will either need to have a multifasta version of this database to permit derivation of hits by the pipeline (i.e. multifasta.fasta in the script file) or you will have to modify the script or extract these yourself using blastdbcmd for example. You can use blastdbcmd with the header sequences extracted by blast_extraction.sh. 

#Running the pipeline

This pipeline takes an input amino acid sequence in fasta format. This is usually a conserved structural protein of a phage such as the major capsid protein or terminase large subunit but you are free to use what you want. Rename this as input.fasta and run masterfile.sh. The pipeline should proceed to BLAST and extract matching sequences, organise and extract these into individualised folders and conduct modelling predictions on these. The best predictions (model1.pdb) for all are extracted and used in all vs all comparisons with TM-Align followed by extraction of the results as average TM-Score and input, heirarchical clustering, and production of figures in R.

R will generate an elbow plot of cluster predictions which should be used to modify the number of clusters in the hkmeans portion of the script according to where the plot is observed to change significantly in angle. If using cluster based methods, one has the option to use other means of cluster estimation such as Bayesian inference. 

In case of any issues with the visualisation script, the output of the all vs all comparisons is given as a data frame consisting of the compared models and their TM-Score in csv format for easy import into other programs. 

#Sequence Filtering Options

Thre exists the possibility to obtain undesirable hits with this pipeline and to waste computational time in modelling these. This can be somewhat circumvented by the fact that the scripts can be run in isolation, permitting the inspection of results extracted from BLAST analysis and providing the option of exclusion if necessary before running the remaining scripts. Additionally, an optional script "seq_filter.py" is provided which can be modified to filter those sequences conforming to a particular size range. This can permit the removal of spurous hits with sizes a great deal below that of the intended target.

#Considerations for molecular modelling 

Undoubtedly the most computationally intensive portion of this pipeline is the molecular modelling component. Standard operation of the pipeline will result in sequential modelling of all queries in gnu parallel mode. If access to a computer cluster is feasible, it can prove to be much faster to model each query at the same time by allocating a jobscript for each sequence to a single processor. With 60 cores, 60 jobs can be run simultaneously with per job speed only being slightly slower than if they were run in parallel. 





