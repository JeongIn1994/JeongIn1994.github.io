<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class='container'>
		<hr>
		<span><a style='font-size: 25px; font-family: sans-serif;'>All
				User List</a></span>
		<hr>
		<table class="table table-bordered">
			<thead>
				<tr class="table-active">
					<td>RegDate</td>
					<td>UserId</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${members }" var="userList">
					<tr>
						<td><fmt:formatDate value="${userList.regDate }"
								pattern="yyyy/MM/dd" /></td>
						<td>${userList.userid }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<ul class="pagination justify-content-center" style="margin: 20px 0">
			<!-- if PageNumber is 1, Not showing -->
			<c:if test="${pageMaker.prev }">
				<li class="page-item"><a class="page-link"
					href="${pageMaker.startPage -1 }">Prev</a></li>
			</c:if>

			<!-- Show Number -->
			<c:forEach var="num" begin="${pageMaker.startPage }"
				end="${pageMaker.endPage }">
				<li class="page-item ${pageMaker.cri.pageNum == num ?'active':'' }">
					<a class="page-link" href="${num }">${num }</a>
				</li>
			</c:forEach>

			<!-- if PageNumber is EndPage, Not showing -->
			<c:if test="${pageMaker.next }">
				<li class="page-item"><a class="page-link"
					href="${pageMaker.endPage + 1 }">Next</a></li>
			</c:if>
		</ul>
		<div class="row">
			<div class="col-sm-4"></div>
			<div class="col-sm-4">
				<form id='searchForm' action="/member/getAllUser" method="get">
					<select name="type" class="custom-select col-md-4">
						<option value="" <c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>---</option>
						<option value="U" <c:out value="${pageMaker.cri.type eq 'U'?'selected':'' }"/>>User's ID</option>
					</select> 
					<input type="text"style="padding-bottom: 5px; border: 1px solid gray; border-radius: 5px 5px 5px 5px"
					name='keyword' class="col-md-4" value='<c:out value="${pageMaker.cri.keyword }"/>'placeholder="Search Userid">
					 <input type="hidden"name='pageNum' value='<c:out value="${pageMaker.cri.pageNum }"/>' />
					<input type="hidden" name='amount' value='<c:out value="${pageMaker.cri.amount }"/>' />
					<button class='btn btn-primary'>Search</button>
				</form>
			</div>
			<div class="col-sm-4"></div>
		</div>

	</div>
	<form action="#" method="get" id="actionForm">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
		<input type="hidden" name='type' value='<c:out value="${pageMaker.cri.type }"/>' /> 
		<input type="hidden" name='keyword'value='<c:out value="${pageMaker.cri.keyword }"/>' />
	</form>
</body>
<script>
	var actionForm = $("#actionForm");
	$(".pagination a").on("click", function(e) {
		e.preventDefault();

		actionForm.attr("action", "/member/getAllUser");
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	})
	var searchForm = $("#searchForm");		
		$("#searchForm button").on("click",function(e){
			
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
</script>
</html>