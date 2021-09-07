<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style type="text/css">
 .floatdiv {position:fixed;
 			width:115px;
 			display:inline-block;
 			right:15%; 
 			top:65%; 
 			background-color: white;
 			margin:0; 
			border: 1px solid white;
			border-radius: 5%
 			}


 a:link { color: gray; text-decoration: none;}	

 a:visited { color: gray; text-decoration: none;}	

 a:hover { color: gray; text-decoration: underline;}

 </style> 
<body>	
	<!-- Floating Menu -->
	<div class="floatdiv" style="text-align: center;">
		<br>
		<div>
			<img class='thumbnail' src="#"><br>
			<h4>${product.pname }</h4>
		</div>
		<form action="/products/modify" method="get" role="form" id="cartForm">
			<input type='hidden' name='pid' value='${product.pid}'>
			<input type="number" min="1" step="1" value='1' height="35px" class='stock' name='stock' style="width: 85px;margin : 2px;text-align: right">
			<input type='text' class='totalPrice' disabled style="width: 85px;margin : 2px;text-align: right">
			<button type="button" class="btn btn-primary" style="margin: 2px"><i class="fa fa-cart-arrow-down" aria-hidden="true"></i> Cart</button>
			<button type="button" class="btn btn-danger" style="margin: 2px"><i class="fa fa-money" aria-hidden="true"></i> Buy</button>							
		</form>			
		<a href="#explain"><i class="fa fa-arrow-circle-up" aria-hidden="true"></i>Top</a><br>
		<a href="javascript:history.back()"><span><i class="fa fa-undo" aria-hidden="true"></i>List</span></a>								
	</div>	
	<%@include file="../include/header.jsp"%>
	<div class="container">
			<div>								
			<hr>				
				<div class="panel-heading title" style="border-bottom:1px solid gray;padding-bottom: 5px;margin-bottom: 5px;">
					<h2><span class="badge badge-dark"><c:out value="${product.category}" /></span>&nbsp;<c:out value="${product.pname }" /></h2>			
				</div>
				<!-- product content -->
				<div class="explain" id="explain" style="padding-top: 5px;">
					<c:out value="${product.pexplain }" escapeXml = "false"/>
				</div>	
				<hr>
				<!-- create table -->
				<div class="container">
				<table class="table border" style="border:1px solid gray;width: 450px;">
					<thead>
						<tr>
							<th colspan="4">Product Information</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th width="200px"> Name</th>
							<td>
								<c:out value="${product.pname }"/>
							</td>
							<th width="200px">Product Code</th>
							<td>
								<c:out value="${product.pid }"/>
							</td>
						</tr>
						<tr>
							<th width="200px"> Size</th>
							<td>
								<c:out value="${product.psize }"/>cm
							</td>
							<th width="200px"> Weight</th>
							<td>
								<c:out value="${product.weight }"/>g
							</td>
						</tr>
						<tr>
							<th width="200px" colspan="3">Country Of Origin</th>
							<td >
								<c:out value="${product.country }"/>
							</td>
						</tr>
						<tr>
							<th width="200px">Manufacturer</th>
							<td>
								<c:out value="${product.manufacturer }"/>
							</td>
							<th width="200px">Stock</th>
							<td>
								<c:out value="${product.stock }"/>
							</td>							
						</tr>
						
					</tbody>
				</table>
				</div>
				<!-- end table -->
			<div>
			<sec:authorize access="isAuthenticated()">
				<button type="button" class="btn btn-secondary modify">Modify</button>
				<button type="button" class="btn btn-danger remove">Delete</button>
			</sec:authorize>
			</div>
			<hr>			
		</div>
	</div>
	<input type="hidden" class='dataInfo' data-path="${product.uploadPath }" data-uuid="${product.uuid }" data-filename="${product.fileName }">
	<%@include file="../include/footer.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	//title
	document.title = '<c:out value="${product.pname  }" />';
	//thumbnail path
	var filePath= encodeURIComponent($('.dataInfo').data('path') + '/s_' +$('.dataInfo').data('uuid')+ '_' +$('.dataInfo').data('filename') );
	//pid
	var str = "<input type='hidden' value='"+${product.pid}+"' name='pid'>"
	//sidebar thumbnail output
	$('.thumbnail').attr('src','/display?fileName=${product.encodePath}');
	//price output
	$('.totalPrice').val('￦'+${product.price});
	var form = $('#cartForm');
	//product modify
	$('.modify').on('click',function(e){
		e.preventDefault();		
		form.append(str).submit();
		})
	//product delete
	$('.remove').on('click',function(e){
		e.preventDefault();
		if(confirm("delete this product ?")){
			form.attr('method','post');
			form.attr('action','/products/remove');
			form.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}' />");
			form.append(str).submit();
		}
		return ;
		})//product delete End
	//when stock changed, price calculate	
	$('.stock').on('change',function(e){
		var totalPrice = ${product.price} *  $('.stock').val();
		$('.totalPrice').val('￦'+totalPrice.toLocaleString());
	})	
})
</script>
</body>
</html>