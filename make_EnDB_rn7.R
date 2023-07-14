# if needed, install required libraries.
BiocManager::install(c("AnnotationHub", "ensembldb", "AnnotationForge"))

library(AnnotationHub)
library(ensembldb)
library(AnnotationForge)

# start an AnnotationHub instance/connection.
ah <- AnnotationHub()
# query for availabel Rat Ensembl databases
EnsDb.rat <- query(ah, c("EnsDb", "Rattus norvegicus"))
EnsDb.rat

# Fetch the v105 EnsDb and put it in the cache.
EnsDb.rat <- EnsDb.rat[["AH98149"]]


# Now copy, and install the database locally.
# By doing so, you can just quickly load the library next time.
# see: ?makeEnsembldbPackage
#set working dir to store the relaively large files.
setwd("/Volumes/Seagate/multiome_cp")

#copy databse from the cache to working dir
file.copy(AnnotationHub::cache(ah["AH98149"]), "./EnsDb.rat.sqlite")

# now make it a package. Change name and email accordingly
makeEnsembldbPackage("EnsDb.rat.sqlite", version="0.0.1",
                     maintainer = "Hung-Sheng <hs2722@ic.ac.uk>",
                     author = "Hung-Sheng <hs2722@ic.ac.uk>",
                     destDir=".", license="Artistic-2.0")

# install package in R.
# note modifed name of created directory (not EnsDb.rat... but EnsDb.Rnorvegicus.v105)
install.packages("./EnsDb.Rnorvegicus.v105", type = "source", repos = NULL)
library(EnsDb.Rnorvegicus.v105)
EnsDb.Rnorvegicus.v105






