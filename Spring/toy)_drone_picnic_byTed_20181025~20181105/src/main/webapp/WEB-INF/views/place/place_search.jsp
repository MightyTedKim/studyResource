<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<input id="address" type="text" placeholder="도로명 주소">
<input id="searchBtn_submit" type="button" value="검색"> 
 
<script>
naver.maps.onJSContentLoaded = searchAddress;
</script>