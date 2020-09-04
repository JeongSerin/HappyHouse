<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Navigation</title>
</head>

<style>
  .w3-bar-item {
    margin-right: 5px;
  }
</style>

<body>

<!-- Navbar (sit on top) -->

<nav class="w3-top w3-bar-item">
  <div class="w3-bar w3-white w3-wide w3-padding w3-card">
    <a href="${root}/" class="w3-bar-item w3-button" style="cursor: pointer;text-decoration: none;"><b>Happy</b> House</a>
    <!-- Float links to the right. Hide them on small screens -->
    <div class="w3-right w3-hide-small">
      <c:if test="${userinfo == null}">
      	<span id="span_login" data-toggle="modal" data-target="#myModal" class="w3-bar-item w3-button w3-green w3-padding">로그인</span>
      	<a href="${root}/mvjoin" class="w3-button w3-amber w3-padding" style="text-decoration: none;">회원가입</a>
      </c:if>
      <c:if test="${userinfo != null}">
    	<a href="${root}/mvnotice" class="w3-bar-item w3-button" style="text-decoration: none;">공지사항</a>
    	<div class="w3-dropdown-hover">
    		<a class="w3-button">관심지역</a>
    		<div class="w3-dropdown-content w3-bar-block w3-card-4">
    			<a href="/fav/${userinfo.id}" class="w3-bar-item w3-button" style="text-decoration: none;">관심지역 보기</a>
    			<a href="/fav/regist" class="w3-bar-item w3-button" style="text-decoration: none;">관심지역 등록</a>

    		<!-- 
    			<a href="/fav.do?act=list&id=${userinfo.id}" class="w3-bar-item w3-button" style="text-decoration: none;">관심지역 보기</a>
    			<a href="${root}/user/favRegist.jsp" class="w3-bar-item w3-button" style="text-decoration: none;">관심지역 등록</a>
    		 -->
 		 	</div>   	
      	</div>
      	<a href="${root}/index.html" class="w3-bar-item w3-button" style="text-decoration: none;">QnA</a>
      	<a href="${root}/mypage" id="myinfo" style="cursor: pointer;text-decoration: none;margin-left: 10px;"><strong style="color: #6495ED;">${userinfo.name}</strong></a>님 환영합니다.
		<a href="${root}/logout" class="w3-button w3-amber w3-padding" style="cursor: pointer;text-decoration: none;">로그아웃</a>
      </c:if>
    </div>
  </div>
</nav>

<!-- modal -->

<div class="modal fade" id="myModal">
	<div class="modal-dialog modal-md" style="vertical-align: middle;">
		<div class="modal-content">

			<!-- ModalHeader -->
			<div class="modal-header">
				<h4 class="modal-title">LogIn</h4>
				<button type="button" class="close dataDismiss" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<%@ include file="/WEB-INF/views/user/login.jsp" %>
			</div>

		</div>
	</div>
</div>

</body>
</html>
