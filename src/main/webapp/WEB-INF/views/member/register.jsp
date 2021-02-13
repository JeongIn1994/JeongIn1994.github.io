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
		<div class='border border-top-0 border-left-0 border-right-0'
			style="margin-bottom: 30px">
			<h2>Create New Account</h2>
			<p>Please, Input Your Information ! 
			<mark style="color: red">'*'Mark Must Input Category</mark></p>
		</div>

		<div class='border border-top-0 border-left-0 border-right-0'style="margin-bottom: 30px">
			<form action="/member/register" method="post" >
				<div class="form-group">
					<label for="usr">* Name : </label>
  					<input type="text" id="userName" name='userName' placeholder="At least 8 characters Maximum 14 characters">
				</div>
				<div class="form-group">
					<label for="usr">* ID : </label>
  					<input type="text" id="userID" name='userID' placeholder="At least 8 characters Maximum 14 characters">					
				</div>
				<div class="form-group">
					<label for="usr">* Password : </label>
  					<input type="password" id="userpw" name='userpw' placeholder="At least 8 characters Maximum 14 characters">					
				</div>				
				
			<!-- 주소와 우편번호를 입력할 <input>들을 생성하고 적당한 name과 class를 부여한다 -->
				<div class='form-group'>
					<label for="usr">* address : </label>
					<input type="text" name="addNum" class="postcodify_postcode5" value="" readonly />
					<button id="postcodify_search_button">검색</button><br/> 
					<input type="text" name="add1" class="postcodify_address"value=" " readonly /><br/>
					<input type="text" name="add2"class="postcodify_details" value="" /><br />
					<input type='hidden' name='address'> 			
				</div>
				</form>
		</div>
			<!-- jQuery와 Postcodify를 로딩한다 -->
			<div class="progress">
				<div class="progress-bar" style="width: 70%">2/3</div>
			</div>
		
		<!-- "검색" 단추를 누르면 팝업 레이어가 열리도록 설정한다 -->
	</div>
	<%@include file="../include/footer.jsp"%>
	<script>
		$(function() {
			
			$('#postcodify_search_button').on('click',function(e){
				
				e.preventDefault();
				$("#postcodify_search_button").postcodifyPopUp();
				
			})
			
			
			
		});
	</script>
	<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
	<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
</body>
</html>