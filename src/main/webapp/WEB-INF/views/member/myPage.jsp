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
</style>
</head>
<body>
	<%@include file="../include/header.jsp"%>
	<div class="container" style="padding:5px">
		<hr>
		<p>
		<h2>${member.userid }'s Information</h2>
		<hr>
		<table class="table table-striped" >
			<tbody>
				<tr>
					<td>Name</td>
					<td><c:out value="${member.userName }"/></td>				
				</tr>
				<tr>
					<td>Address</td>
					<td><c:out value="${member.address }" /></td>				
				</tr>
				<tr>
					<td>PhoneNumber</td>
					<td><c:out value="${member.phoneNumber }"/></td>					
				</tr>
				<tr>
					<td>Regist Date</td>
					<td><fmt:formatDate value="${member.regDate }" pattern="yyyy/MM/dd"/></td>					
				</tr>
				<tr>
					<td>E-Mail</td>
					<td><c:out value="${member.email }"/></td>					
				</tr>					
			</tbody>
		</table>
		<div style="text-align: center;">
			<form role='form' action='#' method="get">
				<button type='button' class='btn btn-info modify' >Modify</button>
				<button type='button' class='btn btn-primary pwChange' >Password Change</button>
				<button type='button' class='btn btn-danger defection' >defection</button>
				<input type="hidden" name="${_csrf.parameterName }"  value="${_csrf.token }">
			</form>		
		</div>
	</div>
	<%@include file="../include/footer.jsp"%>
	<script>
		document.title = '<c:out value="${member.userid  }"/>';
		$(document).ready(function(e) {
			var formObj = $("form[role='form']");
			//modify button onclick event 
			$('.modify').on('click',function(e){
				e.preventDefault();
				$('input[name="userid"]').remove();
				var str = "<input type='hidden' name='userid' value='${member.userid}'>"
				formObj.attr('action','/member/modify');
				formObj.append(str).submit();
			})
			//password change button onclick event
			$('.pwChange').on('click',function(e){
				e.preventDefault();
				$('input[name="userid"]').remove();
				var str = "<input type='hidden' name='userid' value='${member.userid}'>";
				window.open("/member/emailAuth?userid=${member.userid}",'passwordchangePage','width=500,height=500');
				
			})
			//defection button click event
			$('.defection').on('click',function(e){
				e.preventDefault();
				var defectionMassege = prompt("Input This Sentence : Yes.I Agree Delete This Account");
				if(defectionMassege == 'Yes.I Agree Delete This Account'){
					var str = "<input type='hidden' name='userid' value='${member.userid}'>";
					formObj.attr('action','/member/remove');
					formObj.attr('method','post');
					formObj.append(str).submit();
				}else{
					alert("Input Message was incorrect!")
					return;
				}
			})
			
		})
	</script>
	<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js">
		
	</script>
</body>
</html>