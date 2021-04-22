#### Preamble ####
# Purpose: Clean the survey data downloaded from freeCodeCamp's GitHub
# Author: Bongju Yoo
# Data: 30 March 2021
# Contact: bonjwow@gmail.com
# License: MIT

#### Workspace setup ####
library(haven)
library(tidyverse)
library(dplyr)

#### Get data ####
raw_data <- readr::read_csv("https://raw.githubusercontent.com/freeCodeCamp/2017-new-coder-survey/ed8a2c5118209fa26cc823fd33fedcf6fe5661ec/clean-data/2017-fCC-New-Coders-Survey-Data.csv")

#### Clean data ####
dfClean <-
  raw_data %>%
  select('Age',
         'CityPopulation',
         'CommuteTime',
         'Gender',
         'Income',
         'MoneyForLearning',
         'MonthsProgramming',
         'SchoolDegree') %>%
  ### Recode
  mutate(CityPopulation = dplyr::recode(CityPopulation,
                                     "less than 100,000" = 0,
                                     "between 100,000 and 1 million" = 1,
                                     "more than 1 million" = 2,
                                     .default = 999)) %>%
  mutate(CommuteTime = dplyr::recode(CommuteTime,
                                     "I work from home" = 0,
                                     "Less than 15 minutes" = 1,
                                     "15 to 29 minutes" = 2,
                                     "30 to 44 minutes" = 3,
                                     "45 to 60 minutes" = 4,
                                     "More than 60 minutes" = 5,
                                     .default = 999)) %>%
  mutate(Gender = dplyr::recode(Gender,
                                "male" = 0,
                                "female" = 1,
                                .default = 999)) %>%
  mutate(SchoolDegree = dplyr::recode(SchoolDegree,
                                "no high school (secondary school)" = 0,
                                "some high school" = 1,
                                "high school diploma or equivalent (GED)" = 2,
                                "trade, technical, or vocational training" = 2,
                                "some college credit, no degree" = 3,
                                "associate's degree" = 4,
                                "bachelor's degree" = 5,
                                "master's degree (non-professional)" = 6,
                                "professional degree (MBA, MD, JD, etc.)" = 6,
                                "Ph.D." = 7,
                                .default = 999)) %>%
  ### Relocate columns
  dplyr::relocate(Gender, .before = Age) %>%
  dplyr::relocate(MoneyForLearning, .after = SchoolDegree) %>%
  
  ### Remove empty rows
  mutate_all(~ifelse(. %in% c(999, "N/A", "null", ""), NA, .)) %>%
  na.omit()

#### Check re-coded values ####
# unique(dfClean$CityPopulation)
# unique(dfClean$CommuteTime)
# unique(dfClean$Gender)
# unique(dfClean$SchoolDegree)

#### Print summary ####
summary(dfClean)

#### Print structure ####
str(dfClean)

#### Save cleaned data ####
write_csv(dfClean, "inputs/data/clean_new-coders.csv")



         