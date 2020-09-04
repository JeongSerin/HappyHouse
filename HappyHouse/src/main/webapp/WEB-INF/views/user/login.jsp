<%@page import="com.ssafy.happyhouse.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.ssafy.happyhouse.dto.UserDto" %>
<%
	String contextPath = request.getContextPath();
%>
<c:if test="${cookie.ssafy_id.value ne null}">
	<c:set var="saveid" value="${cookie.ssafy_id.value}"/>
	<c:set var="idck" value=" checked=\"checked\""/>
</c:if>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>로그인</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style>
  h3 {
  	margin-top: 40px;
    margin-bottom: 20px;
    text-align: center;
  }
</style>

</head>

<body>

<div class="container col-xs-6" align="center" >

	<div align="center">
		<form id="loginForm">
			<div class="form-group" align="left">
				<label for="">아이디</label>
				<input type="text" class="form-control" id="userid" name="userid" placeholder="" value="${saveid}" required="required">
			</div>
			<div class="form-group" align="left">
				<label for="">비밀번호</label>
				<input type="password" class="form-control" id="userpwd" name="userpwd" placeholder="" onkeydown="javascript:if(event.keyCode == 13) {login();}" required="required">
			</div>
			<div class="form-group form-check" align="right">
			    <label class="form-check-label">
			      <input class="form-check-input" type="checkbox" id="idsave" name="idsave" value="saveok"${idck}> 아이디저장
			    </label>
			</div>
			
			<div class="form-group" align="center">
				<button type="submit" class="btn btn-warning" id="btnLogin">로그인</button>
				<button type="button" class="btn btn-danger" id="btnFindPwd">비밀번호 찾기</button>
				<button type="button" class="btn btn-primary" id="btnJoin">회원가입</button>
			</div>
		</form>
	</div>
</div>
</body>

<script type="text/javascript">
$(document).ready(function() {
	// 로그인
	$("#btnLogin").click(function(){
		login();
	});
	
	// 비밀번호 찾기
	$("#btnFindPwd").click(function(){
		findpwd();
	});
	
	// 회원가입
	$("#btnJoin").click(function(){
		moveJoin();
	});
});

function login() {
	if($("#userid").val() == "") {
		alert("아이디를 입력해주세요.");
		return;
	} else if($("#userpwd").val() == "") {
		alert("비밀번호를 입력해주세요.");
		return;
	} else {
		$.ajax({
	        type : 'post',
	        url : '<%=contextPath%>/login',
	        dataType : 'json',
	        data : 
			{
	        	id: $("#userid").val(),
				pw: $("#userpwd").val()
			},
	        success : function(data, status, xhr) {
	        	alert("로그인 성공!");
	        	location.href = '<%=contextPath%>/';
	        }, 
	        error: function(jqXHR, textStatus, errorThrown) 
	        { 
	        	console.log(jqXHR.responseText); 
	        }
		});
		$("loginForm").attr("method", "POST");
		$("loginForm").attr("action", "login");
		
	}
}

function findpwd() {
	document.location.href = "${root}/findpwd";
}	

function moveJoin() {
	document.location.href = "${root}/mvjoin";
}	
</script>

</html>
