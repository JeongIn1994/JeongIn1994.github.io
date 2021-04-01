<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Flower Chest - Home</title>
<link
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="//cdn.ckeditor.com/4.15.1/standard/ckeditor.js"></script>
<!-- text editor ckeditor 4 -->
<style>
.fakeimg {
	height: 200px;
	background: #aaa;
}
.login,logout {
	padding-left: 30px;
	padding-right: 30px;
}
.navbar-nav li {
	padding-top: 5px;
	padding-bottom: 5px;
	
}
body {
	background-color: rgba(245, 245, 220, .5);
	width: 100%;
	height: 100%;
}

.carousel-control-next-icon:after {
	content: '>';
	font-size: 55px;
	color: red;
}

.carousel-control-prev-icon:after {
	content: '<';
	font-size: 55px;
	color: red;
}
</style>
</head>
<body>

	<sec:authentication property="principal" var="pinfo" />
	<div class="jumbotron text-center" style="margin-bottom: 0;width: 100%">
		<h1>Flower Chest</h1>
		<p>Resize this responsive page to see the effect!</p>
	</div>

	<nav class="navbar navbar-expand-sm bg-dark navbar-dark" style="width: 100%">
		<a class="navbar-brand" href="/">Flower Chest</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="collapsibleNavbar">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link" href="#"
					onclick="location.href='/board/list'">Board</a></li>
				<li class="nav-item"><a class="nav-link" href="#"
					onclick="location.href='/products/list?category=all'">Product</a></li>
				<sec:authorize access="isAuthenticated()">	
				<li class="nav-item"><a class="nav-link" href="#">MyPages</a></li>		
				</sec:authorize>			
			</ul>
				<sec:authorize access="isAuthenticated()">
					<form role="form" method="post" action="/Logins/Logout" class="form-inline my-2 my-lg-0" style="margin-right: 5px;">
						<input type="hidden" name="${_csrf.parameterName }"  value="${_csrf.token }">
						<span style="color: white;margin-right: 5px;">Welcome ! <c:out value="${pinfo.username }" /></span>
						<button class="mypage btn btn-primary"style="color: white;margin-right: 5px;"><i class="fa fa-id-badge" aria-hidden="true"></i>MyPage</button>
						<button class="logout btn btn-info"style="color: white;margin-right: 5px;"><i class="fa fa-sign-out" aria-hidden="true"></i>Logout</button>
					</form>
				</sec:authorize>
				<sec:authorize access="isAnonymous()">
					<form role="form" method="get" action="/Logins/login" class="form-inline my-2 my-lg-0" >
						<button class="login btn btn-info"><i class="fa fa-sign-in" aria-hidden="true"></i>Login</button>	
					</form>
				</sec:authorize>

		</div>
		
	</nav>
	<script>
		$(".mypage").on("click",function(e){
			
			var form = $("form[role='form']");
			e.preventDefault();
			<sec:authorize access="isAuthenticated()">
				form.attr("action","/Mypage/<c:out value='${pinfo.username}' />");
			</sec:authorize>
			form.submit();
		})
	</script>
</body>