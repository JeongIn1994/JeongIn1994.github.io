<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Register</title>
</head>
<body>
<%@include file="../include/header.jsp" %>
<div class="container">
<!-- Title -->
<hr>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Products Register</h1>
	</div>
</div>
<hr>
<div>
	<div class="col-lg-12" style="border: 1px solid gray ;padding: 10px; border-radius: 5px;height: 1150px;" >
		<div class="panel panel-default">
			<div class="panel-heading" style="border-bottom:1px solid gray;padding-bottom: 5px"><h4>product Register</h4></div>
			<!-- panel body start -->
			<div class="panel-body" style="padding: 5px"></div>
				<form role="form" action="/products/register" method="post">
				 <input type="hidden" name="${_csrf.parameterName }"  value="${_csrf.token }">
				
				<h5>Category</h5>
					<div class="custom-control custom-radio custom-control-inline">
   						<input type="radio" class="custom-control-input" id="customRadio" name="category" value="seeds" checked>
    					<label class="custom-control-label" for="customRadio">Seeds</label>
  					</div>
  					<div class="custom-control custom-radio custom-control-inline">
    					<input type="radio" class="custom-control-input" id="customRadio2" name="category" value="bottle">
    					<label class="custom-control-label" for="customRadio2">Bottles</label>
  					</div> 
  					<div class="custom-control custom-radio custom-control-inline">
    					<input type="radio" class="custom-control-input" id="customRadio3" name="category" value="etc">
    					<label class="custom-control-label" for="customRadio3">Etc</label>
  					</div> 
  					<hr>
				 <div class="row">
					<div class="form-group col-sm-4">
						<label>Product Name</label><input class="form-control" name="pname" required>			
					</div>
					<div class="form-group col-sm-4 uploadDiv">
						<label>Thumbnail</label><input type="file" name="fileupload" multiple="multiple">
					</div>
					<div class="form-group col-sm-4 uploadResult">
						 
					</div>
				</div>
				<hr>
				<span><h5>Product Details</h5></span>
				 <div class="row">
					<div class="form-group col-sm-4">
						<label>Price</label>
						<input type="number" class="form-control" name="price" min="0" step="1000">													
					</div>				 
					<div class="form-group col-sm-4">
						<label>Manufacturer</label><input class="form-control" name="manufacturer">			
					</div>		
					<div class="form-group col-sm-4">
						<label>Country</label>
						<input class="form-control" name="country">												
					</div>										
				</div>
				<div class="row">
					<div class="form-group col-sm-4">						
						<label>Product Size</label>
						<div class='row' style="margin-left: 35px;">
							<input class="form-control pwidth col-sm-4" name="width" placeholder="cm">
							&nbsp;<c:out value='X'/>&nbsp;		
							<input class="form-control pheight col-sm-4" name="height" placeholder="cm">
							<input type='hidden' class="psize col-sm-4e" name="psize">	
						</div>
					</div>
					<div class="form-group col-sm-4">
						<label>Stock</label>
						<input type="number" class="form-control" name="stock" min="0" step="1">												
					</div>																			
					<div class="form-group col-sm-4">
						<label>Product Weight(Unit : g)</label>
						<input type="number" class="form-control" name="weight">												
					</div>		
				</div>
				<hr>	
				<label><h5>Product Explain</h5></label>									
					<div class="form-group">
						 <textarea name="pexplain" id="editor" rows="30" cols="80">
               					
            			</textarea>
            			<script>
                			CKEDITOR.replace('editor', {filebrowserUploadUrl:'<c:url value="/imageUpload" />?${_csrf.parameterName}=${_csrf.token}'} );
                			CKEDITOR.config.resize_enabled = false;
                			CKEDITOR.config.height = 280;
                			CKEDITOR.config.image_previewText = 'Image Thumbnail';

            			</script>					
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
	<script>
	$(document).ready(function(){
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
		//thumbnail button click event
		var cloneObj = $('.uploadDiv').clone();	
		$("input[type='file']").on('change',function(e){
			
			var formData = new FormData();
			 
			var inputFile = $("input[name='fileupload']");
			 
		 	var files = inputFile[0].files;
		 	
		 	console.log(files[0]);
		 	//if uploadfiles more than 2files, first file was be Thumbnail

			
			for(var i=0; i< files.length;i++){
			
				if(files.length>1){
					alert("Thumbnail File Only 1 File! First File was be Thumbnail !");
					formData.append("uploadFile",files[0]);
					break;
				}else if(!checkExtension(files[i].name,files[i].size)){
					return false;
				}
				formData.append("uploadFile",files[0]);
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
					
// 					showUploadResult(result);
					

				}
			 });//ajax end
			
		})
		//onclick submit button
		$('button[type="submit"]').on('click',function(e){			
			e.preventDefault();
			//psize calculate input
			var psize = $('.pwidth').val() + '*' + $('.pheight').val();
			$('.psize').val(psize);

		})
	})	
	</script>
</div>
</div>
<%@include file="../include/footer.jsp" %>
</body>
</html>