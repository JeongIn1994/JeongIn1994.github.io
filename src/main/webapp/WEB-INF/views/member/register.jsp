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
				<div class="form-group" >
					<label for="usr">* Name : &emsp;&emsp;&emsp;&emsp;&emsp; </label> 
					<input type="text" id="userName" name='userName' placeholder="At least 4 characters Maximum 14 characters" size="45">
					<div><span id='nameFormSpan'></span></div>
				</div>
				<!-- Id Input -->
				<div class="form-group">
					<label for="usr">* ID : &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&ensp;</label> 
					<input type="text" id="userID" name='userid' placeholder="At least 6 characters Maximum 12 characters" size="45">
					<button name='idChk'>Check</button>
					<div><span id='idFormSpan'></span></div>
				</div>
				<!-- Pw Input -->
				<div class="form-group">
					<label for="usr">* Password :&emsp;&emsp;&emsp;&ensp; </label> 
					<input type="password" id="userpw" name='userpw' placeholder="At least 8 characters Maximum 16 characters" size="45">
					<div><span id='pwFormSpan'></span></div>
				</div>
				<div class="form-group">
					<label for="usr">* Password Check :&ensp; </label> 
					<input type="password" id="pwChk" placeholder="Input Password One More Time" size="45">
					<div><span id='pwChkSpan'></span></div>
				</div>				
				<!-- Address Input -->
				<div class="form-group">
					<label for="usr">Address : </label> 
					<!-- 검색 기능을 표시할 <div>를 생성한다 -->
					<div id="postcodify"></div>
					<!-- 주소와 우편번호를 입력할 <input>들을 생성하고 name과 id를 부여한다 -->
					<div style="padding-bottom: 5px">&nbsp; Post Number : &ensp;&nbsp;
						<input type="text" id="postcode" value="" readonly size="10" placeholder="Postcode"/>
					</div>
					<div style="padding-bottom: 5px">&nbsp; address : &emsp;&emsp;&emsp;&nbsp;
						<input type="text" id="addr" value="" readonly size="50" placeholder="Default Address"/>
					</div>
					<div style="padding-bottom: 5px">&nbsp; Detail Address : &nbsp;
						<input type="text"  id="details" value="" size="75" placeholder="Detailed Address"/>
					</div>
					<div style="padding-bottom: 5px">&nbsp; Extra Info : &ensp;&emsp;&emsp;
						<input type="text" id="extra_info" value="" readonly size="75" placeholder="Extra Infomaion"/>
					</div>
					<!-- postcode + addr + details -->
					<input type='hidden' name='address' value=''>
				</div>
				<!-- Address End -->
				<div class="form-group">
					<label for="usr">PhoneNumber : </label> 
					<select name = 'firstNumber'>
						<option value="---" selected >---</option>
						<option value='010'>010)</option>
						<option value='019'>019)</option>
						<option value='011'>011)</option>
					</select>
					<input type='text' name = 'secondNumber' size = '4'>
					<span>-</span>
					<input type='text' name = 'finalNumber' size = '4'>
					
					<input type='hidden' name= 'phoneNumber' value=''>
				</div>
				<div class="form-group">
					<label for="usr">E-Mail : </label> 
					<input type="text" name='email' id='email' size='30' placeholder="example@mail.com">
					<button name='emailAuthBtn'>Authentication Number Send</button>
				</div>				
				<div class="form-group authNum">
					<label for="usr">Authentication Number : </label> 
					<input type="text" name='emailChk' size='30' placeholder="Input Authentication Number">
					<button name='emailAuthChkBtn'>Authentication Number Check</button>
				</div>
				<div><span id="emailAuthChk"></span></div>
				<button type='submit' class='btn btn-primary submit'>Submit</button>
				<button type='button' class='btn btn-danger cancel' onclick='location.href="/";'>Cancel</button>
				<input type="hidden" name="${_csrf.parameterName }"  value="${_csrf.token }">
			</form>
			<div><span id='msg'></span></div>
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
			$('.authNum').hide();
			
			//Validation variables
			var nameRegExp = /^[A-Za-z0-9]{4,14}$/;
			var idRegExp = /^[A-Za-z0-9]{6,12}$/;
			var pwRegExp = /^[A-Za-z0-9~!@#$%^&*()_+|<>?:{}]{8,16}$/
			var nameChk = false;
			var idChk = false;
			var pwChk = false;
			var emailChk = false;
			
			//email auth code
			var code ="";
			
			
			//email btn onclick			
			$('button[name="emailAuthBtn"]').on('click',function(e){
				var email = $('#email').val();
				e.preventDefault();
				$.ajax({
					type : 'get',
					url : '/member/emailChk?email='+ email,
					success:function(data){
						$('.authNum').show();
						code = data;
						
					}
				
				})
			})
			$('button[name="emailAuthChkBtn"]').on('click',function(e){
				e.preventDefault();
				var inputNum = $('input[name="emailChk"]').val();
				if(inputNum == code){
					$('#emailAuthChk').html('<p style="color : green"><i class="fa fa-check" aria-hidden="true">correspond to Auth Code ! </i></p>')
					emailChk = true;
				}else{
					$('#emailAuthChk').html('<p style="color : red"><i class="fa fa-ban	" aria-hidden="true">Not correspond to Auth Code ! </i></p>')
					emailChk = false;
				}
			})
			
			//#########RegExp Check#############
			//name RegExp check
			$('#userName').change(function(e){
				
				if(!nameRegExp.test($('#userName').val())){
					$('#nameFormSpan').html('<p style="color : red;"><i class="fa fa-ban" aria-hidden="true">Check Name Condition!</i></p>');
					return;
				}
				$('#nameFormSpan').html('<p style="color : green;"><i class="fa fa-check" aria-hidden="true">You Can use This Name</i></p>');
				nameChk=true;
				
			});			
			
			//pw RegExp check
			$('#userpw').change(function(e){
				
				if(!pwRegExp.test($('#userpw').val())){
					$('#pwFormSpan').html('<p style="color : red;"><i class="fa fa-ban" aria-hidden="true">Check Password Condition!</i></p>');
					return;
				}else{
				$('#pwFormSpan').html('<p style="color : green;"><i class="fa fa-check" aria-hidden="true">You Can use This Password</i></p>');
				pwChk=true;
				}
			});
			//pw check
			$('#pwChk').change(function(e){
				
				if($('#userpw').val() == $('#pwChk').val()){
					$('#pwChkSpan').html('<p style="color : green;"><i class="fa fa-check" aria-hidden="true">Password is the Same</i></p>')
					
					pwChk = true;
				}else{
			
				$('#pwChkSpan').html('<p style="color : red;"><i class="fa fa-ban" aria-hidden="true">The password is different !!</i></p>');
				pwChk = false;
				}
			});
			
			
			//#############RegExp Check End############
			
			//onclick submit button
			$("button[type='submit']").on('click',function(e){
				
				e.preventDefault();
				//address combination
				var address = $('#postcode').val() + $('#addr').val() + $('#details').val();
				$('input[name="address"]').val(address);	
				
				//phonenumber combination
				var phoneNumber = $('select[name="firstNumber"] option:selected').val() + $('input[name="secondNumber"]').val() + $('input[name="finalNumber"]').val();
				$('input[name="phoneNumber"]').val(phoneNumber);
				
				//when 
				if(!nameChk){					
					$('#userName').select();
					$('#msg').html('<p style="color : red;"><i class="fa fa-ban" aria-hidden="true">Name Condition Not Met </i></p>')
					return;
				}
				if(!idChk){
					$('#userID').select();
					$('#msg').html('<p style="color : red;"><i class="fa fa-ban" aria-hidden="true">ID Condition Not Met </i></p>')
					return;
				}
				if(!pwChk){
					$('#userpw').select();
					$('#msg').html('<p style="color : red;"><i class="fa fa-ban" aria-hidden="true">Password Condition Not Met </i></p>')
					return;
				}
				
				
				formObj.submit();
			});
			
			
			//ajax id check
			$('button[name="idChk"]').on('click',function(e,error){
				
				e.preventDefault();
				var userid = $('input[name="userid"]').val();
				if(!idRegExp.test(userid)){
					$('#idFormSpan').html('<p style="color : red;"><i class="fa fa-ban" aria-hidden="true">Check ID Condition!</i></p>');
					idChk = false;
				}else{
					//user id duplication check
					$.getJSON("/member/checkId/" + userid+".json",
							function(data){
								console.log(Object.keys(data).length);
								//when userid already exist
								if(Object.keys(data).length>0){
									$('#idFormSpan').html('<p style="color : red;"><i class="fa fa-ban" aria-hidden="true">This Id Is Already Exist !</i></p>');
									idChk = false;									
								}												
							
							}).fail(function(xhr,status,err){
								if(error){
									console.log(error);
								}
							});//fail end
					//whem user id not exist	
					$('#idFormSpan').html('<p style="color : green;"><i class="fa fa-check" aria-hidden="true">You Can use This ID</i></p>');
					idChk = true;
				}//else end

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