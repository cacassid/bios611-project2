BIOS 611 Project 2
=================


Using This Project
-----------------

You will need Docker and you will need to be able to run Docker as your current user.

You'll need to first build the container:

> docker build . -t project2-env
The Docker container is based on rocker/verse. 

To run rstudio server:

> docker run -v `pwd`:/home/rstudio - p 8787:8787 -e PASSWORD = 
<yourpassword> -t project2-env

Then connect to the machine on port 8787.

Makefile
-----------

The Makefile is an excellent place to look to get a feel for the project.

