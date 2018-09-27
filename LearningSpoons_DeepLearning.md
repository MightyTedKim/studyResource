# 4강 Overfitting 관련 질문  

__Q1. feature selection과 lasso/ridge와의 관계__
> 
> 학습 공식: traingingLoss(h) + A * R(h)    
  공식 해석: R(h) < B, 특정 조건 만족하는 상황에서 training Loss를 최소화하자  

> Feature Selection : L0 Norm = 벡터 워소 중 0이 아닌 것의 개수, 적은 수의 파라미터만 0이 아닌 값을 갖도록  
> Lasso : L1 Norm, 전체적인 파라미터 벡트 크기 작아지도록  
> Ridge : L2 Norm, 

--- 

__Q1-2 L0 Norm은 소수의 파라미터만 0이 아닌 값을 가지게 된다고 답 주셨는데, 그건 Lasso의 sparsity 특성 아닌가요?  
L0/L1을 함꼐 이해하려니 혼란스러워요__    

>    

---

__Q2. wine 데이터에서 model_all이랑 model_type의 파라미터 값이 왜 같은지 정확히 이해가 안가요
그래서 tree에서 mtry를 고르는게 좀 헷갈린 거 같기도 하고__

> 제가 질문 자체를 잘못한 것 같아요. 모든 변수를 고려했을 때가 model_all/ 특정 변수만 고려한게 model_type이고   
고려하는 변수가 다르니 결과도 다르다는 것 같아요 
  
<img width="363" alt="wine_capture" src="https://user-images.githubusercontent.com/38391144/46150047-9da50f00-c2a6-11e8-964d-6c44854a1148.PNG">
  
> 쌤 답변: type 변수의 부호가 다른데 이건 해석할 문제가 있을 가능성이 크다는 것.   
modell_all에서는 화이트와인의 질이 낮다는 결론,   
model_type은 화이트와인의 질이 좋다는 결론이 나왔으니까  

__Q3. glmnetUnits(generalized linear model)는 lasso/ridge를 적당히 섞은 건가요?__
> Yes, L1/L2 norm을 모두 사용하는 형태의 regularization임  
> alpha(가중치) 가 1이면 lasso에 가깝고, 0이면 ridge에 가까움   
> lambda(제약화의 세기) 도 하이퍼 파라미터임  

__Q4. validation set approach 안에 kfold와 loo cv 가 있는건가요?   
    아니면 validation set approach는 validation 한번만 한거고 여러번 한것이 cross validation)인건가요? __     
>
   
   
---
# 5강, Decision Tree 관련  

__1. Decision tree의 대표격인 CART를 중점적으로 설명한 것인지?__  
 > Yes, 수업에서는 Decision tree 중 CART를 설명함  

__2. 구글링하다보니 CART에 classification있던데?__
 > Yes, classification, regression 둘다 있는데, classification만 설명함 (분류 문제는 좀 까다로워서)  
 참고로, 다른 교재에서 '불순도를 최소화 한다. = logloss를 최소화한다.' 같은 의미임
  
__3. 앙상블이 정확히 무엇인지?__  
 > 앙상블은 여러 모델을 합치는 기법들을 총칭함  
 
__4. bagging, boosting과 앙상블, 랜덤 포레스트와의 관계가 어떤 관계인지__
 > - bagging, boosting은 앙상블 기법의 일종   
 > - 랜덤포레스트는 bagging의 의 특별한 경우  
  
__5. bagging에서 unique tree를 위해 random forest 사용으로 이해했는데, bagging과 boosting은 아예 다른 건가요?__    
     
  > 공통점: 나무1 + 나무2 + ... + 나무B  
    차이점: 나무를 어떻게 만드는지      
  >  - bagging : 샘플링 -> 나무1, 샘플링 -> 나무2 ...  
  >  - boosting : 나무1 -> 나무2 -> ... 
      
__6. 파라미터 tree 갯수를 상관하지 않아도 되는 모델이 있따고 필기했는데, tree는 다 정해줘야 하지 않은지?__  
 > No, 랜던 포레스트/ bagging은 일정 갯수 이상 나무를 사용하면 성능이 나빠지지도 좋아지지도 않아서  
 주의깊게 튜닝해줄 필요가 없다는 뜻이었음  

__7. Mytry는 random forest split 할때, 선택될 나무의 갯수로 이해했는데 맞는지?__  
 > RF를 구성하는 개별 나무들이 자라 나갈 떄, 랜덤하게 자라도록 제어하는 역할임 
 > (가지 한 번 나눌 때 모든 input을 고려하지 않고 랜덤 추출한 특정한 input만 고려)


   
checking for md
