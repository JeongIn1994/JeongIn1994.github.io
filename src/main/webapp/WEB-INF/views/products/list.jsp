<%@page import="org.springframework.mail.javamail.JavaMailSender"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	 a:link { color: black; text-decoration: none;}
	 a:visited { color: black; text-decoration: none;}
	 a:hover { color: black; text-decoration: none;}
	 a:active {text-decoration: none;}
	 .list-group {
 	 	display: flex;
 		align-content: flex-start;
  		flex-direction: column;
  		flex-wrap: wrap;
  		overflow: auto;
	 }
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
		<!-- product List -->
		<div class='container' style='text-align: center;margin: 5px'>
		<ul class="list-group list-group-horizontal">
			<c:forEach items="${list}" var="product">		
				<li class='list-group-item product' style='margin: 5px; border: 1px solid white;height: 200px;width: 350px; '>
				<div class='divLink' data-pid='${product.pid }'>
					<a class="move" href='<c:out value="${product.pid }"/>'>				
						<img src='/display?fileName=${product.encodePath }' style='height: 100px;'><br>
						<c:out value="${product.pname }"/><br>
						<c:out value="￦${product.price }"/><br>
						<c:out value="${product.regdate }"/>
						<input type="hidden" class='pid' value='${product.pid }'> 			
					</a>
				</div>	
				</li>
			</c:forEach>
		</ul>
		</div>
		<ul>
	</ul>
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
 <div class="row" style="margin-bottom: 15px"> 
 	<div class="col-sm-4">
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<button class="regBtn btn btn-info">Regist</button>
		</sec:authorize>
	</div>	
	<div class="col-sm-4">	
		
	</div>

	<!-- 	<button class="regBtn btn btn-info">Regist</button> -->
	<div class="col-sm-4">
		<form action="/products/list" method="get" id="actionForm">
			<select name="type" class="custom-select col-md-4">
  				<option value="P" <c:out value="${pageMaker.cri.type eq 'P'?'selected':'' }"/>>ProductName</option>
  			</select>
  			<input type="text" style="padding-bottom: 5px;border: 1px solid gray;border-radius: 5px 5px 5px 5px" 
  				name='keyword' class="col-md-4" value='<c:out value="${pageMaker.cri.keyword }"/>'placeholder="Product Name">
			<input type="hidden" name="category" value="${pageMaker.cri.category }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">			
  			<button class='btn btn-primary'>Search</button>
	</form>
	</div>
</div>
	<%@include file="../include/footer.jsp"%>
<script>
	$(document).ready(function(){
		history.replaceState({},null,null);
		
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
		$('.regBtn').on('click', function(e) {

			self.location = "/products/register";
		})
// 		Paging Start
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
		//serachForm Exception
		var searchForm = $("#actionForm");		
		$("#actionForm button").on("click",function(e){
			
			if(!searchForm.find("option:selected").val()){
				alert("Must Be Selected Option!");
				return false;
			}
			if(!searchForm.find("input[name='keyword']").val()){
				alert("Must Be Put In Keyword!");
				return false;
			}
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			
			searchForm.submit();
		});

	});
	</script>
</body>
</html>