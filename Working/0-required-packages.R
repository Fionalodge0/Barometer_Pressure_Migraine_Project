#************************************************#
# Historical Weather Overview: Required Packages #
#                                                #
# Copied from Corn Faeries Project               #
# Original Date: 2020-01-27                      #
#************************************************#

# 1. LISTING PACKAGES ==========================================================

required_pkgs <- c(
  "ggplot2",
  "ggthemes",
  "data.table",
  "magrittr",
  "roperators", 
  "tibble",
  "dplyr", 
  "readr")

# 2. LOADING PACKAGES ==========================================================

# install packages that do not exist
missing_pkgs <- setdiff(
  x = required_pkgs,
  y = rownames(installed.packages())
)

if(length(missing_pkgs) && interactive()){
  install.packages(pkgs = missing_pkgs)
} # END if STATEMENT

 # END if STATEMENT

# load all packages
sapply(
  X   = required_pkgs,
  FUN = require,
  character.only = TRUE
)
