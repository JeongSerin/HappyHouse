<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="root" value="${pageContext.request.contextPath}"/>
<c:if test="${cookie.ssafy_id.value ne null}">
	<c:set var="saveid" value="${cookie.ssafy_id.value}"/>
	<c:set var="idck" value=" checked=\"checked\""/>
</c:if>

<!DOCTYPE html>
<html>
<title>Happy House</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
		
<style>
  .w3-border-right {
    width: 100px;
  }
</style>

<body>

<form name="pageform" id="pageform" method="GET" action="">
	<input type="hidden" name="act" id="act" value="housesearch">
	<input type="hidden" name="pg" id="pg" value="">
</form>

<!-- Navbar (sit on top) -->
<%@ include file="/WEB-INF/views/form/nav.jsp"%>

<!-- Header -->

<header class="w3-display-container w3-content w3-wide" style="max-width:1500px;" id="home">
  <img class="w3-image" src="/img/cityview.png" alt="Architecture" width="1500" style="margin-top:50px;">
  <div class="w3-display-middle w3-margin-top w3-center">
    <h1 class="w3-xxlarge w3-text-white"><span class="w3-padding w3-white w3-opacity-min"><b>Happy</b></span> <span class="w3-hide-small w3-text-light-grey">House</span></h1>
  </div>
</header>

<!-- Page content -->

<div class="w3-content w3-padding" style="max-width:1564px">

  <!-- map
  
   -->
  <jsp:include page="/WEB-INF/views/map/mainMap.jsp" />
  <c:if test="${empty search}">
  </c:if>
  
  <!-- 
  <c:if test="${not empty search}">
  <jsp:include page="map/detailMap.jsp" />
  </c:if>
  -->

  <!-- HouseDeal Section -->
  
  <div class="w3-container w3-padding-32 w3-row">
  
  	<div class="w3-col" style="width:350px"><p>아파트 거래 정보</p>
  		<img class="w3-image" id="houseimg" src="/img/그림1.jpg" width="300">
  		<table class="w3-table" style="margin-top: 20px; border-collapse: separate; border-spacing: 5px;">
			<tr>
			  <th class="w3-border-right">주택명</th>
			  <td id="housename"></td>
			</tr>
			<tr>
			  <th class="w3-border-right">거래금액</th>
			  <td id="housedealprice"></td>
			</tr>
			<tr>
			  <th class="w3-border-right">건축연도</th>
			  <td id="housebuildyear"></td>
			</tr>
			<tr>
			  <th class="w3-border-right">전용면적</th>
			  <td id="housearea"></td>
			</tr>
			<tr>
			  <th class="w3-border-right">거래일</th>
			  <td id="housedealdate"></td>
			</tr>
			<tr>
			  <th class="w3-border-right">법정동</th>
			  <td id="housedong"></td>
			</tr>
			<tr>
			  <th class="w3-border-right">지번</th>
			  <td id="housejibun"></td>
			</tr>
		</table>
  	</div>
  	
  	<div class="w3-rest">
  		<h2>아파트 거래 내역 목록</h2>
	  	
	  	<div style="margin-bottom: 20px;">
	  	<form>
	  		
	  		<div style="margin-bottom: 5px;">
		  	  <input type="checkbox" id="aptdeal" name="aptdeal" value="aptdeal" checked><label for="aptdeal" style="cursor: pointer;"> 아파트 매매 </label>
		  	  <input type="checkbox" id="aptrent" name="aptrent" value="aptrent" checked><label for="aptrent" style="cursor: pointer;"> 아파트 전월세 </label>
		  	  <input type="checkbox" id="housedeal" name="housedeal" value="housedeal" checked><label for="housedeal" style="cursor: pointer;"> 다세대, 주택 매매 </label>
		  	  <input type="checkbox" id="houserent" name="houserent" value="houserent" checked><label for="houserent" style="cursor: pointer;"> 다세대, 주택 전월세 </label>
	  		</div>
	  		
	  		<select id="searchsel" name="searchsel" style="cursor: pointer;">
			  <option value="all">--- 전체 ---</option>
			  <option value="dong">법정동</option>
			  <option value="aptname">아파트 이름</option>
			</select>
			
			<input type="text" id="searchtext" name="searchtext">
			
			<select id="sortby" name="sortby" style="cursor: pointer;">
			  <option value="defaultby">— 정렬 —</option>
			  <option value="byDong">법정동</option>
			  <option value="byAptName">아파트 이름</option>
			  <option value="byPrice">거래 가격</option>
			</select>
			
			<select id="sorthow" name="sorthow" style="cursor: pointer;">
			  <option value="defaulthow">— 순서 —</option>
			  <option value="asc">오름차순</option>
			  <option value="desc">내림차순</option>
			</select>
			
			<input type="submit" id="search" value="검색" style="cursor: pointer;">
	  	
	  	</form>
	  	</div>
	  	
	  	<div style="width:100%; height:460px; overflow:auto">
		    <table class="w3-table-all w3-hoverable w3-small" style="border:1px;">
			    <thead>
			      <tr class="w3-lime">
			        <th class="w3-lime" style="position:sticky; top:0;">번호</th>
			        <th class="w3-lime" style="position:sticky; top:0;">법정동</th>
			        <th class="w3-lime" style="position:sticky; top:0;">아파트이름</th>
			        <th class="w3-lime" style="position:sticky; top:0;">거래금액</th>
			        <th class="w3-lime" style="position:sticky; top:0;">거래종류</th>
			      </tr>
			    </thead>
			    
			    <tbody id="deal">
			  	</tbody>
		  	</table>
	  	</div>
	  	<!-- page 출력부분
	  	<table class="w3-table">
		  	<tr>
			  	<td>
			  		${navigation.navigator}
			  	</td>
		  	</tr>
		</table>
		-->
  	</div>
  	
  </div>

<!-- End page content -->
</div>

<!-- Footer -->
<footer class="w3-center w3-black w3-padding-16">
  <p>Made by 김소희 정세린</p>
</footer>
	
</body>



<script type="text/javascript">

$(document).ready(function() {
	
	housedealList();
	
	$("#search").click(function() {
		housedealList();
	});
	
});

function housedealList(){
	$.ajax({
        type : 'post',
        url : '<%=contextPath%>/housedealList',
        dataType : 'json',
        data : 
		{
        	searchsel: $("#searchsel").val(),
        	searchtext: $("#searchtext").val(),
        	sortby: $("#sortby").val(),
        	sorthow: $("#sorthow").val()
		},
        success : function(data, status, xhr) {
        	makeListHtml(data);
        }, 
        error: function(jqXHR, textStatus, errorThrown) 
        { 
        	console.log(jqXHR.responseText); 
        }
	});
}

function makeListHtml(list){
	
	$("#deal").html("");

	for( var i=0; i<list.length; i++){
		
		var no = list[i].no;
		var dong = list[i].dong;
		var aptName = list[i].aptName;
		var dealAmount = list[i].dealAmount;
		var type = list[i].type;
	      
		var listHtml =
			'<tr style="cursor:pointer" data-id=' + no +'><td>' + no + '</td><td>' + dong + '</td><td>' + aptName + '</td><td>' + dealAmount + '</td><td>' + type + '</td></tr>';

		$("#deal").append(listHtml);
	}

	makeListHtmlEventHandler();
}

function makeListHtmlEventHandler(){
	$("#deal tr").click(function(){
		var no = $(this).attr("data-id");
		detail(no);
	});
}

function detail(no){
	$.ajax(
	{
        type : 'get',
        url : '<%=contextPath%>/housedealDetail/' + no,
        dataType : 'json',
        data : 
		{
		},
        success : function(data, status, xhr) {
        	makeDetailHtml(data);
        }, 
        error: function(jqXHR, textStatus, errorThrown) 
        { 
        	console.log(jqXHR.responseText); 
        }
    });
}

function makeDetailHtml(detail){
	$("#housename").empty();
	$("#housedealprice").empty();
	$("#housebuildyear").empty();
	$("#housearea").empty();
	$("#housedealdate").empty();
	$("#housedong").empty();
	$("#housejibun").empty();
	
	var img = detail.img;
	var aptName = detail.aptName;
	var dealAmount = detail.dealAmount;
	var buildYear = detail.buildYear;
	var area = detail.area;
	var dealDate = detail.dealYear + "/" + detail.dealMonth + "/" + detail.dealDay;
	var dong = detail.dong;
	var jibun = detail.jibun;
	
	/*if(img != null) {
		$("#houseimg").attr("src", "/img/" + img);
	} else {
		$("#houseimg").attr("src", "/img/그림1.jpg");
	}*/
	$("#housename").append(aptName);
	$("#housedealprice").append(dealAmount);
	$("#housebuildyear").append(buildYear);
	$("#housearea").append(area);
	$("#housedealdate").append(dealDate);
	$("#housedong").append(dong);
	$("#housejibun").append(jibun);
}

function pageMove(pg) { 
	document.getElementById("pg").value = pg;
	document.getElementById("pageform").action = "${root}/house.do";
	document.getElementById("pageform").submit();
}

</script>
</body>
</html>
