<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="../include/header.jsp"%>
	<div class='container'>
		<h2>Conditions Of Use</h2>
		<textarea rows="10" cols="150" readonly style="overlow-x:scroll" >
			<%@ include file="../../../resources/conditionsOfUse.txt" %>
		</textarea>
		<div style="text-align: center;">
			<input type="checkbox" class='agreeChk'>Yes.I'm Reading All
			Contents,And I'm Agree.
		<br>

		<button class='btn btn-primary next'>Next</button>
		<button class='btn btn-danger prev'>Prev</button>
		</div>
		<div class="progress" style="margin-top: 30px;">
			<div class="progress-bar" style="width: 33%">1/3</div>
		</div>
	</div>
	

	<%@include file="../include/footer.jsp"%>
<script>
$(document).ready(function(e){
	
	$('.next').on('click',function(e){
		if($('.agreeChk').is(':checked')== true){
			location.href = '/member/register';
		}else{
			alert('You Must Check Conditons Of Use Agree ')
		}
		
	})
	
	$('.prev').on('click',function(e){
		if(confirm("Don't Wanna Be Our Member ?")){
			location.href ='/';
		}else{
			return;
		}
	})
	
})
</script>
</body>
</html>