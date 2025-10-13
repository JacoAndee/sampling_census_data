## Fetch API key and search for variables

library(tidycensus)

tidycensus::census_api_key(key = "1d9fe19026f3759c68bc48e2c7ddf1b2b17ec47b",
                           install = T, overwrite = T)
v22 <- load_variables(year = 2022,
                      dataset = "acs5/profile",
                      cache = T)
View(v22)
vars = c("B17001_001", "B17001_002")
ca_acs <- get_acs(geography = "tract",
                  state = "CA",
                  variables = vars,
                  year = 2022,
                  geometry = T,
                  output = "wide",
                  survey = "acs5"
)
View(ca_acs)
str(ca_acs)