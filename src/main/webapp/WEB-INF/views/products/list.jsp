<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
</style>
<body>
	<%@include file="../include/header.jsp"%>
	<div class="container" style="padding: 15px">
		<h2>Products List</h2>
		<p>Seeing Product You are Liked</p>
		<ul class="nav nav-tabs nav-justified">
			<li class="nav-items" ><a class="nav-link" data-category="all" href="#">ALL</a></li>
			<li class="nav-items" ><a class="nav-link" data-category="seeds" href="#">Seeds</a></li>
			<li class="nav-items" ><a class="nav-link" data-category="bottles" href="#">Bottles</a></li>
			<li class="nav-items" ><a class="nav-link" data-category="etc" href="#">Etc</a></li>
		</ul>
	</div>
	<%@include file="../include/footer.jsp"%>
	
	<script>
		$(".nav-link").on("click",function(e){
			e.preventDefault();
			$(this).attr("class","nav-link active");
			var category = $(this).data("category");			
			location.href = "/products/list?category="+category;
			
		})
	
	</script>
</body>
</html>