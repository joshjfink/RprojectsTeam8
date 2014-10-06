# This Makefile is used to generate the final document
HW2.html: Homework2.Rmd lq/lq_data.Rdata dennys/dennys_data.Rdata
	Rscript -e "library(rmarkdown);render('Homework2.Rmd')"

# La Quinta files
lq/lq_data.Rdata: LQ_hotel_parse.R
	Rscript LQ_hotel_parse.R

lq/hotels/%.html: LQ_hotel_download.R lq/list.Rdata
	Rscript LQ_hotel_download.R

lq/list.Rdata: LQ_list_parse.R lq/list.html
	Rscript LQ_list_parse.R

lq/list.html: LQ_DownloadList.R
	Rscript LQ_DownloadList.R

# Denny's files
dennys/dennys_data.Rdata: Dennys_Parse.R 
	Rscript Dennys_Parse.R

dennys/%.xml: Dennys_DownloadList.R
	Rscript Dennys_DownloadList.R


# Helper
.PHONY: clean
clean:
	rm -rf dennys/
	rm -rf lq/
	rm -f HW2.html