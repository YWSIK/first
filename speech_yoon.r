install.packages("stringr")
library(stringr)
install.packages("dplyr")
library(dplyr)
install.packages("tidytext")
library(tidytext)


raw_yoon <- readLines("C:/R/Data/speech_yoon.txt", encoding = "UTF-8")
head(raw_yoon)
yoon <- raw_yoon %>%
  str_replace_all("[^^가-힣]", " " ) %>%
  str_squish() %>%
  as_tibble()

word_space <- yoon %>%
  unnest_tokens(input = value,
                output = word,
                token = "words")

word_space <- word_space %>%  count(word, sort = T)
word_space

word_space <- word_space %>% filter(str_count(word) > 1)
word_space


top20 <- word_space %>% head(20)
top20
 

install.packages("ggplot2")
library(ggplot2)


install.packages("ggwordcloud")
library(ggwordcloud)

install.packages("showtext")
library(showtext)

font_add_google(name = "Nanum Myeongjo", family = "Nanum Myeongjo")
showtext_auto()

p1 <- ggplot(word_space, aes(label = word, size = n, col = n)) +
  geom_text_wordcloud(seed = 1234, family = "Nanum Myeongjo") +  
  scale_radius(limits = c(3, NA), range = c(3, 30)) +
  scale_color_gradient(low = "#31609e", high = "#b52155") 
p1+ theme_minimal()


font_add_google(name = "Nanum Myeongjo", family = "Nanum Myeongjo")
showtext_auto()

ggplot(top20, aes(x = reorder(word, n), y = n)) +
  geom_col() +
  coord_flip() +
  geom_text(aes(label = n), hjust = -0.3) +
  labs(title = "윤석열 대통령 취임사 단어 빈도",
       x = NULL, y = NULL) +
  theme(title = element_text(size = 12), text = element_text(family = "Nanum Myeongjo"))