# load data
setwd('C:/Users/phc07/Desktop/dataHC/01_bigdata/03_BigdataEngineer')
route <- getwd()

credit <- read.csv(file.path(route, "credit_final.csv"))

class(credit$credit.rating)

# ���Ӻ��� factor ��ȯ
credit$credit.rating <- factor(credit$credit.rating)
str(credit)


# ������ ����
set.seed(125)
idx <- sample(1:nrow(credit), nrow(credit)*0.7,
              replace = F)
train <- credit[idx,]
test <- credit[-idx,]

# logistic regression
log <- glm(credit.rating~.,
                data = train,
                family = "binomial")
summary(log)

#step function

step.log <- step(glm(credit.rating~1, 
                     data = train,
                     family = "binomial"),
                 scope = list(lower = ~1,
                              upper = ~account.balance + 
                                credit.duration.months +
                                previous.credit.payment.status +
                                credit.purpose + 
                                credit.amount + 
                                savings +
                                employment.duration +
                                installment.rate +
                                marital.status +
                                guarantor + 
                                residence.duration +
                                current.assets +
                                age +
                                other.credits +
                                apartment.type +
                                bank.credits +
                                occupation + 
                                dependents + 
                                telephone + 
                                foreign.worker), direction = "both")

summary(step.log)

# ������ ���� ���з��� Ȯ��
install.packages("caret")
library(caret)

# �������� response�� ������ Ȯ���� ���
pred <- predict(step.log, test[,-1], type = 'response')

#����� dataframe���� ǥ��
pre_df <- as.data.frame(pred)

# ���� �߰�
pre_df$grade <- ifelse(pre_df$pred<0.5,
                        pre_df$grade<-0,
                        pre_df$grade<-1)

confusionMatrix(data = as.factor(pre_df$grade),
                reference = test[,1],
                positive = '1')