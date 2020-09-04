<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%	
	HttpSession httpSession = request.getSession(true);
	UserDto user = (UserDto) httpSession.getAttribute("userinfo");
%>

<c:set var="root" value="${pageContext.request.contextPath}" />

<%--
<c:if test="${userinfo == null}">
	<c:redirect url="/main.do"/>
</c:if>
<c:if test="${userinfo != null}">
--%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>공지사항</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

	<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/alertify.min.js"></script>
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/css/alertify.min.css"/>
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/css/themes/default.min.css"/>
	
	<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<script type="text/javascript">
var thisno;
// 공지사항 목록
function list(){
	$.ajax(
	{
        type : 'get',
        url : '/happyhouse/noticeList',
        dataType : 'json',
        data : 
		{
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

	$("#tbodyNoticeList").html("");

	for( var i=0; i<list.length; i++){
		
		var noticeno = list[i].noticeno;
		var id = list[i].id;
		var subject = list[i].subject;
		var content = list[i].content;
		var regtime = list[i].regtime;
		
		var listHtml =
			'<tr style="cursor:pointer" data-id=' + noticeno +'><td>' + noticeno + '</td><td>' + subject + '</td><td>' + id +  '</td><td>' + regtime + '</td></tr>';

		$("#tbodyNoticeList").append(listHtml);
	}
	makeListHtmlEventHandler();
}	// 공지사항 목록


// 상세보기
function makeListHtmlEventHandler(){
	$("#tbodyNoticeList tr").click(function(){
		var noticeno = $(this).attr("data-id");
		thisno = noticeno;
		detail(noticeno);
	});
}

function detail(noticeno){
	
	$.ajax(
	{
        type : 'get',
        url : '/happyhouse/noticeDetail/' + noticeno,
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
	
	var noticeno = detail.noticeno;
	var id = detail.id;
	var subject = detail.subject;
	var content = detail.content;
	var regtime = detail.regtime;
	
	$("#noticenoDetail").html(noticeno);
	$("#idDetail").html(id);
	$("#subjectDetail").html(subject);
	$("#contentDetail").html(content);
	$("#regtimeDetail").html(regtime);
	
	$("#boardDetailModal").modal("show");

}// 상세보기


// 글쓰기
function noticeWrite(){
	
	$.ajax(
	{
        type : 'post',
        url : '/happyhouse/noticeWrite',
        dataType : 'json',
        data : 
		{
        	id: $("#userinfoId").val(),
        	subject: $("#subjectInsert").val(),
			content: $("#contentInsert").val(),
		},
        success : function(data, status, xhr) { 
        	list();
        }, 
        error: function(jqXHR, textStatus, errorThrown) 
        { 
        	console.log(jqXHR.responseText); 
        }
        
    });
}//글쓰기

// 삭제
function deleteNotice(noticeno){
	
	$.ajax(
	{
        type : 'delete',
        url : '/happyhouse/noticeDelete/' + noticeno,
        dataType : 'json',
        data : 
		{
		},
        success : function(data, status, xhr) { 
        	list();
			alert("삭제되었습니다");
        }, 
        error: function(jqXHR, textStatus, errorThrown) 
        { 
        	console.log(jqXHR.responseText); 
        }
    });
}


// 수정
function updateNotice(noticeno){
		
	var notice = { noticeno:noticeno, subject:$("#subjectUpdate").val(), content: $("#contentUpdate").val() };
		
	$.ajax(
	{
		type : 'put',
		url : '/happyhouse/noticeUpdate/' + noticeno,
		dataType : 'json',
		data : JSON.stringify(notice),
		contentType : 'application/json',
		success : function(data, status, xhr) { 
	        alert("수정되었습니다.");
			list();
		}, 
		error: function(jqXHR, textStatus, errorThrown) 
		{ 
			console.log(jqXHR.responseText); 
		}
	});
}


function searchNotice() {
	var temp = document.getElementById('word').value;
	if (document.getElementById("word").value == "") {
		list();
	}
	if (document.getElementById("key").value == "noticeno") {
		if (isNaN(temp) == true) {
			alert("숫자를 입력해주세요");
			return;
		}
		else {
			$.ajax(
				{
			        type : 'get',
			        url : '/noticeSearchNo/' + temp,
			        dataType : 'json',
			        data : 
					{
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
	}
	if (document.getElementById("key").value == "subject"){
		$.ajax(
				{
			        type : 'get',
			        url : '/happyhouse/noticeSearchSubject/' + temp,
			        dataType : 'json',
			        data : 
					{
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
	if (document.getElementById("key").value == "content"){
		$.ajax(
				{
			        type : 'get',
			        url : '/happyhouse/noticeSearchContent/' + temp,
			        dataType : 'json',
			        data : 
					{
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

}


function registFav() {
	if ($("#dong option:selected").val() == "all") {
		alert("동을 선택해주세요");
		return;
	}
	document.getElementById("dongform").action = "${root}/fav.do";
	document.getElementById("dongform").submit();
}

$(document).ready(function() {
	
	list();
	
	//insert
	$("#btnwrite").click(function(){
		clear();
		$("#boardInsertModal").modal("show");
	});
	
	$("#btnBoardInsert").click(function(){
		noticeWrite()
	});
	
	//update
	$("#btnBoardUpdateForm").click(function(){
		$("#boardUpdateModal").modal("show");
	});
	$("#btnBoardUpdate").click(function(){
		updateNotice(thisno);
	});
	
	//delete
	$("#btnBoardDeleteConfirm").click(function(){
		deleteNotice(thisno);
	});
	
	
	// search
	$("#btnSearch").click(function(){
		searchNotice();
	});

});

function clear(){
	$("#subjectInsert").val("");
	$("#contentInsert").val("");
}
	
</script>
</head>

<body>

	<!-- Navbar (sit on top) -->
	<%@ include file="/WEB-INF/views/form/nav.jsp"%>
	
	<input id="userinfoId" type="text" value="<%= user.getId() %>" >
	
	<div class="container" align="center" style="margin-top: 90px;margin-bottom: 90px;">
		<div class="col-lg-10" align="center">
			<h2>공지사항</h2>
			<c:if test="${userinfo.isAdmin == 1}">
				<table class="table table-borderless">
					<tr>
						<td align="right"><button type="button" class="btn btn-link"
								id="btnwrite">글쓰기</button></td>
					</tr>

				</table>
			</c:if>
			<form id="searchform" method="get" class="form-inline" action="">
				<input type="hidden" name="act" id="act" value="search">
				<table class="table table-borderless">
					<tr>
						<td align="right"><select class="form-control" name="key"
							id="key">
								<option value="noticeno" selected="selected">글번호</option>
								<option value="subject">제목</option>
								<option value="content">내용</option>
						</select> <input type="text" class="form-control" placeholder="검색어 입력."
							name="word" id="word">
							<button type="button" class="btn btn-primary"
								id="btnSearch">검색</button></td>
					</tr>
					
				</table>
			</form>
			<table class="w3-table w3-bordered w3-hoverable">
				<thead>
					<tr>
						<th width="80px">번 호</th>
						<th width='50%'>제 목</th>
						<th>작 성 자</th>
					</tr>
						<tbody id="tbodyNoticeList">
					
						</tbody>
				</thead>
				<tbody id="boardTbody">
					<c:if test="${notices.size() != 0}">
						<c:forEach var="notice" items="${notices}">
							<tr onclick="javascript:showNotice('${notice.noticeno}')" style="cursor: pointer;text-decoration: none;">
							 	<td><strong>${notice.noticeno}</strong></td>
								<td><strong>${notice.subject}</strong></td>
								<td>작성자 : ${notice.id}(${notice.regtime})</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
			<c:if test="${notices.size() == 0}">
				<table class="table table-active">
					<tbody>
						<tr class="table-info" align="center">
							<td>작성된 글이 없습니다.</td>
						</tr>
					</tbody>
				</table>
			</c:if>
		</div>
	</div>
	
					<!-- Modal insert-->
				<div class="modal fade" id="boardInsertModal">
					<div class="modal-dialog modal-simple">
						<form class="modal-content">
							<!-- Modal Header -->
					      	<div class="modal-header">
					        	<h4 class="modal-title">글쓰기</h4>
					        	<button type="button" class="close" data-dismiss="modal">&times;</button>
					      	</div>
							<div class="modal-body">
								<div class="row">
										
									<div class="col-xl-12 form-group">
										<input id="subjectInsert" type="text" class="form-control" name="title" placeholder="제목">
									</div>
									<div class="col-xl-12 form-group">
										<textarea id="contentInsert" class="form-control" rows="5" placeholder="내용"></textarea>
									</div>

									<div class="col-md-12 float-right">
										<button id="btnBoardInsert" class="btn btn-sm btn-primary btn-outline" data-dismiss="modal" type="button">등록</button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
				<!-- End Modal -->
				
				<!-- Modal detail-->
				<div class="modal fade" id="boardDetailModal">
					<div class="modal-dialog modal-simple">
						<div class="modal-content">
							<!-- Modal Header -->
					      	<div class="modal-header">
					        	<h4 class="modal-title">글 상세</h4>
					        	<button type="button" class="close" data-dismiss="modal">&times;</button>
					      	</div>
					      	
							<div class="modal-body">
							
                  <div class="example table-responsive">
                    <table class="table table-hover">
                      <tbody>
                        <tr><td>글번호</td><td id="noticenoDetail">#</td></tr>
                        <tr><td>제목</td><td id="subjectDetail">#</td></tr>
                        <tr><td>내용</td><td id="contentDetail">#</td></tr>
                        <tr><td>작성자</td><td id="idDetail">#</td></tr>
                        <tr><td>작성일시</td><td id="regtimeDetail">#</td></tr>
                      </tbody>
                    </table>
                  </div>
								<button id="btnBoardUpdateForm" class="btn btn-sm btn-primary btn-outline" data-dismiss="modal" type="button">글 수정하기</button>
								<button id="btnBoardDeleteConfirm" class="btn btn-sm btn-warning btn-outline" data-dismiss="modal" type="button">글 삭제하기</button>

							</div>
						</div>
					</div>
				</div>
				<!-- End Modal -->
				
				<!-- Modal update-->
				<div class="modal fade" id="boardUpdateModal">
					<div class="modal-dialog modal-simple">
						<form class="modal-content">
							<!-- Modal Header -->
					      	<div class="modal-header">
					        	<h4 class="modal-title">글수정</h4>
					        	<button type="button" class="close" data-dismiss="modal">&times;</button>
					      	</div>
							<div class="modal-body">
								<div class="row">
									<div class="col-xl-12 form-group">
										<input id="subjectUpdate" type="text" class="form-control" name="title" placeholder="제목" >
									</div>
									<div class="col-xl-12 form-group">
										<textarea id="contentUpdate" class="form-control" rows="5" placeholder="내용"></textarea>
									</div>
									
									<div class="col-md-12 float-right">
										<button id="btnBoardUpdate" class="btn btn-sm btn-primary btn-outline" data-dismiss="modal" type="button">수정</button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
				<!-- End Modal -->
</body>
</html>