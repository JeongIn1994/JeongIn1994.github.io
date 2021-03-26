<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Read Page</title>
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

<div class="container">
<!-- Title -->
<hr>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Modify Content</h1>
	</div>
</div>

<hr>

<div>
	<div class="col-lg-12" style="border: 1px solid gray ;padding: 10px; border-radius: 5px">
		<div class="panel panel-default">
			<div class="panel-heading" style="border-bottom:1px solid gray;padding-bottom: 5px">
				 <h4>Modify Post</h4>
			</div>
			
			<!-- panel body start -->
			<div class="panel-body" style="padding: 5px"></div>
				<form role="form" action="/board/modify" method="post">
					<input type="hidden" name="${_csrf.parameterName }"  value="${_csrf.token }">
					<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
					<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>'>
  					<input type="hidden" name='type' value='<c:out value="${cri.type }"/>'/>
  					<input type="hidden" name='keyword' value='<c:out value="${cri.keyword }"/>'/>	
				<h5>Category</h5>
					<div class="custom-control custom-radio custom-control-inline">
   						<input type="radio" class="custom-control-input" id="customRadio" name="category" value="Common" <c:out value="${board.category eq 'Common'?'checked':'' }" /> >
    					<label class="custom-control-label" for="customRadio">Common</label>
  					</div>
  					<div class="custom-control custom-radio custom-control-inline">
    					<input type="radio" class="custom-control-input" id="customRadio2" name="category" value="Qustion" <c:out value="${board.category eq 'Qustion'?'checked':'' }" />>
    					<label class="custom-control-label" for="customRadio2">Qustion</label>
  					</div> 
  									
					<div class="row">
					
						<div class="form-group">
							<input type="hidden" name="bno" value="${board.bno }"> 
						</div>
					
						<div class="form-group col-sm-8">
							<label>Title </label><input class="form-control" name="title" value='<c:out value="${board.title }"/>'>					
						</div>
					
						<div class="form-group col-sm-4">
							<label>Writer</label><input class="form-control" name="writer" readonly value='<c:out value="${board.writer }"/>'>				
						</div>					
					</div>
					
					<div class="form-group">
						 <textarea name="content" id="editor" rows="10" cols="80">
               					<c:out value="${board.content }" escapeXml = "false"/>
            			</textarea>		
						<script>
                			CKEDITOR.replace( 'editor',{filebrowserUploadUrl:'/imageUpload'});
                			CKEDITOR.config.resize_enabled = false;
                			CKEDITOR.config.height = 400;
                			CKEDITOR.config.image_previewText = 'Image Thumbnail';

            			</script>			            				
					</div>	
					<div style="border-bottom: 1px dashed gray; border-top: 1px dashed gray; margin-bottom: 10px; padding: 10px;">
						<i class="fa fa-files-o" aria-hidden="true"></i>Attch Files
					</div>
					<div class="panel-body" style="border-bottom: 1px solid gray;margin-bottom: 5px;">
					<div>
						<input type="file" name="uploadFile" multiple>
					</div>
						<ul class='uploadResult list-group list-group-flush'>
					
						</ul>
					</div>									
					
					<button type="submit" data-oper="modify" class="btn btn-info" >Modify</button>	
					
					<button type="submit" data-oper="remove" class="btn btn-danger" >Remove</button>	
					
					<button type="button" data-oper="list"class="btn btn-success">List</button>							
				</form>
				<!-- form end -->
			
		</div>
		<!-- panel default end -->
	</div>
	<hr>
</div>
</div>
<script type="text/javascript">
$(document).ready(function(){
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880;
	var attachFiles = $(".uploadResult");
	//extension check
	function checkExtension(fileName,fileSize){
		
		if(fileSize >= maxSize){
			alert("FileSize Was So Bigger!")
			return;
		}
		if(regex.test(fileName)){
			alert("This Files Was Not Upload!")
			return;
		}
		return true;
	}
	$("input[type='file']").change(function(e){
		var formData = new FormData();
		 
		 var inputFile = $("input[name='uploadFile']");
		 
		 var files = inputFile[0].files;
		 
		 for(var i=0; i< files.length;i++){
			 
			 if(!checkExtension(files[i].name,files[i].size)){
				 
				 return false;
			 }
			 formData.append("uploadFile",files[i]);
		 	}
		 
		 $.ajax({
			url : '/uploadAjaxAction',
			processData : false ,
			contentType : false ,
			data : formData ,
			type : 'POST',
			dataType : 'json',
			success : function(result){
				
				console.log(result);
				
				showUploadResult(result);
				

			}
		 });//ajax end
		
	})
	
	
	var formObj = $("form[role='form']");
	
	$("button[type='submit']").on("click",function(e){
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		if(operation ==='remove'){
			formObj.attr("action","/board/remove");
		}else if(operation ==='list'){
			formObj.attr("action","/board/list");
		}else{
		var str ="";
		
		$(".uploadResult ul li").each(function(i,obj){
			
			var jobj = $(obj);
			console.dir(jobj);
			
			str += "<input type='hidden' name='attachList["+i+"].fileName' value = '"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value = '"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value = '"+jobj.data("path")+"'>";

			
		})
		console.log(str);
		formObj.append(str).submit();
		}
		formObj.submit();
	});
	
	function showUploadResult(uploadResultArr){
		
		if(!uploadResultArr || uploadResultArr.length ==0){return;}
		
		var uploadUL = $(".uploadResult ul");
		
		var str = "";
		$(uploadResultArr).each(function(i,obj){
			if(obj.image){

				var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
			
				
				str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"'>";
				str += "<img src='/display?fileName="+fileCallPath+"'></a>"
						+obj.fileName +"<i class='fa fa-ban' aria-hidden='true' data-file=\'"+fileCallPath+"\' data-type='image'></i></li>";
						
			}else{
				var fileCallPath = encodeURIComponent(obj.uploadPath +"/"+obj.uuid+"_"+obj.fileName);
				fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
				str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"'>";
				str += "<a href='/download?fileName="+fileCallPath+"'><img src='/resources/img/attach.png'>" 
						+obj.fileName+"</a><i class='fa fa-ban' aria-hidden='true' data-file=\'"+fileCallPath+"\' data-type='file'></i></li>";
				
			}
		})
		attachFiles.append(str);
	}//showUploadResult end
	var formObj = $("form");
	
	
	$("button").on("click",function(e){
		
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		console.log(operation);
		
		if(operation ==='remove'){
			if(confirm("Delete This Post?")){
			formObj.attr("action","/board/remove");
			}
		}else if(operation ==='list'){
			
			formObj.attr("action","/board/list").attr("method","get");
			
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var typeTag = $("input[name='type']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(typeTag);
			formObj.append(keywordTag);
		}
		formObj.submit();
	});
	//---------------------------Upload File List------------------------------------------
	(function(){
		var bno = '<c:out value ="${board.bno}"/>';
		
		$.getJSON("/board/getAttachList",{bno:bno},function(arr){
			console.log(arr);
			
			var str = "";
			if(arr.length <= 0){
				str += "<span style='text-align:center;padding:30px;' ><i class='fa fa-files-o' aria-hidden='true'></i>Not Exsist Attach Files In this post</span>";
				attachFiles.html(str);
			}else{
			$(arr).each(function(i,attach){
				var fileCallPath = encodeURIComponent(attach.uploadPath +"/"+attach.uuid+"_"+attach.fileName);
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"'>";
					str += "<div><i class='fa fa-file-o' aria-hidden='true'></i><a href='/download?fileName="+fileCallPath+"'>"+attach.fileName+"<a>";
					str += "<i class='fa fa-ban' aria-hidden='true' data-file=\'"+fileCallPath+"\' data-type='file'></i></div></li>";
				});
				attachFiles.html(str);
			}
		});//getJSON end
		
	})();//function end
	//---------------------------Upload File List end---------------------------------------
	
	//---------------------------Upload File Remove------------------------------------------
	$(".uploadResult").on("click","i",function(e){
		
		if(confirm("Remove This File?")){
			var targetLi = $(this).closest("li");
			targetLi.remove();
		}
	})
});

</script>
<%@include file="../include/footer.jsp" %>
</body>
</html>