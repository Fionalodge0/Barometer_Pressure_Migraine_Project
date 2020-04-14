# This performs basic cleaning - removal of columns

# Test Data
# MN_MPLS_1975_1984 <- 
#   read_csv("MN_Minneapolis_Airport/MN_MPLS_1975_1984.csv")

# Attribute_Adders_Removers ---------------------------------------------------

attribute_selector <- 
  function(dat, ...){
    dat %<>% mutate(ext_hour = as.numeric(format(dat$DATE, format = '%H')), 
                    ext_month = format(dat$DATE, format = '%m'),
                    ext_day = format(dat$DATE, format = '%d'),
                    ext_min = as.numeric(format(dat$DATE, format = '%M')),
                    ext_year = format(dat$DATE, format = '%Y'), 
                    ext_ymd = format(dat$DATE, format = '%Y/%m/%d'),
                    ext_ymdh = format(dat$DATE, format = '%Y/%m/%d %H')) 
    
    # dat %<>% rowid_to_column(., 'row_id')
    
    
    dat %<>% select(STATION, DATE, matches('ext'), matches('Hourly'))
    
    }



# Problem_Row_Finder ------------------------------------------------------

# Save only one hour per day

#date_filtering function

save_the_dates <- 
  function(dat, ...){
    dat %<>% 
      group_by(ext_ymdh) %>%
      mutate(N = n()) %>%
      arrange(ext_min) %>%
      slice(1:1) %>%
      ungroup %>%
      mutate(ext_min = '00') # Need this for later but can keep the original date
  }

# Return any duplicated dated indices - accidentally repeated hours
# They all seem to be on the last day of the year, not sure what's going on there
hours_in_a_day <- 
  function(dat, ...){
    flagged_days <- 
      dat %>%
      count(ext_ymd) %>%
      filter(n != 24) 
    
    return(list('non24' = flagged_days))
  }


# Final Selector ----------------------------------------------------------

# I'm sure this will change but we'll see

final_columns <- function(dat, ...){
  dat %<>% select(STATION, ext_ymdh, matches('Pressure'))
}




  