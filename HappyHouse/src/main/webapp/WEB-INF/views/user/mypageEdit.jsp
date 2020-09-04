<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.ssafy.happyhouse.dto.UserDto" %>
<%
	HttpSession httpSession = request.getSession(true);
	UserDto userinfo = (UserDto) httpSession.getAttribute("userinfo");
	String strUserinfo = userinfo.getId();
%>
<c:set var="root" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<title>회원정보 수정</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<head>
<style>
.center {
  margin: auto;
  width: 60%;
  padding: 10px;
}
.w3-row {
  margin: auto;
  padding: 10px;
}
</style>

</head>

<body>

<!-- Navbar (sit on top) -->
<%@ include file="/WEB-INF/views/form/nav.jsp"%>

<div class="center" style="width: 60%; margin-top: 90px;">
<h2 class="w3-center">회원정보 수정</h2>

<form class="w3-container w3-card-4 w3-light-grey w3-text-blue w3-margin">
	<div class="w3-row">
	  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-user"></i></div>
	  <div class="w3-rest">
	    이름
	    <input class="w3-input w3-border" id="name" name="name" type="text" value="${userinfo.name}" onFocus="this.value=''">
	  </div>
	</div>
	
	<div class="w3-row">
	  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-weixin"></i></div>
	  <div class="w3-rest">
	    아이디
	    <input class="w3-input w3-border" id="id" name="id" type="text" value="${userinfo.id}" onFocus="this.value=''">
	  </div>
	</div>
	
	<div class="w3-row">
	  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-lock"></i></div>
	  <div class="w3-rest">
	    비밀번호
	    <input class="w3-input w3-border" id="pw" name="pw" type="text" value="${userinfo.pw}" onFocus="this.value=''">
	  </div>
	</div>
	
	<div class="w3-row">
	  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-star"></i></div>
	  <div class="w3-rest">
	    닉네임
	    <input class="w3-input w3-border" id="nickname" name="nickname" type="text" value="${userinfo.nickname}" onFocus="this.value=''">
	  </div>
	</div>
	
	<div class="w3-row">
	  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-envelope"></i></div>
	  <div class="w3-rest">
	    이메일
	    <input class="w3-input w3-border" id="email" name="email" type="text" value="${userinfo.email}" onFocus="this.value=''">
	  </div>
	</div>
	
	<div class="w3-row">
	  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-home"></i></div>
	  <div class="w3-rest">
	    주소
	    <input class="w3-input w3-border" id="address" name="address" type="text" value="${userinfo.address}" onFocus="this.value=''">
	  </div>
	</div>
	
	<div class="w3-row">
	  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-laptop"></i></div>
	  <div class="w3-rest">
	    홈페이지
	    <input class="w3-input w3-border" id="homepage" name="homepage" type="text" value="${userinfo.homepage}" onFocus="this.value=''">
	  </div>
	</div>
	
	<div class="w3-row">
	  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-gamepad"></i></div>
	  <div class="w3-rest">
	    취미
	    <input class="w3-input w3-border" id="hobby" name="hobby" type="text" value="${userinfo.hobby}" onFocus="this.value=''">
	  </div>
	</div>
	
	<button class="w3-button w3-block w3-section w3-blue w3-ripple w3-padding" id="btnEdit">수정</button>
	<a href="${root}/mypage" class="w3-button w3-block w3-section w3-red w3-ripple w3-padding" style="text-decoration: none;">취소</a>

</form>
</div>

<script type="text/javascript">
	
	var CURRENT_ID = "<%=strUserinfo%>";
	
	$(document).ready(function() {
		
		$("#btnEdit").click(function() {
			edit();
		});
		
	});
	
	function edit() {
		if($("#id").val() == "") {
			alert("아이디 입력!!!");
			return;
		} else if($("#pw").val() == "") {
			alert("비밀번호 입력!!!");
			return;
		} else if($("#name").val() == "") {
			alert("이름 입력!!!");
			return;
		} else {
			edit();
		}
	}
	
	function edit(){
		
		var user = { 
				id : $("#id").val(),
				pw : $("#pw").val(),
				name : $("#name").val(),
				nickname : $("#nickname").val(),
				email : $("#email").val(),
				homepage : $("#homepage").val(),
				address : $("#address").val(),
				hobby : $("#hobby").val() 
		};
		
		
		$.ajax({
	        type : 'put',
	        url : '<%=contextPath%>/useredit/' + CURRENT_ID,
	        dataType : 'json',
	        data : JSON.stringify( user ),
	        contentType : 'application/json',
	        success : function(data, status, xhr) {
	        	alert("수정 완료");
	        	location.href = '<%=contextPath%>/';
	        }, 
	        error: function(jqXHR, textStatus, errorThrown) 
	        { 
	        	console.log(jqXHR.responseText); 
	        }
		});
	}
</script>
</body>
</html> 
