library("ggplot2")
library("tidyr")
library(dplyr)
library(forcats)

View(steam_sales_cleaned_in_excel)
head(steam_sales_cleaned_in_excel)
str(steam_sales_cleaned_in_excel)

steam_sales_cleaned_in_excel %>% 
  group_by(detailed_review) %>% 
  summarize(mean(reviews), sd(reviews), min(reviews), max(reviews)) %>% 
  write.table(file = 'Desktop/reviews.csv', col.names = TRUE,
              row.names = FALSE, sep = "\t")

steam_sales_cleaned_in_excel = rename(steam_sales_cleaned_in_excel,"price_USD" = "price (USD)")


steam_sales_cleaned_in_excel %>%
  group_by(detailed_review) %>% 
  summarize(round(mean(price_USD),2), round(sd(price_USD),2), max(price_USD)) %>% 
  write.table(file = 'Desktop/reviews_price.csv', col.names = TRUE,
              row.names = FALSE, sep = "\t")


steam_sales_cleaned_in_excel %>%
  group_by(genres) %>%
  summarize(mean_price = round(mean(price_USD),2),
            sd_price = round(sd(price_USD),2), max_price = round(max(price_USD),1)) %>% 
  arrange(desc(mean_price)) %>% 
  write.table(file = 'Desktop/genres_price.csv', col.names = TRUE,
              row.names = FALSE, sep = "\t")

steam_sales_cleaned_in_excel %>% 
  group_by(multiplayer_or_singleplayer) %>%
  summarize(mean(price_USD), sd(price_USD), min(price_USD), max(price_USD)) %>% 
  drop_na() %>% 
  write.table(file = 'Desktop/mpsp_prices.csv', col.names = TRUE,
              row.names = FALSE, sep = "\t")

steam_sales_cleaned_in_excel %>% 
  group_by(publisher) %>%
  summarize(mean_reviews = round(mean(reviews),0),
             mean_price = round(mean(price_USD),2)) %>%
  arrange(desc(mean_reviews)) %>%
  drop_na() %>%
  write.table(file = 'Desktop/pub_price_reviews.csv', col.names = TRUE,
              row.names = FALSE, sep = "\t")


steam_sales_ %>% 
  summarize(cor(reviews,percent_positive))

steam_sales_cleaned_in_excel = rename(steam_sales_,"price_USD" = "price (USD)")

steam_sales_ %>% 
  filter(price_USD != 0) %>% 
  summarize(cor(price_USD,percent_positive))

View(steam_sales_)

ggplot(data=steam_sales_)+
  geom_smooth(mapping=aes(y=percent_positive, x=price_USD))+
  labs(title = "Reviews vs price", x='price (in USD)', y='percent of positive reviews')

steam_sales_ %>% 
  group_by(genres) %>%
  count(genres) %>% 
  drop_na() %>% 
  arrange(desc(n))


steam_sales_ %>% 
  drop_na() %>% 
  ggplot()+geom_bar(mapping=aes(x=detailed_review,fill=detailed_review))+
facet_wrap(~genres)

steam_sales_ %>%
  drop_na() %>%
  filter(genres=="Action"| genres == "Action/Adventure" | genres == "Action/Indie" |  genres == "Adventure/Indie") %>%
  ggplot+
  geom_boxplot(mapping=aes(y=percent_positive, x=price_USD, color=genres),
              se=FALSE, method='lm')+
  labs(title = "Price vs positive reviews (most popular genres)", x='price (in USD)', y='percent of positive reviews')


steam_sales_ %>%
  drop_na() %>%
  filter(genres=="Action"| genres == "Action/Adventure" | genres == "Action/Indie" | genres == "Adventure/Indie") %>%
  ggplot+
  geom_point(mapping=aes(x=percent_positive, y=reviews, color=genres))

steam_sales_ %>%
  drop_na() %>%
  filter(genres== "Strategy"| genres == "Indie/Simulation" | genres == "RPG" | genres == "Casual/Indie") %>%
  ggplot+
  geom_boxplot(mapping=aes(y=percent_positive, x=price_USD, color=genres),
              se=FALSE, method='lm')+
  scale_color_manual(values = c("Strategy" = "orange",
                                "Indie/Simulation" ="black",
                                "RPG" = 'brown',
                                "Casual/Indie" = "green"))+
  labs(title = "Price vs positive reviews (most popular genres II)", x='price (in USD)', y='percent of positive reviews')



steam_sales_ %>%
  drop_na() %>%
  filter(genres== "Strategy"| genres == "Indie/Simulation" | genres == "RPG") %>%
  ggplot+
  geom_smooth(mapping=aes(x=percent_positive, y=reviews, color=genres))

steam_sales_ %>% 
  drop_na() %>% 
  ggplot+geom_bar(mapping=aes(x=detailed_review,fill=detailed_review))+
  facet_wrap(~multiplayer_or_singleplayer)+
  theme(axis.text.x = element_text(angle = 40, hjust=1))+
  labs(title = "Reviews (all systems): multi vs singleplayer", x='review category', y='number of games')
  

steam_sales_ %>% 
  group_by(publisher) %>%
  count(publisher) %>% 
  drop_na() %>% 
  arrange(desc(n)) %>%
  filter(n > 5) %>% 
  ggplot+geom_col(mapping=aes(x=publisher, y=n))+
  theme(axis.text.x = element_text(angle = 45, hjust=1))+
  scale_y_continuous(breaks=seq(0,20,2))+
  labs(title = "Publishers with more than 5 games in top 1000", x='', y='number of games')

  

steam_sales_ %>%
  drop_na() %>%
  filter(publisher == "Ubisoft" | publisher == "Bethesda Softworks"
        | publisher == "Valve"
         | publisher == "SEGA" | publisher == "Square Enix") %>%
  ggplot+
  geom_bar(mapping=aes(x=forcats::fct_rev(publisher), fill=detailed_review))+
  theme(axis.text.x = element_text(angle = 35, hjust=1))+
  labs(title = "Top Steam publishers + reviews", x='', y='number of games')

steam_sales_ %>%
  drop_na() %>%
  filter(publisher == "2K" | publisher == "Activision"
         | publisher == "BANDAI NAMCO Entertainment" | 
           publisher == "Paradox Interactive") %>%
  ggplot+
  geom_bar(mapping=aes(x=forcats::fct_rev(publisher), fill=detailed_review))+
  theme(axis.text.x = element_text(angle = 35, hjust=1))+
  labs(title = "Top Steam publishers II + reviews", x='', y='number of games')+
  scale_y_continuous(breaks=seq(0,10,2))


steam_sales_ %>% 
  filter(mac_support == 1) %>% 
  drop_na() %>% 
  ggplot+
  geom_bar(mapping=aes(x=detailed_review))+facet_wrap(~multiplayer_or_singleplayer)+
  theme(axis.text.x = element_text(angle = 45, hjust=1))+
  labs(title = "MacOS support", x='review category', y='number of games')

steam_sales_ %>% 
  filter(lin_support == 1) %>%
  drop_na() %>% 
  ggplot+
  geom_bar(mapping=aes(x=detailed_review))+facet_wrap(~multiplayer_or_singleplayer)+
  theme(axis.text.x = element_text(angle = 45, hjust=1))+
  labs(title = "Linux support", x='review category', y='number of games')

steam_sales_ %>% 
  filter(win_support == 1) %>%
  drop_na() %>% 
  ggplot+
  geom_bar(mapping=aes(x=detailed_review))+facet_wrap(~multiplayer_or_singleplayer)+
  theme(axis.text.x = element_text(angle = 45, hjust=1))+
  labs(title="Windows support", x='review category', y='number of games')

library('tidyverse')
library('lubridate')

steam_sales_ %>%
  count(rd = year(release_date)) %>% 
  drop_na() %>% 
  ggplot+
  geom_col(mapping=aes(x=rd, y=n))+
  labs(title="Game releases by year", y='number of games', x='')+
  scale_x_continuous(breaks=seq(1,2019,1))+
  theme(axis.text.x = element_text(angle = 45, hjust=1))
