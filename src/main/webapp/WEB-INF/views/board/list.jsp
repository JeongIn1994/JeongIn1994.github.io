<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FlowerChest - Post List</title>
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container" style="padding: 15px">
  <h2>Common Board</h2>
  <p>Posting Yourself Freedomly!</p>            
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
     <c:forEach items="${list}" var="board">
     	<tr>
     		<td><span class='<c:out value="${board.category eq 'Common'?'badge badge-primary':'badge badge-warning' }"/>'><c:out value="${board.category }"/></span></td>
     		<td><a class="move" href='<c:out value="${board.bno }"/>'><c:out value="${board.title }"/>
     		<b>[<c:out value="${board.replyCnt }"/>]</b>
     		</a></td>
     		<td><c:out value="${board.writer }"/></td>
     		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate }"/></td>
     		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate }"/></td>
     	</tr>
     </c:forEach>
    </tbody>
  </table>
<!-- paging -->  
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
  
 
 <div class="row">  
  <div class="col-sm-6">
  	<sec:authorize access="isAuthenticated()">
  		<button id="regBtn" type="button" class = "btn btn-secondary">Regist New Post</button>
  	</sec:authorize>
  </div>
  <!-- search form -->
  <div class="col-sm-6">
  	<form id='searchForm' action="/board/list" method="get">
  		<select name="type" class="custom-select col-md-4">
  			<option value="" <c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>---</option>
  			<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>Title</option>
  			<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>Content</option>
  			<option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':'' }"/>>Writer</option>
  			<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }"/>>Title Or Content</option>
  			<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':'' }"/>>Title Or writer</option>
  			<option value="TCW" <c:out value="${pageMaker.cri.type eq 'TCW'?'selected':'' }"/>>All</option>
  		</select>
  		<input type="text" style="padding-bottom: 5px;border: 1px solid gray;border-radius: 5px 5px 5px 5px" 
  			name='keyword' class="col-md-4" value='<c:out value="${pageMaker.cri.keyword }"/>'placeholder="Input Keyword">
  		<input type="hidden" name='pageNum' value='<c:out value="${pageMaker.cri.pageNum }"/>'/>
  		<input type="hidden" name='amount' value='<c:out value="${pageMaker.cri.amount }"/>'/>
  		<button class='btn btn-primary'>Search</button>
  	</form>
  </div>
  <!-- search form end -->
 </div> 
</div>

<form action="/board/list" method="get" id="actionForm">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	<input type="hidden" name='type' value='<c:out value="${pageMaker.cri.type }"/>'/>
  	<input type="hidden" name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'/>
</form>
<!-- modal end -->
<script type="text/javascript">
	$(document).ready(function(){
		//modal function startd 
		var result = '<c:out value="${result}"/>';
		
		checkModal(result);
		
		history.replaceState({},null,null);
		
		function checkModal(result){
			if(result === ''||history.state){
				return;
			}
			
			if(parseInt(result)> 0){
				$(".modal-body").html("PostNumber : " + parseInt(result) +"has Posted!");
			}
			$("#myModal").modal("show");
		}
		//modal function end
		
		//Onclick RegistButton Function Strat
		$("#regBtn").on("click",function(){
			self.location ="/board/register";
		})
		//Onclick RegistButton Function End
		
		//Onclick Paging Number
		var actionForm = $("#actionForm");
		$(".pagination a").on("click",function(e){
			e.preventDefault();
			
			actionForm.attr("action","/board/list");
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		})
		//Paging End
		
		//Clicked Post Event
		$(".move").on("click",function(e){
			e.preventDefault();
			$('#bno').remove();//case of without list button click,browser was cilcked back key or mouse back key And delete hidden tag.
			actionForm.append("<input type='hidden' id ='bno' name='bno' value='"+$(this).attr("href")+"'>");
			actionForm.attr("action","/board/get");
			actionForm.submit();

		});
		
		//Search Form Click Event
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
		
	});
</script>
<%@include file="../include/footer.jsp" %>
</body>
</html>