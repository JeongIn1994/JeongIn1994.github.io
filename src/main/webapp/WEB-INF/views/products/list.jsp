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
			<li class="nav-items"><a class="nav-link links"
				data-category="all" href="#">ALL</a></li>
			<li class="nav-items"><a class="nav-link links"
				data-category="seeds" href="#">Seeds</a></li>
			<li class="nav-items"><a class="nav-link links"
				data-category="bottles" href="#">Bottles</a></li>
			<li class="nav-items"><a class="nav-link links"
				data-category="etc" href="#">Etc</a></li>
		</ul>

		<table class="table table-hover">
			<thead>
				<tr>
					<th>category</th>
					<th>Title</th>
					<th>Writer</th>
					<th>PostDate</th>
					<th>UpdateDate</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="product">
					<tr>
						<td><span class='<c:out value="${product.category eq 'seeds'?'badge badge-primary':'badge badge-warning' }"/>'><c:out	value="${product.category }" /></span></td>
						<td><a class="move" href='<c:out value="${product.pid }"/>'><c:out value="${product.pname }" /></a></td>
						<td><c:out value="${product.price }" /></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${product.regdate }" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<button class="regBtn btn btn-info">Regist</button>




	<%@include file="../include/footer.jsp"%>

	<script>
		//url parameter function
		function getParameterByName(name) {
			name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
			var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex
					.exec(location.search);
			return results == null ? "" : decodeURIComponent(results[1]
					.replace(/\+/g, " "));
		}
		//function end		
		var cateparam = getParameterByName('category');
		//category active
		$(".links[data-category=" + cateparam + "]").attr("class",
				"nav-link links active");

		//move category page
		$(".links").on("click", function(e) {
			e.preventDefault();
			var category = $(this).data("category");
			console.log(category);
			location.href = "/products/list?category=" + category;

		})

		$('.regBtn').on('click', function(e) {

			self.location = "/products/register";
		})
	</script>
</body>
</html>