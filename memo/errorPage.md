안녕하세요, 4개월차 병아리 난쏘공입니다.

저번주 TTP 세미나 듣고 와서, 느낀점이 있습니다.

첫번째 발표를 했던 Jason님처럼 쉽게 간결하게, 내용을 설명하려면

꾸준히 연습해야한다는 것을요 ㅋㅋ



그래서 연습겸, 아직 깊이는 없지만 저도 정리를 해보려합니다.

주제는  "국비지원 강사님들이 지나칠 수 있는 점"

(저 같은 경우는 실무 경력이 없으신 분께 이론만 배웠거든요)

---



빵형 영상에서 신입의 기본이 여러개가 있다고 했는데

가장 대표적인 것은 2개는 **암호화** 와 **에러 페이지 처리** 입니다. 

엄청 간단하기 때문에, 면접 질문에서도 나올 가능성이 높은 부분이고요



## 에러페이지

- 에러 페이징을 하지 않으면 톰켓 버전도 노출되고 사용자 입장에서도 달갑지 않죠



## 예시

- 아래는 깃허브와 w3chool 에러페이지인데, 사용자 입장에서 더 편하게 사이트를 이용할 수 있어요

![errorPage_1](..\images\errorPage_1.png)



## 샘플 이미지

- 저는 인터넷에서 아래와 같은 에러페이지를 사용해봤습니다 (깜빡거려서 서버처럼 보이더라고요)

![errorPage_1](..\images\errorPage_2.png)

## 샘플 코드

![errorPage_1](..\images\errorPage_3.png)

- web.xml

```xml
 //web.xml
 <error-page>
  	<error-code>400</error-code>
 	<location>/error/error400.jsp</location> 
  </error-page>

  <error-page>
  	<error-code>404</error-code>
 	<location>/error/error404.jsp</location> 
  </error-page>

  <error-page>
  	<error-code>500</error-code>
 	<location>/error/error500.jsp</location> 
  </error-page>
```

- error400/404/500/.jsp

![errorPage_1](..\images\errorPage_4.png)

```html
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %> //500은 이거 써야해요
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>error500</title>
</head>
<body>
	<div class="content">
		<h1> 에러 사항</h1>
		<h4> error: 500 </h4>
		<h4> 심각한 오류가 발생했습니다.</h4>
		<p>	Internal Server Error, 
            서버 내부 오류 - 이 에러는 웹 서버가 요청사항을 
            수행할 수 없을 경우에 발생합니다. </p>
		<p> <%=exception.toString() %></p>
	</div>
	<hr/>
</div>  
</body>
<style>
</html>
```



- 특이사항

500error는 한줄 더 추가해줘야합니다.

```
<%@ page isErrorPage="true" %>	
```

<https://github.com/MightyTedKim/drone_picnic/blob/master/drone_picnic_byTed/src/main/webapp/error/error500.jsp>



## 기타

대표적인 에러 400/404/500 만 넣었어요

400 : Bad Request, 요청 실패 

- 문법상 오류가 있어서 서버가 요청 사항을 이해하지 못함. 

404 :  Not Found, 문서를 찾을 수 없음

- 이 에러는 클라이언트가 요청한 문서를 찾지 못한 경우에 발생함. URL을 다시 잘 보고 주소가 올바로 입력되었는지를 확인함.

500 :  Internal Server Error, 서버 내부 오류

- 이 에러는 웹 서버가 요청사항을 수행할 수 없을 경우에 발생함 




<div id="wrapper">
<div class="grid">
  <span class="server"></span>
  <span class="server"></span>
  <span class="server"></span>
  <span class="server"></span>
  <span class="server"></span>
</div