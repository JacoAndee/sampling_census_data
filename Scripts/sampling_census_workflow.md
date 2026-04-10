# Sampling Poverty from California Census Tracts

**Author: Jacob Anderson**

### Load the required packages

    library(tidycensus)
    library(sf)

    ## Warning: package 'sf' was built under R version 4.4.3

    ## Linking to GEOS 3.13.0, GDAL 3.10.1, PROJ 9.5.1; sf_use_s2() is TRUE

    library(dplyr)

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

    library(ggplot2)

    ## Warning: package 'ggplot2' was built under R version 4.4.3

### Connect to the API and select key variables

    ### Save the census api key in script

    tidycensus::census_api_key(
      key = Sys.getenv("CENSUS_API_KEY"),
      install = T, 
      overwrite = T)

    ## Your original .Renviron will be backed up and stored in your R HOME directory if needed.

    ## Your API key has been stored in your .Renviron and can be accessed by Sys.getenv("CENSUS_API_KEY"). 
    ## To use now, restart R or run `readRenviron("~/.Renviron")`

    ## [1] ""

    ### Setting the variables to extract from ACS

    vars = c(total_pop = "B01001_001E",
             tot_pov = "B17020_002E")
    ca_acs <- get_acs(geography = "tract",
                      state = "CA",
                      variables = vars,
                      year = 2022,
                      geometry = T,
                      output = "wide",
                      survey = "acs5"
    ) %>%
      st_transform(3310) %>%
      mutate(pct_pov = tot_pov / total_pop)

    ## Getting data from the 2018-2022 5-year ACS

    ## Warning: • You have not set a Census API key. Users without a key are limited to 500
    ## queries per day and may experience performance limitations.
    ## ℹ For best results, get a Census API key at
    ## http://api.census.gov/data/key_signup.html and then supply the key to the
    ## `census_api_key()` function to use it throughout your tidycensus session.
    ## This warning is displayed once per session.

    ## Downloading feature geometry from the Census website.  To cache shapefiles for use in future sessions, set `options(tigris_use_cache = TRUE)`.

    ##   |                                                                              |                                                                      |   0%  |                                                                              |                                                                      |   1%  |                                                                              |=                                                                     |   1%  |                                                                              |=                                                                     |   2%  |                                                                              |==                                                                    |   2%  |                                                                              |==                                                                    |   3%  |                                                                              |==                                                                    |   4%  |                                                                              |===                                                                   |   4%  |                                                                              |===                                                                   |   5%  |                                                                              |====                                                                  |   5%  |                                                                              |====                                                                  |   6%  |                                                                              |=====                                                                 |   7%  |                                                                              |======                                                                |   8%  |                                                                              |======                                                                |   9%  |                                                                              |=======                                                               |   9%  |                                                                              |=======                                                               |  10%  |                                                                              |=======                                                               |  11%  |                                                                              |========                                                              |  11%  |                                                                              |========                                                              |  12%  |                                                                              |=========                                                             |  12%  |                                                                              |==========                                                            |  14%  |                                                                              |==========                                                            |  15%  |                                                                              |===========                                                           |  16%  |                                                                              |============                                                          |  17%  |                                                                              |============                                                          |  18%  |                                                                              |=============                                                         |  18%  |                                                                              |=============                                                         |  19%  |                                                                              |==============                                                        |  19%  |                                                                              |==============                                                        |  20%  |                                                                              |===============                                                       |  21%  |                                                                              |===============                                                       |  22%  |                                                                              |================                                                      |  22%  |                                                                              |================                                                      |  23%  |                                                                              |================                                                      |  24%  |                                                                              |=================                                                     |  24%  |                                                                              |==================                                                    |  25%  |                                                                              |===================                                                   |  27%  |                                                                              |===================                                                   |  28%  |                                                                              |====================                                                  |  28%  |                                                                              |====================                                                  |  29%  |                                                                              |=====================                                                 |  30%  |                                                                              |======================                                                |  31%  |                                                                              |======================                                                |  32%  |                                                                              |=======================                                               |  33%  |                                                                              |========================                                              |  34%  |                                                                              |========================                                              |  35%  |                                                                              |=========================                                             |  36%  |                                                                              |==========================                                            |  37%  |                                                                              |==========================                                            |  38%  |                                                                              |===========================                                           |  38%  |                                                                              |===========================                                           |  39%  |                                                                              |============================                                          |  40%  |                                                                              |=============================                                         |  41%  |                                                                              |=============================                                         |  42%  |                                                                              |==============================                                        |  42%  |                                                                              |==============================                                        |  43%  |                                                                              |===============================                                       |  44%  |                                                                              |===============================                                       |  45%  |                                                                              |================================                                      |  45%  |                                                                              |================================                                      |  46%  |                                                                              |=================================                                     |  46%  |                                                                              |=================================                                     |  47%  |                                                                              |==================================                                    |  48%  |                                                                              |==================================                                    |  49%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================                                  |  51%  |                                                                              |=====================================                                 |  53%  |                                                                              |======================================                                |  54%  |                                                                              |=======================================                               |  55%  |                                                                              |=======================================                               |  56%  |                                                                              |========================================                              |  57%  |                                                                              |=========================================                             |  58%  |                                                                              |=========================================                             |  59%  |                                                                              |==========================================                            |  60%  |                                                                              |==========================================                            |  61%  |                                                                              |===========================================                           |  61%  |                                                                              |===========================================                           |  62%  |                                                                              |============================================                          |  62%  |                                                                              |============================================                          |  63%  |                                                                              |=============================================                         |  64%  |                                                                              |==============================================                        |  66%  |                                                                              |===============================================                       |  67%  |                                                                              |===============================================                       |  68%  |                                                                              |================================================                      |  69%  |                                                                              |=================================================                     |  70%  |                                                                              |=================================================                     |  71%  |                                                                              |==================================================                    |  71%  |                                                                              |==================================================                    |  72%  |                                                                              |===================================================                   |  73%  |                                                                              |====================================================                  |  74%  |                                                                              |====================================================                  |  75%  |                                                                              |=====================================================                 |  75%  |                                                                              |=====================================================                 |  76%  |                                                                              |======================================================                |  77%  |                                                                              |=======================================================               |  78%  |                                                                              |=======================================================               |  79%  |                                                                              |========================================================              |  79%  |                                                                              |========================================================              |  80%  |                                                                              |=========================================================             |  81%  |                                                                              |==========================================================            |  82%  |                                                                              |==========================================================            |  83%  |                                                                              |===========================================================           |  84%  |                                                                              |============================================================          |  85%  |                                                                              |============================================================          |  86%  |                                                                              |=============================================================         |  88%  |                                                                              |==============================================================        |  89%  |                                                                              |===============================================================       |  90%  |                                                                              |=================================================================     |  93%  |                                                                              |==================================================================    |  94%  |                                                                              |===================================================================== |  98%  |                                                                              |===================================================================== |  99%  |                                                                              |======================================================================| 100%

    ### Store the ACS data as data frame

    tract_acs_df <- as.data.frame(ca_acs)

    ### Inspect the ACS table

    head(tract_acs_df)

    ##         GEOID                                               NAME total_pop
    ## 1 06077005127 Census Tract 51.27; San Joaquin County; California      7580
    ## 2 06077003406 Census Tract 34.06; San Joaquin County; California      3768
    ## 3 06077004402 Census Tract 44.02; San Joaquin County; California      5903
    ## 4 06077001700    Census Tract 17; San Joaquin County; California      4245
    ## 5 06077000401  Census Tract 4.01; San Joaquin County; California      2856
    ## 6 06077003404 Census Tract 34.04; San Joaquin County; California      7182
    ##   B01001_001M tot_pov B17020_002M                       geometry    pct_pov
    ## 1        1068     644         326 MULTIPOLYGON (((-113121.9 -... 0.08496042
    ## 2         698     962         441 MULTIPOLYGON (((-114750 211... 0.25530786
    ## 3         937     641         371 MULTIPOLYGON (((-111508.5 1... 0.10858885
    ## 4         843    1092         543 MULTIPOLYGON (((-111096.1 -... 0.25724382
    ## 5         338     588         245 MULTIPOLYGON (((-115228.8 -... 0.20588235
    ## 6        1024    1823         800 MULTIPOLYGON (((-113514.1 3... 0.25382902

### Set seed for reproducability

    ### Set seed for reproducability

    set.seed(1)

### Defining the random variables for sampling - Percent in poverty

    ### Poverty rate

    y <- tract_acs_df$pct_pov

    y <- y[is.finite(y)]

    n <- length(y)

    ### Population mean from ACS data

    pop_mean <- mean(y, na.rm = T)

    ### Population standard deviation from ACS data

    pop_sd <- sd(y, na.rm = T)

    mean_val <- pop_mean

    std_val <- pop_sd

    ### Define n as the number of samples

    n <- 100

    ### Creating a new variable 'x' and populating the rnorm function with the mean and standard deviation values to simulate a random normal distribution

    x <- rnorm(n, mean = mean_val, sd = std_val)

    print(x)

    ##   [1]  0.064474980  0.139087360  0.045209352  0.269103413  0.152521914
    ##   [6]  0.046605655  0.167066939  0.190175182  0.175204451  0.094046070
    ##  [11]  0.261412846  0.158078992  0.064955134 -0.081807256  0.225782776
    ##  [16]  0.118034738  0.120682086  0.209103409  0.197810198  0.176873354
    ##  [21]  0.206813835  0.194210362  0.129040917 -0.061052010  0.179261072
    ##  [26]  0.117003633  0.107824024 -0.013287455  0.078134202  0.160666932
    ##  [31]  0.247311727  0.112706200  0.157878978  0.117217652 -0.004658064
    ##  [36]  0.083951012  0.085857969  0.116710316  0.223488900  0.192464038
    ##  [41]  0.107020141  0.098837886  0.186365679  0.173443611  0.058736789
    ##  [46]  0.057010829  0.155752352  0.192957450  0.111825835  0.203325927
    ##  [51]  0.158840006  0.065803789  0.153591407  0.018155524  0.254159047
    ##  [56]  0.304574039  0.088351057  0.026005322  0.174646148  0.109734323
    ##  [61]  0.343369470  0.118559136  0.185700326  0.124752341  0.053715562
    ##  [66]  0.139561596 -0.044068855  0.257155264  0.136288351  0.322277321
    ##  [71]  0.165969115  0.056785059  0.178422990  0.036140060  0.006709855
    ##  [76]  0.149016332  0.081344745  0.122275064  0.129020318  0.067876608
    ##  [81]  0.069797159  0.109722902  0.230678610 -0.018151822  0.176877487
    ##  [86]  0.152838988  0.220087947  0.094157005  0.156253102  0.146773859
    ##  [91]  0.072205533  0.233421512  0.229049826  0.186665039  0.268325387
    ##  [96]  0.173611536  0.004595280  0.069373791  0.009382757  0.078571637

### How Many Samples are Enough?

    ### Define a for loop where the sample size takes values 2 and 10000
    ### Get Samples for the desired population mean and standard deviation
    ### Compute the Sample Mean and Sample Standard Deviation in two temporary variables mean_temp and std_temp
    ### Append mean_temp and std_temp to sample_mean_list and sample_std_list

    sample_mean_list <- c()
    sample_std_list <- c()

    ### Create a for loop that iterates from 2 to 10,000 values by increments of 1

    for(n in seq(2,10000,1)){
      x <- rnorm(n, mean_val, std_val)
      mean_temp <- mean(x)
      std_temp <- sd(x)
      sample_mean_list <- append(sample_mean_list, mean_temp)
      sample_std_list <- append(sample_std_list, std_temp)
    }

    ### Define a vector sample_vals that is a list that contains values between 2 and 10000

    sample_vals <- seq(2,10000)

    ### Mean plot
    ### Creating the threshold band (+-1%) for the population mean with arithmetic operators

    lower_range_mean <- mean_val * 0.99
    upper_range_mean <- mean_val * 1.01

    ### Arguments for the plot function

    plot(sample_vals,
         sample_mean_list,
         type = "l",
         main = "Mean Plot",
         xlab = "Sample Size (CA Tracts)",
         ylab = "Sample Mean Values (% in poverty)")

    ### Using the abline function for plotting
    ### Line type set to 2 to create dashed line representing the upper and lower threshold bands

    abline(h = lower_range_mean, col = "deeppink", lty = 2)
    abline(h = upper_range_mean, col = "deeppink", lty = 2)

![](sampling_census_workflow_files/figure-markdown_strict/Sampling%20from%20the%20population-1.png)

    ### Standard deviation plot
    ### Creating the threshold band (+-1%) for the population standard deviation with arithmetic operators

    lower_range_std <- std_val * 0.99
    upper_range_std <- std_val * 1.01

    ### Arguments for the plot function

    plot(sample_vals,
         sample_std_list,
         type = "l",
         main = "Standard Deviation Plot",
         xlab = "Sample Size (CA Tracts)",
         ylab = "Sample SD Values (% in poverty)")

    ### Using the abline function for plotting
    ### Line type set to 2 to create dashed line representing the upper and lower threshold bands

    abline(h = lower_range_std, col = "deeppink", lty = 2)
    abline(h = upper_range_std, col = "deeppink", lty = 2)

![](sampling_census_workflow_files/figure-markdown_strict/Sampling%20from%20the%20population-2.png)

### Creating function for computing the sample size needed for the threshold

    ### Setting up function 'get_rep_size' that will compute the minimum sample size from the population where the sample values fall within the threshold (+-1%)

    get_rep_size <- function(sample_sizes, sample_means, sample_sds, pop_mean, pop_sd){
      lower_mean <- pop_mean * 0.99
      upper_mean <- pop_mean * 1.01
      lower_sd <- pop_sd * 0.99
      upper_sd <- pop_sd * 1.01
      mean_ind <- which(sample_means >= lower_mean & sample_means <= upper_mean)
      sd_ind <- which(sample_sds >= lower_sd & sample_sds <= upper_sd)
      index <- intersect(mean_ind, sd_ind)
      
      if (length(index) > 0){
        return(sample_sizes[min(index)])
      }else {
        return(NULL)
      }
    }

### Compute the mean and standard deviation using the function

    ### Run function from the previous step to define the smallest representative sample size

    pop_mean <- mean(y, na.rm = T)

    pop_sd <- sd(y, na.rm = T)

    sample_size <- get_rep_size(sample_vals, 
                                sample_mean_list, 
                                sample_std_list, 
                                pop_mean, pop_sd)


    ### Obtain samples for the sample size you found with the function
    ### 100 times and for every run record the sample mean and standard deviation
    ### Create two empty lists that will take the sample mean and standard deviation values

    sample_mean <- c()
    sample_sd <- c()

    for(i in seq(100)){
      x <- rnorm(sample_size, mean = pop_mean, sd = pop_sd)
      sample_mean <- append(sample_mean, mean(x))
      sample_sd <- append(sample_sd, sd(x))
    }

### Create a new data frame

    ### Create a Data Frame with columns Sample Size, Sample Mean, Sample SD and populate it with corresponding lists from the previous steps

    plot_df <- data.frame()

    print(paste0("Data Frame Column Names Before Assignment: ", colnames(plot_df)))

    ## [1] "Data Frame Column Names Before Assignment: "

    ### Assigning three new variables into the Data Frame

    plot_df <- data.frame('Sample Size' = sample_size,
                          'Sample_Mean' = sample_mean, 
                          'Sample_SD' = sample_sd)

    ### Display the Data Frame

    head(plot_df)

    ##   Sample.Size Sample_Mean  Sample_SD
    ## 1         112   0.1191393 0.08893786
    ## 2         112   0.1202582 0.08831137
    ## 3         112   0.1363100 0.09695139
    ## 4         112   0.1287674 0.08903861
    ## 5         112   0.1375372 0.10215398
    ## 6         112   0.1280582 0.10219720

### Plot the result as a distribution

    ### Plot the probability distribution function for sample means
    ### Using ggplot to plot the PDF of the sample mean values
    ### Using additive operators to add the different plot components: histogram of the sample mean, dashed mean line, pdf curve, and labels

    ggplot(plot_df, aes(x = Sample_Mean)) +
      geom_density(alpha = 0.3, fill = "deeppink") +
      geom_vline(aes(xintercept = mean(sample_mean)),
                 color = "red", 
                 linetype = "dashed",
                 size = 1) +
      labs(title = "Probability Distribution Function Plot for the Sample Mean Values ",
           x = "Sample Mean (% in poverty)",
           y = "Density") +
      theme_minimal()

    ## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
    ## ℹ Please use `linewidth` instead.
    ## This warning is displayed once every 8 hours.
    ## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
    ## generated.

![](sampling_census_workflow_files/figure-markdown_strict/Plotting%20the%20distribution-1.png)
