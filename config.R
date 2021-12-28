#
# Project Name : STRAP Common Tasks
# Script Name  : config.R
# Summary      : Global and functions definition
# Date created : 2021-12-23
# Author       : G.DESVE
# Date reviewed:
# Reviewed by  :

# -----------------------------------------------------------------------
# Description : 
# Define global variables for running STRAP Project 
# Define common function
# Check correct environment
# 


# -----------------------------------------------------------------------
# Change Log : 


# -----------------------------------------------------------------------


STRAP_CONFIG <- TRUE




# Utility functions -------------------------------------------------------


# library loading function which ask for confirmation before installing library
LoadLib <- function(libname) {
  if (!require(libname, character.only = TRUE)) {
    cat("Required lib ",libname," is required but not installed")
    rep <- readline("Would you like to install it ? Y/N :")
    if (toupper(rep)=="Y")  {
      install.packages(libname, dependencies = TRUE)
      library(libname, character.only = TRUE)
    }  
    else {
      stop("Some Library have to be installed, check requirements")
    }
  }
}

# sourcefile function is a wrapper for source which will later allow some test and feebacks 
sourcefile <- function(path, filename )  {
  source(file.path(path,filename))
}


# START of config -------------------------------------------------------------------------


# Loading the Library -----------------------------------------------------

# May be usefull to explain here  why we need them....

lapply(  c(  "dplyr"      
           , "readr"     
           , "tidyr"     
           , "ggplot2" 
           , "knitr"
           , "rmarkdown" 
), LoadLib) 


# PATH TO FILES -----------------------------------------------------------
# use file.path(PATH_SOURCES, source_name ) to obtain full name of sources file
# 
# Local drive
PATH_ROOT <- "~/Dev/R Sources/STRAP Common Tasks"
PATH_SCRIPTS <- file.path(PATH_ROOT, "Scripts")

# Network Drive
PATH_DRIVE <- "/Volumes/GoogleDrive/Drive partagés/1_EPI_WHO-EURO hospital analysis/R version/STRAP-common tasks"
PATH_SOURCES <- file.path(PATH_DRIVE,"Sources")
PATH_DATA <- file.path(PATH_DRIVE,"Data")

if (! file.exists(file.path(PATH_ROOT,"config.R"))) {
   stop("Verify paths in your config.R files")
}


# END script



