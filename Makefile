.PHONY: parks_shiny
.PHONY: clean

clean:
		rm derived_data/*.csv

derived_data/counts_area_sl.csv: get_data.R\
 project1_data/counts_area_sl.txt
		Rscript get_data.R
		
parks_shiny: derived_data/counts_area_sl.csv
		Rscript parks_shiny.R ${PORT}
