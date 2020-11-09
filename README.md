BIOS 611 Project 2
=================

About the App
----------------
This app uses data provided by the National Park Service.
The datasets used are publicly available on Kaggle. They can be downloaded at: https://www.kaggle.com/nationalparkservice/park-biod

The first tab allows the user to look at histograms that show the distributions of different species by latitude.

The second tab allows the user to look at maps that show the number of species for different conservation statuses at each park. 

Using This Project
-----------------

You will need Docker and you will need to be able to run Docker as your current user.

You'll need to first build the container:

> docker build . -t project2-env

To run RStudio, go to your terminal and run

> docker run -p 8787:8787 -p 8788:8788 -v `` `pwd` ``:/home/rstudio -e PASSWORD=somepass -it project2-env 

(Make sure pwd is enclosed in backticks)

Then, to run the shiny app, go to the terminal in RStudio and run

> PORT=8788 make parks_shiny 

If you want to run the shiny app on another port, replace 8788 above (in all places) with the appropriate port.

Makefile
-----------

The Makefile is an excellent place to look to get a feel for the project.

