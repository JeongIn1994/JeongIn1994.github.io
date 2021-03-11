<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>read page</title>
</head>
<style>
	.uploadResult{
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	.uploadResult li{
		list-style: none;
		padding: 10px;
		align-content: center;
		text-align: center;
	}	
</style>
<body>
<%@include file="../include/header.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container">
<!-- Title -->

<div>
	<div class="col-lg-12" >
	<hr>
		<div class="panel panel-default">
			<div class="panel-heading" style="border-bottom:1px solid gray;padding-bottom: 5px;"><span class="badge badge-dark"><c:out value="${board.category }"/></span><c:out value="${board.title }"/></div>
			
			<!-- panel body start -->
			<div class="panel-body" style="padding-top: 5px"></div>
					<div style="border-bottom: 1px solid rgb(128, 128, 128); margin-bottom: 5px;padding-bottom: 5px;font-size:small;"><c:out value="${board.writer }"/></div>	
						
					<div style="text-align: right;font-size: small;" class="urlAddress">
						
					</div>
					
					<div class="form-group">
						<c:out value="${board.content }" escapeXml = "false"/>	<!-- Wrap Line -->
					</div>
					
				<!-- form end -->
					
				<div style="border-bottom: 1px solid gray;border-top: 1px solid gray;padding-bottom: 5px;padding-top: 5px">
					<i class="fa fa-files-o" aria-hidden="true"></i>Attch Files
				</div>
				<div class="panel-body">
					<ul class='uploadResult list-group list-group-flush'>
					
					</ul>
				</div>
		</div>
		<!-- panel default end -->
		<br>
		<!--  reply List Start -->
		<!-- panel heading start -->
		<div class ="panel panel-default" style="border-bottom: 1px dashed rgb(128, 128, 128);margin-bottom: 15px">
			<div class = "panel-heading" style="border-bottom: 1px solid black;border-top: 1px solid black;padding: 5px ">
				<i class="fa fa-comment" aria-hidden="true"></i>Replies&nbsp;<b>[<c:out value="${board.replyCnt }" />]</b>
			</div>
			<!-- panel heading end -->
			<!-- panel body start -->
			<div class="panel-body">
				<ul class="replyList list-group list-group-flush">

					<!-- reply end -->
				</ul>
				<!-- panel body end -->
			</div>
			<!-- panel end -->
		</div>
		<!-- reply list end -->
		
		<!-- reply list paging -->
		<div class="panel-footer">
		
		</div>
		
	<!-- reply input form -->
	<div style="border-bottom: 1px solid black;border-top: 1px solid black;padding: 5px ;margin-top: 15px;margin-bottom: 15px">
	  <i class="fa fa-commenting-o" aria-hidden="true"></i>New Reply
	</div>
	<div style="border-bottom: 1px dashed rgb(128, 128, 128);">
			<div class="form-group" id="replyForm">			
				<div class ="row" style="padding-bottom: 5px" >
					<div class="col-4">
  						<label>Name:</label>
						<c:choose>
							<c:when test="${pinfo eq 'anonymousUser' }">
								<input class="form-control" name="replyer">
							</c:when>
							<c:when test="${pinfo ne 'anonymousUser' }">
								<input class="form-control" name="replyer" value='${pinfo.username }' readonly>
							</c:when>				
						</c:choose>
  					</div>
  					<div class="col-4">
  					<c:choose>
  						<c:when test="${pinfo eq 'anonymousUser' }">
  							<label>Password:</label>
  							<input type="password" class="form-control" name="password">
  						</c:when>
  						<c:when test="${pinfo ne 'anonymousUser' }">
  							<input type="hidden" class="form-control" name="password" value="${pinfo.password }">
  						</c:when>
  					</c:choose>
  					</div>
  				</div>
  				
  				<div class = "row">
  					<div class="col-6">
  						<textarea class="form-control" rows="1" name="content" placeholder="input Comment"></textarea>
  					</div>
  					<div class ="col-1">
  						<button type="button"  class="btn btn-secondary" data-oper="registBtn" >Regist</button>
  					</div>	
  				</div>
			</div>

		</div>
	</div>
	
	<!-- Bottom buttons -->		
	<div style="margin: 5px">
	<sec:authorize access="isAuthenticated()">
		<c:if test="${pinfo.username eq board.writer }">
		<button type="button" data-oper='modify' class="btn btn-info" >Modify</button>
		</c:if>
	</sec:authorize>	
		<button type="button" data-oper='list' class="btn btn-success">Back</button>
			<form id="operForm" action="/board/modify" method="get">
				<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno }"/>'>
				<input type="hidden" id="pageNum" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
				<input type="hidden" id="amount" name="amount" value='<c:out value="${cri.amount }"/>'>
  				<input type="hidden" name='type' value='<c:out value="${cri.type }"/>'/>
  				<input type="hidden" name='keyword' value='<c:out value="${cri.keyword }"/>'/>						
			</form>		
	</div>	
	<hr>
</div>
</div>
<script type="text/javascript" src = "/resources/js/reply.js"></script>
<script type="text/javascript">
document.title = 'Read Post - <c:out value="${board.title  }" />';

//---------------------------Display Original Image------------------------------------
function showImage(fileCallPath){
	alert(fileCallPath);
}
//---------------------------reply delete--------------------------

function deleteReply(tag){
	var username = null;
	
	//when user was logined
	<sec:authorize access ="isAuthenticated()">
	 username = "<c:out value='${pinfo.username}'/>";
	</sec:authorize>
	
	var replier = $(tag).data("replier");
	var rno = $(tag).data("rno");
	// 관리자 권한으로도 삭제가능하게끔 추가할것
	if(replier == username)
	{
		if(confirm('Delete This Reply ?')==true)
		{
			replyService.remove(rno,function(result)
					{
				alert(result);
				showList(pageNum);
			})
		}
	}else{
		alert('Only those who left comments can delete them!')
	}
}
//---------------------------reply delete end-----------------------

//---------------------------Reply List ----------------------------
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".replyList");
	var attachFiles = $(".uploadResult");
	
	
	function showList(page){
		
		replyService.getList({bno :bnoValue,page :page ||1 },function(replyCnt,list){
			
			if(page == -1){
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);
				return;
			}
			
			var str = "";
			//When Reply was Not Exsist In Post
			if(list == null || list.length ==0){
				str = "<span style='text-align:center;padding:30px;' ><i class='fa fa-comments-o' aria-hidden='true';'></i>Not Exsist Comments In this post</span>";
				replyUL.html(str);
				
				return;
			}
			
			for(var i =0, len = list.length||0;i<len;i++){
				
				str +="<li class= 'list-group-item' data-rno='"+list[i].rno+"' > ";
				str +="<div><div class='header'><strong>"+list[i].replyer+"</strong>";			
				str +="<small>"+replyService.displayTime(list[i].replyDate)+"</small>&nbsp;";
				str +="<i class='fa fa-ban' aria-hidden='true' data-rno='"+list[i].rno+"' data-replier='"+list[i].replyer+"' onclick='deleteReply(this)'></i></div>";
				str +="<p>"+list[i].reply+"</p></div></li>"
			}
			replyUL.html(str);
			
			showReplyPage(replyCnt);
		});
		
	}//ShowList End
	//------------------------Reply List End----------------------------
	//---------------------------reply paging--------------------------
		var pageNum = 1;
		var replyPageFooter = $(".panel-footer");
		
		function showReplyPage(replyCnt){
			
			
			var endNum = Math.ceil(pageNum / 10.0) * 10 ;
			var startNum = endNum - 9;
			
			var prev = startNum != 1;
			var next = false;
			
			if(endNum * 10 >= replyCnt){
				endNum = Math.ceil(replyCnt/10.0);
			}
			
			if(endNum * 10 < replyCnt ){
				next = true;
			}
			
			var str = "<ul class='pagination justify-content-center'>";
			
			if(prev){
				str +="<li class='page-item'><a class='page-link' href='"+(startNum -1 ) +"'>Prev</a></li>"
			}
			
			for(var i = startNum ; i<= endNum; i++){
				
				var active = pageNum ==i? "active":"";
				
				str += "<li class = 'page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
				
			}
			if(next){
				str += "<li class='page-item'><a class='page-link' href ='"+(endNum +1 )+"'>Next</a></li>"
			}
			str += "</ul></div>"
			
			replyPageFooter.html(str);
		};
	//---------------------------REply Paging End-----------------------	
$(document).ready(function(){

	showList(1);

	//-----------url Adress---------------------------
	var url = window.location.href;
	var urlAddress=$(".urlAddress");
	urlAddress.html("<a href='"+url+"'>"+url+"</a>");	
	//-----------url Address End ---------------------
	


		var operForm = $("#operForm");
		
		$("button[data-oper='modify']").on("click",function(){
			operForm.attr("action","/board/modify").submit();
		});
		
		$("button[data-oper='list']").on("click",function(){
			
			operForm.find("#bno").remove();
			operForm.attr("action","/board/list").submit();
		});
		
		//--------------------------reply regist--------------------------	
		var replyForm =$("#replyForm");
		var replyer = replyForm.find("input[name=replyer]");
		var password = replyForm.find("input[name=password]");
		var content = replyForm.find("textarea[name=content]")
	
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue="${_csrf.token}";
		
		$(document).ajaxSend(function(e,xhr,options){
			xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
		});
		$("button[data-oper='registBtn']").on("click",function(){
			
			var reply={
					reply:content.val(),
					replyer : replyer.val(),
					bno : bnoValue,
					password : password.val()
			};
			replyService.add(reply,function(result){
				
				alert(result);
				content.val("");
				showList(-1);
			})
			
		});
	//---------------------------reply regist end----------------------
	
	//---------------------------replyPageFotter On click Button Event----------------- 
		replyPageFooter.on("click","li a",function(e){
			
			e.preventDefault();
			
			var targetPageNum = $(this).attr("href");
			pageNum = targetPageNum;
			
			showList(pageNum);
			
		});
	//---------------------------replyPageFotter On click Button Event End-----------------
	
	//---------------------------Upload File List------------------------------------------
	(function(){
		var bno = '<c:out value ="${board.bno}"/>';
		
		$.getJSON("/board/getAttachList",{bno:bno},function(arr){
		
			var str = "";
			if(arr.length <= 0){
				str += "<span style='text-align:center;padding:30px;' ><i class='fa fa-files-o' aria-hidden='true'></i>Not Exsist Attach Files In this post</span>";
				attachFiles.html(str);
			}else{
			$(arr).each(function(i,attach){
				var fileCallPath = encodeURIComponent(attach.uploadPath +"/"+attach.uuid+"_"+attach.fileName);
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"'>";
					str += "<div><i class='fa fa-file-o' aria-hidden='true'></i><a href='/download?fileName="+fileCallPath+"'>"+attach.fileName+"<a></div></li>";
				});
				attachFiles.html(str);
			}
		});//getJSON end
		
	})();//function end
	
	
});	

</script>

<%@include file="../include/footer.jsp" %>
</body>
</html>