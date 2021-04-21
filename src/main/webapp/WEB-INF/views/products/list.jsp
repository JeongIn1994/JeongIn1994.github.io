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
				data-category="bottle" href="#">Bottles</a></li>
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
		<ul class="pagination justify-content-center" style="margin:20px 0">
			<!-- if PageNumber is 1, Not showing -->
			<c:if test="${pageMaker.prev }">
		 		<li class="page-item"><a class="page-link" href="${pageMaker.startPage -1 }">Prev</a></li>
			</c:if>	
			<!-- Show Number -->
			<c:forEach var = "num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
		 		<li class="page-item ${pageMaker.cri.pageNum == num ?'active':'' }"><a class="page-link" href="${num }">${num }</a></li>
			</c:forEach>	
			<!-- if PageNumber is EndPage, Not showing -->
			<c:if test="${pageMaker.next }">
		 		<li class="page-item"><a class="page-link" href="${pageMaker.endPage + 1 }">Next</a></li>
			</c:if>		
		</ul>
  

		
	</div>
	<!-- 	<button class="regBtn btn btn-info">Regist</button> -->
	
	<form action="/products/list" method="get" id="actionForm">
		<input type="hidden" name="category" value="${pageMaker.cri.category }">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		<input type="hidden" name='type' value='<c:out value="${pageMaker.cri.type }"/>'/>
  		<input type="hidden" name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'/>
	</form>
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
		$(".links[data-category=" + cateparam + "]").attr("class","nav-link links active");

		//move category page
		$(".links").on("click", function(e) {
			
			e.preventDefault();
			var category = $(this).data("category");
			actionForm.attr("action","/products/list");
			$("input[name='category']").attr("value",category);
			actionForm.find("input[name='pageNum']").val(1);
			
			actionForm.submit();
		})
		//Register Button
// 		$('.regBtn').on('click', function(e) {

// 			self.location = "/products/register";
// 		})
		//Paging Start
		var actionForm = $("#actionForm");
		$(".pagination a").on("click",function(e){
			e.preventDefault();
			
			actionForm.attr("action","/products/list");
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		})
		//Paging End	
		
		//Clicked Post Event
		$(".move").on("click",function(e){
			e.preventDefault();
			$('#pid').remove();//case of without list button click,browser was cilcked back key or mouse back key And delete hidden tag.
			actionForm.append("<input type='hidden' id ='pid' name='pid' value='"+$(this).attr("href")+"'>");
			actionForm.attr("action","/products/get");
			actionForm.submit();

		});
	</script>
</body>
</html>