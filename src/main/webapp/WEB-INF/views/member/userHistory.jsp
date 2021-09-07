<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	tbody tr{
		display: none;
	}
</style>
<body>
	<%@include file="../include/header.jsp"%>
	<div class='container'>
		<hr>
		<h4>${pinfo.username }'s Active History</h4>
		<p>Show recent 7 Days Board</p>
		<hr>
		<div class='container'>
			
			<table class="table table-bordered" style="text-align: center;">
				<thead>
					<tr>
						<th style="width: 70%">Title</th>
						<th>Regdate</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${userHistory.boardList }" var="history">					
					<tr>
						<td style="width: 70%"><a href="/board/get?bno=${history.bno }">${history.title }</a></td>
						<td><fmt:formatDate value="${history.regdate }" pattern="yyyy/MM/dd"/></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<a href='#' id='load' style='text-align: right;'>showing 5 more board</a>
		</div>
		<hr>
	</div>
<%@include file="../include/footer.jsp"%>
<script>
	$(document).ready(function(e){
		$('tbody tr').slice(0,5).show();
		$('#load').on('click',function(e){
			e.preventDefault();
			$('tbody tr:hidden').slice(0,5).show();
			$('tbody tr:hidden').length == 0 ? alert('This page is Last Page') : '';
		})
	})
	
</script>
</body>
</html>