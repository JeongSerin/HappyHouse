<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<html>
<title>Happy House</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<header class="w3-display-container w3-content w3-wide"
	style="max-width: 1500px;" id="home">
	<img class="w3-image" src="/img/cityview.png" alt="Architecture"
		width="1500" style="margin-top:50px;">
	<div class="w3-display-middle w3-margin-top w3-center">
		<h1 class="w3-xxlarge w3-text-white">
			<span class="w3-padding w3-white w3-opacity-min"><b>Happy</b></span>
			<span class="w3-hide-small w3-text-light-grey">House</span>
		</h1>
	</div>
</header>
<body>
	<!-- Navbar (sit on top) -->
	<%@ include file="/WEB-INF/views/form/nav.jsp"%>
	
	<section class="main-container" align="left" style="margin-top: 50px;margin-bottom: 90px;">
		<div class="container">
			<div class="row">
				<aside class="col-lg-3 order-lg-1">
					<div class="sidebar">
						<div class="block clearfix">
							<c:if test="${dongs.size()  ne null  }">
								<h3 class="title">관심 지역 목록</h3>
								<a href="${root}/user/favRegist.jsp" >관심 지역 등록</a>
								<div class="media margin-clear" style="margin-top: 10px;">
									<c:forEach var="dong" items="${dongs}">
										<ul style="border-style: outset;margin-right: 10px;">
											<li class="media">
												<div class="media-body"
													style="white-space: nowrap; margin: 20px;">
													<h5 class="mt-0 mb-1">${dong}</h5>
													<a href="fav.do?act=searchEnv&dong=${dong}">환경 점검 정보</a><br>
													<a href="fav.do?act=searhComm&dong=${dong}">업종 정보</a><br>
													<a href="fav.do?act=delete&dong=${dong}&id=${userinfo.id}" class="btn btn-warnning btn-sm"><i class="fa fa-user pr-2"></i>삭제</a>
												</div>
											</li>
										</ul>
									</c:forEach>
								</div>
							</c:if>
						</div>
					</div>
					<div class="block clearfix" id="houseInfo"></div>
				</aside>
				<!-- sidebar end -->
			</div>
		</div>
		<c:if test="${envInfos ne null }">
			<div class="container">
				<h2 class="title" style="margin-top:20px;">${envInfos[0].dong} 환경점검정보</h2>
				<div class="media margin-clear" >
					<table class="table">
						<thead>
							<tr>
								<th>이름</th>
								<th>주소</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="envInfo" items="${envInfos}">
								<tr>
									<td>${envInfo.name}</td>
									<td>${envInfo.address}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</c:if>
		<c:if test="${commInfos ne null  }">
			<div class="container">
					<h2 class="title" style="margin-top:20px;">${commInfos[0].dong} 상권정보</h2>
				<div class="media margin-clear">
					<table class="table">
						<thead>
							<tr>
								<th>정보</th>
							</tr>
							<c:forEach var="commInfo" items="${commInfos}">
								<tr>
									<td>${commInfo}</td>
								</tr>
							</c:forEach>
						</thead>
						<tbody>

						</tbody>
					</table>
				</div>
			</div>
		</c:if>
	</section>
</body>

</html>