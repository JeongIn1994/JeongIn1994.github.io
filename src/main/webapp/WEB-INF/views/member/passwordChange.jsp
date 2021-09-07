<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">	
<title>Insert title here</title>
</head>
<body>
	<div class='container'>
		<hr>
			<h2>Password Change</h2>
		<hr>
		<form action="/member/passwordChange" method="post" role='form'>
			<span>New Password</span>
			<input type='password' name='userpw' id='userpw'>
			<div><span id='pwFormSpan'></span></div>
			<span>New Password Check</span>
			<input type='password'  id ='pwChk'>
			<div><span id='pwChkSpan'></span></div>
			<input type="hidden" name="${_csrf.parameterName }"  value="${_csrf.token }">
			<button type='button' class='btn btn-primary submit'>Password Change</button>
		</form>
	</div>
</body>
<script>
	$(document).ready(function(e){
		var pwRegExp = /^[A-Za-z0-9~!@#$%^&*()_+|<>?:{}]{8,16}$/
		var passwordExpCheck,passwordEqualCheck = false;
		var formObj = $("form[role='form']");
		
		$('.submit').hide();
		//password Exp Check
		$('#userpw').change(function(e){
				
				if(!pwRegExp.test($('#userpw').val())){
					$('#pwFormSpan').html('<p style="color : red;"><i class="fa fa-ban" aria-hidden="true">Check Password Condition!</i></p>');
					return;
				}else{
				$('#pwFormSpan').html('<p style="color : green;"><i class="fa fa-check" aria-hidden="true">You Can use This Password</i></p>');
				passwordExpCheck=true;
				}
			});
		//password Equal Check
		$('#pwChk').change(function(e){
			
			if($('#userpw').val() == $('#pwChk').val()){
				$('#pwChkSpan').html('<p style="color : green;"><i class="fa fa-check" aria-hidden="true">Password is the Same</i></p>')
				
				passwordEqualCheck = true;
				$('.submit').show();
			}else{
		
			$('#pwChkSpan').html('<p style="color : red;"><i class="fa fa-ban" aria-hidden="true">The password is different !!</i></p>');
			passwordEqualCheck = false;
			$('.submit').hide();
			}
		});
		$('.submit').on('click',function(e){
			e.preventDefault();
			var hiddenTag = "<input type='hidden' name='userid' value='${member.userid}'>"
			formObj.append(hiddenTag).submit();
			alert('Change Success!');
			window.close();
		})
	})
</script>
</html>