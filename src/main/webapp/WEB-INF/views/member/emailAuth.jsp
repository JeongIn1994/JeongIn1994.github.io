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
<title>Password Change</title>
</head>
<body>
<div class='container'>
	<hr>
	<h2>Password Change</h2>
	<hr>
	<p>We can submit Auth Message TO your Email</p>
	<div class="form-group">
		<label for="usr">E-Mail : </label> <input type="text" name='email'
			id='email' size='30' value='${member.email }' disabled>
		<button name='emailAuthBtn'>Authentication Number Send</button>
	</div>
	<div class="form-group authNum">
		<label for="usr">Authentication Number : </label> <input type="text"
			name='emailChk' size='30' placeholder="Input Authentication Number">
		<button name='emailAuthChkBtn'>Authentication Number Check</button>
	</div>
	<div>
		<span id="emailAuthChk"></span>
	</div>
	<button type='button' class='btn btn-primary nextbtn' >Next</button>
	</div>
</body>

<script>
$(document).ready(function(e) {
		$('.authNum').hide();
		$('.nextbtn').hide();
		//email auth button onclick event
		$('button[name="emailAuthBtn"]').on('click',function(e){
			var email = $('#email').val();
			e.preventDefault();
			$.ajax({
				type : 'get',
				url : '/member/emailChk?email='+ email,
				success:function(data){
					$('.authNum').show();
					alert("Auth Message Submit!")
					code = data;					
				}			
			})
		})
		//email auth button onclick event end
		
		//authication number check event
		$('button[name="emailAuthChkBtn"]').on('click',function(e){
				e.preventDefault();
				var inputNum = $('input[name="emailChk"]').val();
				if(inputNum == code){
					$('#emailAuthChk').html('<p style="color : green"><i class="fa fa-check" aria-hidden="true">correspond to Auth Code ! </i></p>')
					$('.nextbtn').show();
				}else{
					$('#emailAuthChk').html('<p style="color : red"><i class="fa fa-ban	" aria-hidden="true">Not correspond to Auth Code ! </i></p>')
				}
			})
		//authication number check event end
		$('.nextbtn').on('click',function(e){
			location.href = '/member/passwordChange?userid=${member.userid}';
		})	
	})
</script>
</html>