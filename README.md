# make_EnDB_rn7
If your current reference genome version is not supported on EnsDb (eg Rattus norvegicus, rn7), the make_EnDB_rn7 repository provides a script that facilitates the process of installing and loading the Rat Ensembl database into your local R environment. This process includes fetching the database from AnnotationHub, storing it in your local directory, transforming it into a package, and subsequently installing and loading this package. Not only does this ensure you have access to the required genome version, but it also considerably enhances the loading speed in your future sessions.
![image](https://github.com/mdsoapbrain/make_EnDB_rn7/assets/43698523/ac8e9ea2-232f-41e8-912c-46533cca67be)

## Installation
The first step is to install necessary packages. If they are not yet installed, you can install them using BiocManager:
```
BiocManager::install(c("AnnotationHub", "ensembldb", "AnnotationForge"))
```
Load the installed packages:
```
library(AnnotationHub)
library(ensembldb)
library(AnnotationForge)
```
Start an AnnotationHub instance and query for available Rat Ensembl databases:
```
ah <- AnnotationHub()
EnsDb.rat <- query(ah, c("EnsDb", "Rattus norvegicus"))
EnsDb.rat
```
Fetch the v105 EnsDb:
```
EnsDb.rat <- EnsDb.rat[["AH98149"]]
```

## Usage
Copy the database from the cache to your local directory:
```
#set working dir to store the relatively large files.
setwd("/your/working/dir")

#copy database from the cache to working dir
file.copy(AnnotationHub::cache(ah["AH98149"]), "./EnsDb.rat.sqlite")
```
Turn the copied database into a package (you need to modify the maintainer and author information according to your situation):
```
makeEnsembldbPackage("EnsDb.rat.sqlite", version="0.0.1",
                     maintainer = "Hung-Sheng <hs2722@ic.ac.uk>",
                     author = "Hung-Sheng <hs2722@ic.ac.uk>",
                     destDir=".", license="Artistic-2.0")

```
Install the created package in your R environment:
```
# note modified name of created directory (not EnsDb.rat... but EnsDb.Rnorvegicus.v105)
install.packages("./EnsDb.Rnorvegicus.v105", type = "source", repos = NULL)

```
Load the installed package:
```
library(EnsDb.Rnorvegicus.v105)
EnsDb.Rnorvegicus.v105
```
## Enjoy your locally stored EnsDb.Rnorvegicus.v105 package!
