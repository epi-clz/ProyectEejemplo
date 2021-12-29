#
# Project Name : STRAP Stata to R , adaptation of common tasks
# Script Name  : validate.R
# Summary      : Validation datasets
# Date created : 2021-12-28
# Author       : L.CRISTINA
# Date reviewed:
# Reviewed by  :

# -----------------------------------------------------------------------
# Description : 
# 
# 
# 
# 


# -----------------------------------------------------------------------
# Log version : 


# -----------------------------------------------------------------------

source("config.R")
sourcefile(PATH_SCRIPTS,"import.R")

# -----------------------------------------------------------------------
# 1. Import csv file
data <- read.csv(file = filename,sep = ";")
# In this case we have the data locally (Scotland)
#data <- read.csv(file = "~/Desktop/STRAP-Common-Tasks/sources/imove_hosp_scotland_2021-10-12.csv",sep = ",")

names(data)
dim(data)

# -----------------------------------------------------------------------
# 2. Validation

# -----------------------------------------------------------------------
# 2.1. Variable type

head(data)

# -----------------------------------------------------------------------
# 3. Missingnes

  # -----------------------------------------------------------------------
  # 3.1. Convert blank spaces to NA
  
  mutate(data, grepl(pattern = "",x = anaemia))
  mutate_all(data, list(~na_if(.,"")))

  data %>% mutate(x = replace(x, "<NA>", NA))
  
  # 2.2.2. Delete ALL-NA's variables
  data2 <- data[colSums(!is.na(data)) > 0]
  head(data2)
  
# -----------------------------------------------------------------------
# 4. Dates

# Universal format "YY-mm-dd"
  
  typeof(data$onsetdate)
  str(data$onsetdate)
  data2$onsetdate <- as.Date(data$onsetdate,format = "%d/%m/%Y")
  data2$onsetdate <- as.POSIXct(data$onsetdate,format ="%a %b %d %H:%M:%S %Y" )
  typeof(data2$onsetdate)
  
# -----------------------------------------------------------------------
# 5. New variable

  # -----------------------------------------------------------------------
  # 5.1. New variable from Old variable
  
  data2 %>% mutate(death = if_else(condition = !is.na(deathdate),true = 1,false = 0)) %>% 
    head()
  
  data2 %>% mutate(age_cat = case_when(age_y<18 & !is.na(age_y) ~ 0,
                                      age_y>=18 & age_y<64 & !is.na(age_y) ~ 1,
                                      age_y>=64 & !is.na(age_y) ~ 2)) %>%  
    head()
  
  # -----------------------------------------------------------------------
  # 5.2. New variable 

  data2 %>% mutate(newvar =  2*3)
  
  # -----------------------------------------------------------------------
  # 5.3. New set of variables 
  
  data2 %>% mutate(newvar1 = 2*3, 
                   newvar2 = 2*5)


# -----------------------------------------------------------------------
# 6. Drop variables
  
  col_remove <- "age_m"
  data %>% select(-one_of(col_remove))
  



