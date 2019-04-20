### Spring) spring-security를 이용한 암호화



![img](https://postfiles.pstatic.net/MjAxODEyMDRfMjk2/MDAxNTQzODkzOTU5OTY4.0dvJjNzL_xqDr3f7wYrD5-Mk3xetPFGH7rQP0kB_VE8g._MP93_ZY418XgGPzxc7G_BmdMBSCIhzqgw2xNLnO67Ug.PNG.deet1107/image.png?type=w580)

## Spring security를 이용한 암호화

spring security에는 로그인 기능도 있고, 암호화 방법도 여러개 있는데

저는 인터셉터 사용해서 로그인 처리했기 때문에 단순 암호화만 연습했다.

아마 회사 들가면, 암호화 사용하고 잇을테니 그 떄 다시 들가서보면 돼요

이건 작년 12월 쯤에 정리하면서 썼던 글이네요

## 원리

sha 256 대신 bcrypt를 사용했는데 자세한 내용은 아래 링크에 있어요. 뭐 좋답니다ㅋㅋ
<https://d2.naver.com/helloworld/318732>

![img](https://dthumb-phinf.pstatic.net/?src=%22https%3A%2F%2Fd2.naver.com%2Fcontent%2Fimages%2F2015%2F07%2F318732.PNG%22&type=ff500_300)

안전한 패스워드 저장

## 요약

- 저는 스프링 4.3.8 썼어요

사용방법이 엄청 많아가지고, 그냥

>  "pom.xml"에 security나 암호화 라이브러리 넣고
>
> "스프링시큐리티.xml" 에 bean 설정해주고, 
>
> "web.xml"에서 bean 설정한 xml 바라보게 하면 됩니다.



사용할 떄는

- 컨트롤러에서 inject나 autowired 하고

```
@Inject
  	private BCryptPasswordEncoder passwordEncoder;
```

- 넣을 때  이렇게 인코딩하고

```
String encodePwd = passwordEncoder.encode(userVO.getUpw());
```

- 빼올 때는 이런식으로 맞는지만 확인 할 수 있어요

```
passwordEncoder.matches(dto.getUpw(), vo.getUpw())
```



## 예시 코드

- pom.xml

```xml
// pom.xml
<!-- spring security --> 
<dependency> 
	<groupId>org.springframework.security</groupId> 
	<artifactId>spring-security-web</artifactId> 
	<version>4.1.0.RELEASE</version> 
</dependency> 

<dependency> 
	<groupId>org.springframework.security</groupId> 
	<artifactId>spring-security-core</artifactId> 
	<version>4.1.0.RELEASE</version>
</dependency>

<dependency> 
	<groupId>org.springframework.security</groupId> 
	<artifactId>spring-security-config</artifactId> 
	<version>4.1.0.RELEASE</version>
</dependency>
```



- 2. spring-security.xml

```xml
//spring-security.xml 
<?xml version="1.0" encoding="UTF-8"?> 
<beans:beans xmlns="http://www.springframework.org/schema/security"     xmlns:beans="http://www.springframework.org/schema/beans"     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"     xsi:schemaLocation="http://www.springframework.org/schema/beans        http://www.springframework.org/schema/beans/spring-beans.xsd        http://www.springframework.org/schema/security        http://www.springframework.org/schema/security/spring-security.xsd">     

<beans:bean id="bcryptPasswordEncoder"            class="org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder" /> </beans:beans>   
```



- 3. web.xml

listener가 있어야지 param-value 여러개가 된다.

```xml
//web.xml

  <listener>
    <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
  </listener>
  <servlet>
    <servlet-name>appServlet</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
    <init-param>
      <param-name>contextConfigLocation</param-name>
      <param-value>
      	classpath:spring/servlet-context.xml
      	classpath:spring/spring-security.xml      	
      </param-value>
    </init-param>
    <load-on-startup>1</load-on-startup>
  </servlet>


```



- Controller

>  저는 servlet-context에 controller만  component-scan 설정했기 때문에 controller에서  bean을 사용해야 했어요
>  *** Service나 다른 scan 파일에서는spring-security파일이 없다고 나옴**

```java

@Controller
@RequestMapping("/user")
public class UserController {
    @Inject
	private UserService service;

	@Inject
	private BCryptPasswordEncoder passwordEncoder;

	@RequestMapping(value = "/post_loginRegister", method = RequestMethod.POST)
	public String loginRegister(UserVO userVO, RedirectAttributes ra) throws Exception{
		String encodePwd = passwordEncoder.encode(userVO.getUpw());
		userVO.setUpw(encodePwd);
		
		service.register(userVO);
		ra.addFlashAttribute("msg", "로그인에 성공하셨습니다.");
		return "redirect:/user/page_login";
	}

    @RequestMapping(value = "/post_login", method = RequestMethod.POST)
	public String loginPOST(LoginDTO dto, HttpSession session, Model model,
			RedirectAttributes ra) throws Exception{
		UserVO vo = service.login(dto);

		if (vo == null) {
			//1 failure
			ra.addFlashAttribute("msg", "로그인에 실패하셨습니다.");
			return "redirect:/user/page_login";			
		}else if(passwordEncoder.matches(dto.getUpw(), vo.getUpw())){
			//success

			model.addAttribute("userVO", vo); //for post interceptor
		}
		return null;//if success post loginInterceptors performs response.sendRedirect
	}
	
```

