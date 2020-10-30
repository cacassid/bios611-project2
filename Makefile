.PHONY: parks_shiny
.PHONY: clean

clean:
		rm derived_data/*.csv

derived_data/counts_area_sl.csv: get_data.R\
 project1_data/counts_area_sl.txt
		Rscript get_data.R
	
derived_data/conservation_park_info.csv: get_data.R\
 project1_data/species.csv\
 project1_data/datasets_670_1306_parks.csv\
		Rscript get_data.R

parks_shiny: derived_data/counts_area_sl.csv
		Rscript parks_shiny.R ${PORT}
