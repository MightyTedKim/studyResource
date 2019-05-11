<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
//네이버 callback페이지 function

		var naverLogin = new naver.LoginWithNaverId(
			{
				clientId: "{YOUR_CLIENT_ID}",
				callbackUrl: "{YOUR_REDIRECT_URL}",
				isPopup: false,
				callbackHandle: true
				/* callback 페이지가 분리되었을 경우에 callback 페이지에서는 callback처리를 해줄수 있도록 설정합니다. */
			}
		);

   var naver_id_login = new naver_id_login("vrfDd_oEEiXRnIQESd1g", "https://nid.naver.com/oauth2.0/authorize");
   
   // 접근 토큰 값 출력
   alert(naver_id_login.oauthParams.access_token);
   // 네이버 사용자 프로필 조회
   naver_id_login.get_naver_userprofile("naverSignInCallback()");
   // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
   function naverSignInCallback() {
     
     /*
     alert(naver_id_login.getProfileData('email'));
     alert(naver_id_login.getProfileData('nickname'));
     alert(naver_id_login.getProfileData('age'));
     alert(naver_id_login.getProfileData('birthday'));
     */
   	 
     console.log(naver_id_login.oauthParams.access_token);
     console.log(naver_id_login.getProfileData('email'));
     console.log(naver_id_login.getProfileData('nickname'));
     console.log(naver_id_login.getProfileData('birthday'));
     console.log(naver_id_login.getProfileData('name'));
     
     var navernickname = naver_id_login.getProfileData('email');
     var sp = navernickname.split("@");
     var nickname = sp[0];
     location.href="../socialjoinprocess.me?id=" + naver_id_login.getProfileData('email') + "&nickname=" + nickname + "&password=" + nickname;
   }
</script>
</body>
</html>