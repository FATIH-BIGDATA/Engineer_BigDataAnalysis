# data load & check
library(MASS)
data("Cars93")
str(Cars93) #structure

# simple lenear regression model 
# enginsie : x, price : y
lm(Price~EngineSize, Cars93)

# model scan : Use summary()
# summary() : �־��� ���ڿ� ���� ������� ����
cars93_model <- lm(Price~EngineSize, Cars93)
summary(cars93_model)

# plot.lm(x,y) : ����ȸ�͸� �ð�ȭ �Լ�
# x : ����ȸ�͸���, y : �׷��� ����

# �׷��� ��ġ
par(mfrow = c(2,3))

# �׷��� �ۼ�
plot(cars93_model, which = c(1:6))
