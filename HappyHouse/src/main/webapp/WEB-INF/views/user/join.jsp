<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>회원가입</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

</head>
<body>

<!-- Navbar (sit on top) -->
<%@ include file="/WEB-INF/views/form/nav.jsp"%>

<div class="container" align="center" style="margin-top: 90px;margin-bottom: 90px;">
	<div class="col-lg-6" align="center">
		<form>
			<div class="form-group" align="left">
				<label for="name">이름 (* 필수입력 항목)</label>
				<input type="text" class="form-control" id="usernameInput" name="username" placeholder="">
			</div>
			<div class="form-group" align="left">
				<label for="">아이디 (* 필수입력 항목)</label>
				<input type="text" class="form-control" id="useridInput" name="userid" placeholder="">
			</div>
			<div class="form-group" align="left">
				<label for="userpwd">비밀번호 (* 필수입력 항목)<span id="pwd_chk_res" class="text-danger"></span></label>
				<input type="password" class="form-control" id="userpwdInput" name="userpwd" placeholder="">
			</div>
			<div class="form-group" align="left">
				<label for="pwdcheck">비밀번호 확인 (* 필수입력 항목)</label>
				<input type="password" class="form-control" id="pwdcheckInput" name="pwdcheck" placeholder="">
			</div>
			<div class="form-group" align="left">
				<label for="">닉네임</label>
				<input type="text" class="form-control" id="nicknameInput" name="nickname" placeholder="">
			</div>
			<div class="form-group" align="left">
				<label for="">이메일</label><br>
				<div id="email" class="custom-control-inline">
				<input type="text" class="form-control" id="emailidInput" name="emailid" placeholder="" size="25"> @
				<select class="form-control" id="emaildomainInput" name="emaildomain">
					<option value="naver.com">naver.com</option>
					<option value="google.com">google.com</option>
					<option value="daum.net">daum.net</option>
					<option value="nate.com">nate.com</option>
					<option value="hanmail.net">hanmail.net</option>
				</select>
				</div>
			</div>
			<!-- <div class="form-group" align="left">
				<label for="tel">전화번호</label>
				<div id="tel" class="custom-control-inline">
				<select class="form-control" id="tel1" name="tel1">
					<option value="010">010</option>
					<option value="02">02</option>
					<option value="031">031</option>
					<option value="032">032</option>
					<option value="041">041</option>
					<option value="051">051</option>
					<option value="061">061</option>
				</select> _
				<input type="text" class="form-control" id="tel2" name="tel2" placeholder=""> _
				<input type="text" class="form-control" id="tel3" name="tel3" placeholder="">
				</div>
			</div> -->
			<div class="form-group" align="left">
				<label for="">주소</label><br>
				<!-- <div id="addressdiv" class="custom-control-inline">
					<input type="text" class="form-control" id="zipcode" name="zipcode" placeholder="우편번호" size="7" maxlength="5" readonly="readonly">
					<button type="button" class="btn btn-primary" onclick="javascript:">우편번호</button>
				</div> -->
				<input type="text" class="form-control" id="addressInput" name="address" placeholder="">
				<input type="text" class="form-control" id="addressDetailInput" name="address_detail" placeholder="">
			</div>
			<div class="form-group" align="left">
				<label for="">취미</label>
				<input type="text" class="form-control" id="hobbyInput" name="hobby" placeholder="">
			</div>
			<div class="form-group" align="left">
				<label for="">홈페이지</label>
				<input type="text" class="form-control" id="homepageInput" name="homepage" placeholder="">
			</div>
			<div class="form-group" align="center">
				<button type="button" class="btn btn-primary" id="registerBtn">회원가입</button>
				<button type="reset" class="btn btn-warning">초기화</button>
			</div>
		</form>
	</div>
</div>

<div id="zipModal" class="modal fade" role="dialog">
<h5 class="modal-title" id="myModalLabel">우편번호검색</h5>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header text-center">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>    
            <div class="modal-body text-center">
            	<form id = "zip_codeForm">
            		<div align="center">
            			<label>도로명 주소검색</label>
            		</div>
					<div class="input-group" align="left">
						<input type="text" class="form-control" id="doro" name="doro" placeholder="검색 할 도로명 입력(예: 대왕판교로, 학하서로)">
						<span class="input-group-btn">
						<input type="submit" class="btn btn-warning" value="검색" id="searchBtn">
						</span>
					</div>
                </form>
                <div style="width:100%; height:200px; overflow:auto">
                	<table class = "table text-center">
                		<thead>
                		<tr>
                			<th style="width:150px;">우편번호</th>
                			<th style="width:600px;">주소</th>
                		</tr>
                		</thead>
                		<tbody id="zip_codeList"></tbody>
                	</table>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("#pwdcheckInput").change(function(){
			$("#pwd_chk_res").text("");
			if($("#pwdcheckInput").val() == '') {
				alert("패스워드를 확인해주세요.");
				return;
			}
			if($("#userpwdInput").val() != $("#pwdcheckInput").val()) {
				$("#pwd_chk_res").text(" 패스워드가 일치하지 않습니다.");
				$("#pwdcheckInput").val('');
			}
		});//change
		
		$("#registerBtn").click(function() {
			if($("#usernameInput").val() == "") {
				alert("이름 입력!!!");
				return;
			} else if($("#useridInput").val() == "") {
				alert("아이디 입력!!!");
				return;
			} else if($("#userpwdInput").val() == "") {
				alert("비밀번호 입력!!!");
				return;
			} else if($("#userpwdInput").val() != $("#pwdcheckInput").val()) {
				alert("비밀번호 확인!!!");
				return;
			} else {
				join();
			}
		});
		
		$('#zipcode').focusin(function() {
			$('#zipModal').modal();
		});
	});
	
	function join() {
		
		var user = { 
				id : $("#useridInput").val(),
				pw : $("#userpwdInput").val(),
				name : $("#usernameInput").val(),
				nickname : $("#nicknameInput").val(),
				email : $("#emailidInput").val() + "@" + $("#emaildomainInput").val(),
				homepage : $("#homepageInput").val(),
				address : $("#addressInput").val() + " " + $("#addressDetailInput").val(),
				hobby : $("#hobbyInput").val()
		};
		
		$.ajax({
	        type : 'post',
	        url : '<%=contextPath%>/join',
	        dataType : 'json',
	        data : JSON.stringify( user ),
	        contentType : 'application/json',
	        success : function(data, status, xhr) { 
				alert("회원가입 완료");
				location.href = "/";
	        }, 
	        error: function(jqXHR, textStatus, errorThrown) { 
	        	console.log(jqXHR.responseText); 
	        }
		});
	}
</script>

</body>
</html>