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
D
# Logistic regression 1 
dat1 <- 
  mentalhealth |> 
  dplyr::filter(age >= 18) |> 
  drop_na() |> 
  dplyr::mutate(mentalhealth_severe = 
                  ifelse(mentalhealth_severe == "Yes", 1, 0))

logreg1 <- glm(mentalhealth_severe ~ hrsleep,
               data = dat1,
               family = binomial(link = "logit"))
summary(logreg1)
broom::tidy(logreg1, exponentiate = TRUE, conf.int = TRUE)



# Logistic regression 2 
logreg2 <- glm(mentalhealth_severe ~ sleep_mt7hr,
               data = dat1,
               family = binomial(link = "logit"))
summary(logreg2)
broom:::tidy.glm(logreg2, conf.int = TRUE)

# Logistic regression 3
logreg3 <- glm(mentalhealth_severe ~ sleep_mt7hr + age + sleep_mt7hr:age,
               data = dat1,
               family = binomial(link = "logit"))
summary(logreg3)
broom:::tidy.glm(logreg3, conf.int = TRUE, exponentiate = TRUE)

# Logistic regression 4 
logreg4 <- glm(mentalhealth_severe ~ sleep_mt7hr + pooryn + sleep_mt7hr:pooryn,
               data = dat1,
               family = binomial(link = "logit"))
summary(logreg4)
broom:::tidy.glm(logreg4, conf.int = TRUE, exponentiate = TRUE)