FROM rocker/verse
MAINTAINER Caitlin Cassidy <cacassid@email.unc.edu>
RUN echo "Hello World"
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('shiny')"
RUN R -e "install.packages('leaflet)"
RUN R -e "install.packages('leaflet.extras')"