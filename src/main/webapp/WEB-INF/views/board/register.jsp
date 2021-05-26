<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Posting</title>
</head>
<style>

	.uploadResult {
		width: 100%;
		background-color: gray;	
	}
	.uploadResult ul{
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	.uploadResult ul li{
		list-style: none;
		padding: 10px;
	}
	.uploadResult ul li img{
		width: 20px; 
	}

</style>
<body>
<%@include file="../include/header.jsp" %>
<div class="container">
<!-- Title -->
<hr>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Register</h1>
	</div>
</div>

<hr>

<div>
	<div class="col-lg-12" style="border: 1px solid gray ;padding: 10px; border-radius: 5px;height: 900px;" >
		<div class="panel panel-default">
			<div class="panel-heading" style="border-bottom:1px solid gray;padding-bottom: 5px"><h4>Board Register</h4></div>
			<!-- panel body start -->
			<div class="panel-body" style="padding: 5px"></div>
				<form role="form" action="/board/register" method="post">
				 <input type="hidden" name="${_csrf.parameterName }"  value="${_csrf.token }">
				
				<h5>Category</h5>
					<div class="custom-control custom-radio custom-control-inline">
   						<input type="radio" class="custom-control-input" id="customRadio" name="category" value="Common" checked>
    					<label class="custom-control-label" for="customRadio">Common</label>
  					</div>
  					<div class="custom-control custom-radio custom-control-inline">
    					<input type="radio" class="custom-control-input" id="customRadio2" name="category" value="Qustion">
    					<label class="custom-control-label" for="customRadio2">Qustion</label>
  					</div> 
  					<hr>
				 <div class="row">
					<div class="form-group col-sm-8">
						<label>Title</label><input class="form-control" name="title" required>			
					</div>
					
					<div class="form-group col-sm-4">
						<label>Writer</label>
						<c:choose>
							<c:when test="${pinfo eq 'anonymousUser' }">
								<input class="form-control" name="writer">
							</c:when>
							<c:when test="${pinfo ne 'anonymousUser' }">
								<input class="form-control" name="writer" value='${pinfo.username }' readonly>
							</c:when>				
						</c:choose>
					</div>
				</div>	
					<div class="form-group">
						 <textarea name="content" id="editor" rows="30" cols="80">
               					
            			</textarea>
            			<script>
                			CKEDITOR.replace('editor', {filebrowserUploadUrl:'<c:url value="/imageUpload" />?${_csrf.parameterName}=${_csrf.token}'} );
                			CKEDITOR.config.resize_enabled = false;
                			CKEDITOR.config.height = 280;
                			CKEDITOR.config.image_previewText = 'Image Thumbnail';

            			</script>					
					</div>
					
					
					<div style="border-bottom: 1px dashed gray; border-top: 1px dashed gray; margin-bottom: 10px; padding: 10px;">
						<i class="fa fa-files-o" aria-hidden="true"></i>Attch Files
						<div>
							<input type="file" name="uploadFile" multiple>
						</div>
						
						<div class ='uploadResult'>
							<ul>
							
							</ul>
						</div>
					</div>	
					
									
					<button type="submit" class="btn btn-primary">Submit</button>
					
					<button type="reset" class="btn btn-info">Reset</button>	
					
					<button type="button" class="btn btn-danger" onclick='history.back();'>Cancel</button>	
							
					
				</form>
				<!-- form end -->
		</div>
		<!-- panel default end -->
	</div>
	<hr>
</div>
</div>
<script type="text/javascript">
	$(document).ready(function(e){	
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880;
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
				beforeSend : function(xhr)
	            {
	            	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	            },		
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
			uploadUL.append(str);
		}//showUploadResult end
	$(".uploadResult").on("click","i",function(e){
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		
		var targetLi = $(this).closest("li");
		
		$.ajax({
			url : '/deleteFile',
			data : {fileName :targetFile,type : type },
			dataType : 'text',
			type : 'POST',
			success:function(result){
				alert(result);
				targetLi.remove();
			}
		});//ajax end
	});
		
	});

</script>
<%@include file="../include/footer.jsp" %>
</body>
</html>