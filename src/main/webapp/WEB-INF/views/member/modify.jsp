<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
.container {
	border: 1px solid gray;
	margin: 3px;
}

.inputForm {
	border: 1px solid gray;
	border-radius: 5px 5px 5px 5px;
}
</style>
</head>
<body>
	<%@include file="../include/header.jsp"%>
	<div class="container" style='padding:5px'>
		<hr>
		<p>
		<h2>${member.userid }'sInformation</h2>
		<mark style="color: red">'*'Mark Must Input Category</mark>
		<hr>
		<form action='/member/modifyWithNotPassword' method="post" role='form'>
			<table class="table table-striped">
				<tbody>
					<tr>
						<td>Name *</td>
						<td><input type='text' name='userName' class="inputForm userName" 
							value='<c:out value="${member.userName }"/>'><div><span id='nameFormSpan'></span></div></td>						
					</tr>
					<tr>
						<td>Address</td>
						<td>
							<div id="postcodify"></div> <!-- 주소와 우편번호를 입력할 <input>들을 생성하고 name과 id를 부여한다 -->
							<div style="padding-bottom: 5px">
								&nbsp; Post Number : &ensp;&nbsp; <input type="text"
									id="postcode" value="" readonly size="10"
									placeholder="Postcode" />
							</div>
							<div style="padding-bottom: 5px">
								&nbsp; address : &emsp;&emsp;&emsp;&nbsp; <input type="text"
									id="addr" value="" readonly size="50"
									placeholder="Default Address" />
							</div>
							<div style="padding-bottom: 5px">
								&nbsp; Detail Address : &nbsp; <input type="text" id="details"
									value="" size="75" placeholder="Detailed Address" />
							</div>
							<div style="padding-bottom: 5px">
								&nbsp; Extra Info : &ensp;&emsp;&emsp; <input type="text"
									id="extra_info" value="" readonly size="75"
									placeholder="Extra Infomaion" />
							</div> <!-- postcode + addr + details --> <input type='hidden'
							name='address' value=''>
						</td>
					</tr>
					<tr>
						<td>PhoneNumber *</td>
						<td><select name = 'firstNumber'>
						<option id='default'value="---" selected >---</option>
						<option id='010' value='010'>010)</option>
						<option id='019' value='019'>019)</option>
						<option id='011' value='011'>011)</option>
					</select>
					<input type='text' name = 'secondNumber' size = '4'>
					<span>-</span>
					<input type='text' name = 'finalNumber' size = '4'>
					
					<input type='hidden' name= 'phoneNumber' value='<c:out value="${member.phoneNumber }"/>'></td>
					</tr>
					<tr>
						<td>Email *</td>
						<td><input type='text' name='email' class="inputForm"
							value='<c:out value="${member.email }"/>' disabled></td>
					</tr>
				</tbody>
			</table>
			<button class='btn btn-primary submit' >Modify</button>
			<button class='btn btn-danger cancel' >Cancel</button>
			<input type="hidden" name="${_csrf.parameterName }"  value="${_csrf.token }">
		</form>
	</div>
	<%@include file="../include/footer.jsp"%>
	<script>
		document.title = '<c:out value="${member.userid  }"/>';
		$(document).ready(function(e) {
			$('.submit').hide();
			var nameRegExp = /^[A-Za-z0-9]{4,14}$/;
			
			//user's phoneNumber Read And Split input
			var phoneNumber = $('input[name="phoneNumber"]').val();
			var phoneNumberArr = phoneNumber.split("-");
			if(phoneNumberArr[0]=='010'){
				$("option:selected").removeAttr("selected");
				$("#010").prop("selected",true);
			}else if(phoneNumberArr[0]=='019'){
				$("option:selected").removeAttr("selected");
				$("#019").prop("selected",true);
			}else if(phoneNumberArr[0]=='011'){
				$("option:selected").removeAttr("selected");
				$("#011").prop("selected",true);
			}else{
				
			}
			$('input[name="secondNumber"]').val(phoneNumberArr[1]);
			$('input[name="finalNumber"]').val(phoneNumberArr[2]);
			//user's phoneNumber Read And Split input End
			//postnumber API
			$("#postcodify").postcodify({
				insertPostcode5 : "#postcode",
				insertAddress : "#addr",
				insertDetails : "#details",
				insertExtraInfo : "#extra_info",
				hideOldAddresses : false
			});
			
			//username Exp Check
			$('.userName').change(function(e){
				
				if(!nameRegExp.test($('.userName').val())){
					$('#nameFormSpan').html('<p style="color : red;"><i class="fa fa-ban" aria-hidden="true">Check Name Condition!</i></p>');
					$('.submit').hide();
					return;
				}
				$('#nameFormSpan').html('<p style="color : green;"><i class="fa fa-check" aria-hidden="true">You Can use This Name</i></p>');
				$('.submit').show();
				
			});
			//username Exp Check End
			
			//submit button onclick event
			$('.submit').on('click',function(e){
				e.preventDefault();
				var formObj = $("form[role='form']");
				var str = "<input type='hidden' name='userid' value='${member.userid}'>"
				str += "<input type='hidden' name='email' value='${member.email}'>"
				var address = $('#postcode').val() + $('#addr').val() + $('#details').val();
				$('input[name="address"]').val(address);	
				var phoneNumber = $('select[name="firstNumber"] option:selected').val() +"-"+ $('input[name="secondNumber"]').val() +"-"+ $('input[name="finalNumber"]').val();
				$('input[name="phoneNumber"]').val(phoneNumber);
				formObj.append(str).submit();
			})
			//cancel button onclick event
			$('.cancel').on('click',function(e){
				e.preventDefault();
				window.history.back();
			})
			
		})
	</script>
	<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js">
		
	</script>
</body>
</html>