# Load packages 
library(tidyverse)
library(here)
library(janitor)

# Set paths
here::here()

# Set plot theme
ggplot2::theme_set(ggplot2::theme_linedraw())

# Load data 
mentalhealth <- 
  readr::read_rds(here::here("data/mentalhealth.rds")) |> 
  janitor::clean_names()

# Check out the data 
dplyr::glimpse(mentalhealth)

# Create a box plot of the number of hours of sleep by mental health status. 
# Save the figure in your figs directory

mentalhealth |> 
  ggplot2::ggplot(aes(y = hrsleep, x = mentalhealth_severe)) +
  ggplot2::geom_boxplot()


mentalhealth |> 
  ggplot2::ggplot(aes(y = hrsleep, x = mentalhealth_severe)) +
  ggplot2::geom_boxplot() +
  ggplot2::facet_wrap(~pooryn)


