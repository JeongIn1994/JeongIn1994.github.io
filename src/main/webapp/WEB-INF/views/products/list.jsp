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
			<li class="nav-items"><a class="nav-link links" data-category="all" href="#">ALL</a></li>
			<li class="nav-items"><a class="nav-link links" data-category="seeds" href="#">Seeds</a></li>
			<li class="nav-items"><a class="nav-link links" data-category="bottles" href="#">Bottles</a></li>
			<li class="nav-items"><a class="nav-link links" data-category="etc" href="#">Etc</a></li>
		</ul>
		
		<button class="regBtn btn btn-info">Regist</button>
	</div>
	
	

	<%@include file="../include/footer.jsp"%>

	<script>
		//url parameter function
		function getParameterByName(name) {
			name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
			var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex.exec(location.search);
			return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
		}
		//function end		
		var cateparam = getParameterByName('category');
		//category active
		$(".links[data-category="+cateparam+"]").attr("class","nav-link links active");
		
		//move category page
		$(".links").on("click", function(e) {
			e.preventDefault();			
			var category = $(this).data("category");
			console.log(category);
			location.href = "/products/list?category=" + category;

		})
		
		$('.regBtn').on('click',function(e){
			
			self.location = "/products/register";
		})
		
		
	</script>
</body>
</html>