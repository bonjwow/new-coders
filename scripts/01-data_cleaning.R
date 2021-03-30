#### Preamble ####
# Purpose: Clean the survey data downloaded from freeCodeCamp's GitHub
# Author: Bongju Yoo
# Data: 30 March 2021
# Contact: bonjwow@gmail.com
# License: MIT

#### Workspace setup ####
library(haven)
library(tidyverse)
# Read in the raw data. 
raw_data <- readr::read_csv("https://raw.githubusercontent.com/freeCodeCamp/2017-new-coder-survey/ed8a2c5118209fa26cc823fd33fedcf6fe5661ec/clean-data/2017-fCC-New-Coders-Survey-Data.csv")

         



         