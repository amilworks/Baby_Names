
setwd("~/Downloads/output")
national <- read.table("NationalNames.csv", header = TRUE, sep = ",")  

library(ggplot2)
library(readr)
library(dplyr) 
library(plotly)
library(shiny)
attach(national)

head(national)

max(Count)
MAX <- national[national$Count == 99680,]
MAX
Avg <- mean(Count)

as.data.frame(table(national$Name))
df <- as.data.frame(table(national$Name))
orders <- order(df$Freq)
top10 <- orders[(length(orders)-10):length(orders)]
top10
T10 <- df[c(41474, 41598, 52642, 53299, 58091, 66699, 72342, 79419, 85623, 90045),]
T10
names <-T10$Var1
names
smaller <- national[national$Name %in% names,]
smaller

q <- smaller$Name

p <- unique(q)

plot_ly(smaller, x = ~Count, y = ~Year, type = 'scatter', mode = 'markers',
        text = ~paste('Name: ', Name, 
                      '</br> Gender: ', Gender,
                      '</br> Year Born: ', Year))

 ggplot(smaller,  aes(x = Name, y = Count, col = Gender)) + geom_jitter(alpha = .4) + theme_minimal()


ggplot(smaller, aes(x = Year, y = Count, col = Name)) + geom_line( alpha = .5)

plot_ly(smaller, x = ~Count, y = ~Name, z = ~Year, color = ~Gender, colors = c('#BF382A', '#0C4B8E')) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'Number of Babies'),
                      yaxis = list(title = 'Baby Name'),
                      zaxis = list(title = 'Year Born')))



colors <- c('#4AC6B7', '#1972A4', '#965F8A', '#FF7070', '#C61951')
plot_ly(smaller, x = ~Count, y = ~Name, z = ~Year, color = ~Gender, size = ~Count, colors = colors,
             marker = list(symbol = 'circle', sizemode = 'diameter'), sizes = c(5, 20), alpha = .6,
             text = ~paste('Name:', Name, '<br>Count:', Count, '<br>Year Born:', Year,
                           '<br>Gender:', Gender)) %>%
  layout(title = 'Baby Names Popularity Through Time',
         scene = list(xaxis = list(title = 'Number of People with Same Name',
                                   gridcolor = 'rgb(255, 255, 255)',
                                   
                                   type = 'log',
                                   zerolinewidth = 1,
                                   ticklen = 5,
                                   gridwidth = 2),
                      yaxis = list(title = 'Baby Name',
                                   gridcolor = 'rgb(255, 255, 255)',
                                   
                                   zerolinewidth = 1,
                                   ticklen = 5,
                                   gridwith = 2),
                      zaxis = list(title = 'Year Born',
                                   gridcolor = 'rgb(255, 255, 255)',
                                   type = 'log',
                                   zerolinewidth = 1,
                                   ticklen = 5,
                                   gridwith = 2)),
         paper_bgcolor = 'white',
         plot_bgcolor = 'rgb(243, 243, 243)')


