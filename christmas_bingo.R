# ------------------------------------------------------------
#                 CHRISTMAS BINGO
#
#                 Jeppe Vierø
#                 December 2020
# ------------------------------------------------------------
rm(list=ls())


library(tidyverse)
library(magrittr)
library(rio)

data_path <- "~ data path here"

# ----- Load nicknames
nicks <- rio::import(paste0(data_path,
                            "/bingo_nicknames.xlsx")) %>% 
  filter(!is.na(Number)) %>% 
  select(-Explanation) %>% 
  rename(numbers = Number)

# ----- Define numbers
numbers_pool <- data.frame(
  numbers = seq(1,
                90,
                1),
  used <- NA
) %>% 
  left_join(.,
            nicks,
            by = "numbers")

rm(nicks)
# ------------------------------------------------------------
#                 PLAY CHRISTMAS BINGO
# ------------------------------------------------------------
# ----- Random draw
draw_n <- sample(numbers_pool$numbers,
                 size = 1,
                 replace = F)

numbers_pool %>% 
  filter(numbers == draw_n) %$%
  print(paste(numbers,
              Nickname,
              sep = ", "))

# ----- Remove from  pool
numbers_pool <- numbers_pool %>% 
  mutate(used = ifelse(numbers == draw_n,
                       1,
                       used)) %>% 
  filter(is.na(used))

