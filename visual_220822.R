# load data

setwd("C:/Users/phc07/Desktop/dataHC/01_bigdata/03_BigdataEngineer")
route <- getwd()

traffic <- read.csv(file.path(route, 'traffic.csv'))
traffic

jung <- subset(traffic, 
               ��ġ���� == '�߱�' & ���� == 2015)
jung

tra15 <- subset(traffic, 
               �� == 12 & ���� == 2015)
tra15


# libraries
library(ggplot2)

# bar plot
bar <- ggplot(data =jung, aes(x = ��, y = �߻��Ǽ�)) +
  geom_bar(stat = 'identity', color = 'red', fill = 'orange') +
  coord_cartesian(xlim = c(0, 13), ylim = c(0, 160)) +
  ggtitle("2015�� ���� �߱��� ���� ������ �߻� ����")

bar

# scatter plot
scat <- ggplot(data =jung, aes(x = ��, y = �߻��Ǽ�)) +
  geom_point(aes(x = ��, y = �߻��Ǽ�)) +
  coord_cartesian(xlim = c(0, 13), ylim = c(0, 160)) +
  ggtitle("2015�� ���� �߱��� ���� ������ �߻� ����")

scat

# line 

line <- ggplot(data =jung, aes(x = ��)) +
  geom_line(aes(y = �߻��Ǽ�)) +
  coord_cartesian(xlim = c(0, 13), ylim = c(0, 160)) +
  ggtitle("2015�� ���� �߱��� ���� ������ �߻� ����")

line

# ���� �ð�ȭ

# load data
seoul <- read.csv(file.path(route, 'seoul.csv'), 
                  header = T, sep = ",",
                  encoding = "EUC-KR")
seoul

seoul15 <- merge(tra15, seoul, 
                 by.x="��ġ����", by.y = "area")

seoul15

# libraries

install.packages("ggmap") # ����
install.packages("maps") # ����
install.packages("mapproj") # ����

library("ggmap")
library("maps")
library("mapproj") # ���� ��� ����

# load map
## require google api

register_google(key = "AIzaSyDvO0zaBtHZD5pEeVjdwHVMusgNcXDFXv8")

seoul_map <- get_googlemap("seoul", zoom = 11)
sm <- ggmap(seoul_map) #ggmap() ���� ������ �ð�ȭ
print(sm)

# dot plot
dot <- ggmap(seoul_map)
dot <- dot + geom_point(data = seoul15, 
                        aes(x = lon, y = lat))
dot

# bubble plot

library(RColorBrewer)

bub <- ggmap(seoul_map)
bub <- bub + 
  scale_fill_brewer(palette = "Set2") +
  geom_point(data = seoul15, 
             aes(x=lon, y=lat, size = "�߻��Ǽ�"),
             shape = 16, color = 'yellow', alpha = 0.6)
bub

# relation visualization

scat2 <- ggplot(tra15, aes(x=�߻��Ǽ�, y = �λ��ڼ�))
scat2 <- scat2 + geom_point() +
  ggtitle("������ - �߻��Ǽ��� ����ڼ��� ����")+
  stat_smooth(method = "lm", se = F, color = 'skyblue')
scat2

# bubble chart
bub2 <- ggplot(tra15, aes(x=�߻��Ǽ�, y = �λ��ڼ�)) +
  scale_fill_brewer(palette = "Set3") +
  geom_point(aes(size = ����ڼ�), shape = 16, color = 'red',
             alpha = 0.56) +
  ggtitle("������ �߻� ��� ������Ʈ"); bub2

# bar graph

ba <- ggplot(tra15, aes(x=��ġ����, y = �λ��ڼ�)) +
  geom_bar(stat = 'identity', color = 'gray', fill = 'magenta') +
  ggtitle("������ �λ��ڼ�"); ba

# heatmap

row.names(tra15) <- tra15$��ġ����
tra15 <- tra15[,c(4:6)]
tra15_mat <- data.matrix(tra15)
tra15_mat
heatmap(tra15_mat, Rowv = NA, Colv = NA,
        col = cm.colors(256), scale = "column",
        margin = c(5,5), cexCol = 1)

