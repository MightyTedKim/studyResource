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

>   ========답변 부탁드려요==============

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
아니면 validation set approach는 validation 한번만 한거고 여러번 한것이 cross validation)인건가요?__     
> ========답변 부탁드려요==============
   
   
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


---   
2018.09.19 선생님 답변
정리를 진짜 너무 잘해주셨네요 ㅋㅋㅋ ㅜㅜ 저도 주피터노트북을 써야할것같아요..

A1. 학습이라는게 사실 이런거였죠? 'Training_Loss(h) + (어떤 숫자 A) * R(h)를 최소화하라' 근데 사실 저런 문제를 'R(h) < (어떤 숫자 B)를 만족하면서, Training_Loss(h)를 최소화하라' 이렇게도 쓸 수 있어요. (어떤 숫자 A에 대응되는 어떤 숫자 B가 항상 존재하구요.) 그래서 저 두 최적화 문제는 사실 같은 문제의 서로 다른 두 가지 표현이기 때문에 서로를 Lagrange Dual 관계라고 얘기해요. 수업에서는 전자의 형태로 설명했지만 사실 정성적으로 이해하기에는 후자의 형태가 좀 더 편하죠. R(h)를 L1 norm으로 설정하면 LASSO, L2 norm으로 설정하면 Ridge였죠? L0 norm인 경우가 Feature Selection이라는건데, 왜 그러냐면 L0 norm가 단순히 벡터의 원소 중 0이 아닌 것의 개수이기 때문이에요. 가령 (1,2,3,1,0,0,-1)같은 벡터의 L0 norm은 5라는거죠. 우리가 다루는게 parametric model이니 R(h)를 L0 norm으로 설정하면 파라미터 중 0이 아닌 것의 개수이고, 결국에 학습은 '(파라미터 중 0이 아닌 것의 개수) < (어떤 숫자 B)를 만족하면서, Training_Loss(h)를 최소화하라'가 되겠죠. 가령 (어떤 숫자 B)를 3이라고 한다면, 파라미터 중 0이 아닐 수 있는건 많아봐야 2개겠죠. 선형 회귀의 경우에는 변수 2개만을 선택하는 상황이 될거구요. L0 norm을 사용하는게 적은 수의 파라미터만 0이 아닌 값을 갖도록 강제하는거라면, L1 norm을 사용하는건 전체적인 파라미터 벡터의 크기가 작아지기를 바라는거에요. 그런데 사실상 람다(어떤 숫자 A)를 크게 하면 할수록 학습된 파라미터들은 소수만 0이 아닌 값을 가지게 되고, 결국엔 Feature Selection이 되는것과 비슷한 효과를 준다는겁니다!

A2. 파라미터의 값이 같다는게 정확히 무슨 말인지 잘 모르겠네요. 파라미터의 값이 다르지 않나요? 그것보다 type 변수에 해당하는 파라미터들의 부호가 달라지는데, 그건 해석할 때 문제가 있을 수 있다는거죠. 왜냐면 model_all에서는 화이트와인의 질이 낮다는 결론을 얻고, model_type에서는 반대의 결론이 나오니까요. 이런건 다중공선성 때문에 발생하는 문제인데 다중공선성을 보이는 변수를 빼 주거나 (VIF라는 통계량을 확인합니다.) Ridge regularization을 사용하면 어느 정도 해소가 되기도 합니다. (질문을 제대로 이해했는지 모르겠네요.)

A3. R1(w)을 L1 norm, R2(w)를 L2 norm이라고 하면 elastic net은 'Training_Loss(h) + lambda * (alpha * R1(w) + (1-alpha) * R2(w))를 최소화하라'가 됩니다. alpha가 1이면 LASSO, 0이면 ridge인데, 0과 1 사이의 값을 사용하면 L1, L2 norm을 모두 사용하는 형태의 Regularizaiton이 되겠죠. 따라서 L1와 L2 간 가중치를 조절해주는 alpha, 제약화의 세기를 조절해주는 lambda가 하이퍼파라미터가 됩니다.

A4. 제가 수업에서 설명한 알고리즘은 Decision Tree 중 CART입니다. CART는 회귀, 분류 문제를 푸는데 모두 사용할 수 있는데, 저는 회귀 문제를 푸는 경우에 대해 설명했습니다. 분류 문제는 아주 조금 더 까다로워질 수 있는데, 연습문제 삼아서 한번 해 보시는걸 추천드려요. 아마 교재들에서는 "불순도를 최소화하도록 split한다"라고 써 있을텐데, 이렇게 생각하시는 것 보다 Logistic Regression에서 했던것처럼 "logloss를 최소화한다"라고 생각해보시고 이게 곧 "불순도를 최소화한다"와 같은 말이라는걸 유도해보시면 좋을 것 같네요.

A5. 앙상블은 모델 여러개를 합치는 기법들을 모두 그렇게 부릅니다. bagging과 boosting은 앙상블 기법의 일종이구요. (이외에 stacking이라는 기법도 존재합니다.) 랜덤포레스트는 decision tree로 구성된 bagging의 특별한 경우라고 보시면 될 것 같아요.

A6. bagging과 boosting은 다 "나무1 + 나무2 + ... + 나무B" 이렇게 생겼습니다. 그런데 나무를 어떻게 만들어 나가느냐의 차이죠. bagging은 '샘플링 -> 나무1', '샘플링 -> 나무2', ... 이렇게 만들어 나간다면 boosting은 '나무1 -> 나무2 -> ...' 이런 식으로 만들어집니다.

A7. 랜덤 포레스트나 bagging이 그렇습니다. 나무의 개수를 정해주지 않아도 된다기 보다는, 일정 갯수 이상의 나무를 사용하면 성능이 나빠지지도 좋아지지도 않기 때문에 주의깊게 튜닝해줄 필요가 없다는 의미입니다.

A8. mtry는 랜덤 포레스트를 구성하는 개별적인 나무들이 자라 나갈 때, 그냥 자라는게 아니라 랜덤하게 자라도록 제어해주는 역할을 했었죠. (가지를 한번 나눌 때, 모든 input을 고려하지 않고 랜덤추출한 특정한 input만 고려)
