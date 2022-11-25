# Chop up original wav files into sections for further processing

library(warbleR)
library(Rraven)

# Import selection tables
# Rraven needs columns indicating Begin File and Begin Path which are not
# provided in Raven Lite. Import file, and add information, then re-export.
# Use read_delim as want to retain original column names unchanged with spaces.
sel_files <- list.files("selection_tables/")
prefix <- substr(sel_files[1], 1, 3)
sel_tbl <- readr::read_delim(paste0("selection_tables/", prefix,
                                    ".Table.1.selections.txt"))
begin_file <- rep(paste0(prefix, ".wav"), nrow(sel_tbl))
begin_path <- rep(paste0("wav/", prefix, ".wav"), nrow(sel_tbl))
sel_tbl <- dplyr::bind_cols(sel_tbl, begin_file, begin_path)
colnames(sel_tbl)[12] <- "Begin File"
colnames(sel_tbl)[13] <- "Begin Path"

write.table(sel_tbl, "selection_tables_edit/sel_tbl_check.txt", sep='\t',
            row.names = FALSE, quote = FALSE)

rvn.dat <- imp_raven(all.data = TRUE, path = "selection_tables_edit")

head(rvn.dat)
