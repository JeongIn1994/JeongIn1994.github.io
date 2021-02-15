<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flower Chest - Account Regist</title>
</head>
<body>
	<%@include file="../include/header.jsp"%>
	<div class='container'>
		<div class='border border-top-0 border-left-0 border-right-0' style="margin-bottom: 30px;">
			<h2>Create New Account</h2>
			<p>
				Please, Input Your Information !
				<mark style="color: red">'*'Mark Must Input Category</mark>
			</p>
		</div>

		<div class='border border-top-0 border-left-0 border-right-0' style="margin-bottom: 30px;padding-bottom: 30px;">
			<form action="/member/register" method="post" role="form">
				<!-- Name Input -->
				<div class="form-group">
					<label for="usr">* Name : </label> 
					<input type="text" id="userName" name='userName' placeholder="At least 8 characters Maximum 14 characters">
				</div>
				<!-- Id Input -->
				<div class="form-group">
					<label for="usr">* ID : </label> 
					<input type="text" id="userID" name='userid' placeholder="At least 8 characters Maximum 14 characters">
				</div>
				<!-- Pw Input -->
				<div class="form-group">
					<label for="usr">* Password : </label> 
					<input type="password" id="userpw" name='userpw' placeholder="At least 8 characters Maximum 14 characters">
				</div>
				<!-- Address Input -->
				<div class="form-group">
					<label for="usr">* Address : </label> 
					<!-- 검색 기능을 표시할 <div>를 생성한다 -->
					<div id="postcodify"></div>
					<!-- 주소와 우편번호를 입력할 <input>들을 생성하고 name과 id를 부여한다 -->
					<div>&nbsp; Post Number : 
						<input type="text" id="postcode" value="" readonly size="10"/>
					</div>
					<div>&nbsp; address : 
						<input type="text" id="addr" value="" readonly size="50"/>
					</div>
					<div>&nbsp; Detail Address :  
						<input type="text"  id="details" value="" size="75"/>
					</div>
					<div>&nbsp; Extra Info : 
						<input type="text" id="extra_info" value="" readonly size="75"/>
					</div>
					<!-- postcode + addr + details -->
					<input type='hidden' name='address' value=''>
				</div>
				<!-- Address End -->
				<div class="form-group">
					<label for="usr">* PhoneNumber : </label> 
					<input type="text" name='phoneNumber' size="18"/>
				</div>
				<button class='btn btn-primary submit'>Submit</button>
				<button class='btn btn-danger cancel'>Cancel</button>
				<input type="hidden" name="${_csrf.parameterName }"  value="${_csrf.token }">
			</form>
		</div>

		<div class="progress">
			<div class="progress-bar" style="width: 70%">2/3</div>
		</div>

		<!-- "검색" 단추를 누르면 팝업 레이어가 열리도록 설정한다 -->
	</div>
	<%@include file="../include/footer.jsp"%>

	<!-- 위에서 생성한 <div>에 검색 기능을 표시하고, 결과를 입력할 <input>들과 연동한다 -->
	<script>
		$(function() {
			
			var formObj = $("form[role='form']");
			
			//onclick submit button
			$('.submit').on('click',function(e){
				
				e.preventDefault();
				var address = $('#postcode').val() + $('#addr').val() + $('#details').val();
				$('input[name="address"]').val(address);				
				
				formObj.submit();
			})
			//ajax address search
			$("#postcodify").postcodify({
				insertPostcode5 : "#postcode",
				insertAddress : "#addr",
				insertDetails : "#details",
				insertExtraInfo : "#extra_info",
				hideOldAddresses : false
			});
		});
	</script>
	<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
</body>
</html>