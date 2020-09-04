<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

<style>
.center {
  margin: auto;
  padding: 10px;
  align: right;
}
</style>

<script>
	function registFav() {
		if ($("#sido option:selected").val() == "all") {
			alert("시/도를 선택해주세요");
			return;
		}
		if ($("#gugun option:selected").val() == "all") {
			alert("구/군을 선택해주세요");
			return;
		}
		if ($("#dong option:selected").val() == "all") {
			alert("동을 선택해주세요");
			return;
		}
		document.getElementById("dongform").action = "${root}/fav.do";
		document.getElementById("dongform").submit();
	}
</script>
<script>
$(document).ready(function(){
	$.get("${pageContext.request.contextPath}/FSelectBoxController"
		,{command:"sido"}
		,function(data, status){
			$.each(data, function(index, vo) {
				$("#sido").append("<option value='"+vo.sido_code+"'>"+vo.sido_name+"</option>");
			});//each
		}//function
		, "json"
	);//get
});//ready
$(document).ready(function(){
	$("#sido").change(function() {
		$.get("${pageContext.request.contextPath}/FSelectBoxController"
				,{command:"gugun", sido:$("#sido").val()}
				,function(data, status){
					$("#gugun").empty();
					$("#gugun").append('<option value="all">선택</option>');
					$.each(data, function(index, vo) {
						$("#gugun").append("<option value='"+vo.gugun_code+"'>"+vo.gugun_name+"</option>");
					});//each
				}//function
				, "json"
		);//get
	});//change
	$("#gugun").change(function() {
		$.get("${pageContext.request.contextPath}/FSelectBoxController"
				,{command:"dong", gugun:$("#gugun").val()}
				,function(data, status){
					$("#dong").empty();
					$("#dong").append('<option value="all">선택</option>');
					$.each(data, function(index, vo) {
						$("#dong").append("<option value='"+vo.dong+"'>"+vo.dong+"</option>");
					});//each
				}//function
				, "json"
		);//get
	});//change
	$("#dong").change(function() {
		$.get("${pageContext.request.contextPath}/FSelectBoxController"
				,{command:"apt", dong:$("#dong").val()}
				,function(data, status){
					$("#searchResult").empty();
					$.each(data, function(index, vo) {
						//$("#searchResult").append(vo.dong+" "+vo.AptName+" "+vo.jibun+"<br>");
					});//each
				}//function
				, "json"
		);//get
	});//change
});//ready
</script>

</head>
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

	<div class="main-container" align="left" style="max-width: 70%;margin-left: 70px;margin-bottom: 250px;">

		<!-- HouseDeal Section -->
		<div class="w3-container w3-padding-32 w3-row center">
			<div class="form-block p-30 light-gray-bg border-clear" align="center">
				<form id="dongform" method="post" action="">
					<input type="hidden" name="act" id="act" value="registFav">
					<input type="hidden" name="id" id="id" value="${userinfo.id}">
					<div class="form-group has-feedback row" align="center">
						<h2 class="title">관심 지역</h2>
						<label for="inputPassword"
							class="col-md-3 control-label text-md-right col-form-label">관심
							지역 설정 <span class="text-danger small">*</span>
						</label>
						<div class="col-lg-8">
						
							<div style="margin-top:10px;">
								시도 : <select id="sido">
									<option value="all">선택</option>
								</select>
								구군 : <select id="gugun">
									<option value="all">선택</option>
								</select>
								읍면동 : <select name="dong" id="dong">
									<option value="all">선택</option>
								</select>
							</div>

							<div class="form-group md-1" style="margin-top:20px;">
								<button class="btn btn-group btn-warning btn-animated"
									onclick="javascript:registFav();">
									등록 <i class="fa fa-check"></i>
								</button>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
