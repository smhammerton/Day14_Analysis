# Load packages
library(tidyverse)
library(here)

# Set paths
here::here()

# Load data 
mentalhealth <- 
  readr::read_csv(here::here("data/F2022-NHIS-MentalHealth_raw.csv"))

# Check out the data 
dplyr::glimpse(mentalhealth)

mentalhealth2 <- 
  mentalhealth |> 
  dplyr::mutate(
    HRSLEEP = ifelse(
      HRSLEEP %in% c(00, 97, 98, 99),
      NA,
      HRSLEEP
    ),
    sleep_mt7hr = ifelse(
      HRSLEEP < 7,
      "No",
      "Yes"
    ),
    dplyr::across(
      .cols =  c(AEFFORT, AHOPELESS, ANERVOUS, ARESTLESS, ASAD, AWORTHLESS),
      .fns = \(x) ifelse(x %in% 6:9, NA, x)
    ),
    kessler_score =
      AEFFORT + AHOPELESS + ANERVOUS + ARESTLESS + ASAD + AWORTHLESS,
    mentalhealth_severe = ifelse(
      kessler_score >= 13,
      "Yes",
      "No"
    ),
    AGE = ifelse(
      AGE %in% 997:999,
      NA,
      AGE
    ),
    POORYN = ifelse(
      POORYN == 9,
      NA,
      POORYN
    )
  )

saveRDS(mentalhealth2,
        file = here::here("data/mentalhealth.rds"))
