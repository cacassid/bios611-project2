BIOS 611 Project 2
=================


Using This Project
-----------------

You will need Docker and you will need to be able to run Docker as your current user.

To run RSS this say:

> docker run -p $2:$2: -v `pwd`:/home/rstudio -e PASSWORD = $SECRET_PWD -it l17 sudo -H -u rstudio /bin/bash -c "cd ~/; PORT = $2 make $1"

To run the shiny app, go to the terminal in RStudio and run

> PORT=8788 make power_explorer 

If you want to run the shiny app on another port, replace 8788 above (in all places) with the appropriate port.

Makefile
-----------

The Makefile is an excellent place to look to get a feel for the project.

