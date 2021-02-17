<%@ page session="false"%>
<%@include file="include/header.jsp"%>
<body>
	<div class="row" style="width: 100%;">
		<!-- slide part -->
		<div id="demo" class="carousel slide col-9" data-ride="carousel">
			<!-- Indicators -->
			<ul class="carousel-indicators">
				<li data-target="#demo" data-slide-to="0" class="active"></li>
				<li data-target="#demo" data-slide-to="1"></li>
				<li data-target="#demo" data-slide-to="2"></li>
			</ul>
			<!-- The slideshow -->
			<div class="carousel-inner" style="height: 250px;">
				<div class="carousel-item active">
					<img src="../../resources/img/2.png" class="mx-auto d-block">
				</div>
				<div class="carousel-item">
					<img src="../../resources/img/index.png" class="mx-auto d-block">
				</div>
				<div class="carousel-item">
					<img src="../../resources/img/index.jpg" class="mx-auto d-block">
				</div>
			</div>
			<!-- Left and right controls -->
			<a class="carousel-control-prev" href="#demo" data-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			</a> <a class="carousel-control-next" href="#demo" data-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
			</a>
		</div>
		<!-- login console part -->
		<div class="col-3" style="background-color: gray;">
			<div class="LoginPanel-heading" style="border-bottom: 1px solid black">
				<form role="form" action="/Logins" method="post">
					<input type="hidden" name="${_csrf.parameterName }"  value="${_csrf.token }">
					<sec:authentication property="principal" var="pinfo" />
					<c:choose>
						<c:when test="${pinfo ne 'anonymousUser' }">
							<div class='loginPanel'>
								<h3>Welcome, <c:out value="${pinfo.username }"/> !</h3>
							</div>
							<div class='row' style="padding: 5px">
								<div class='col-sm-6'>
									<a href='#' style="color: teal;"><i class="fa fa-info"
										aria-hidden="true"></i> User Page </a>
								</div>
								<div class='col-sm-6' style="text-align: right;">
									<a href='#' id='logout' style="color: navy;"><i class="fa fa-sign-out"
										aria-hidden="true"></i> Logaout</a>
								</div>
							</div>
							
						</c:when>
						<c:when test="${pinfo eq 'anonymousUser' }">
							<div class='loginPanel'>
								<h3>Account Login</h3>
								<button type="button" class="login btn btn-info btn-block">
									<i class="fa fa-sign-in" aria-hidden="true"></i> Login
								</button>
							</div>
							<div class='row' style="padding: 5px">
								<div class='col-sm-6'>
									<a href='#' style="color: teal;"><i class="fa fa-refresh"
										aria-hidden="true"></i> Forget ID/PW</a>
								</div>
								<div class='col-sm-6' style="text-align: right;">
									<a href='/member/conditionsOfUse' style="color: navy;"><i class="fa fa-plus"
										aria-hidden="true"></i> Create New Account</a>
								</div>
							</div>
						</c:when>
					</c:choose>
				</form>
				<!-- loginpanel heading end -->
			</div>
			<!-- login colsole end -->
			<div>
				Icons List
			</div>
		</div>
	</div>
	<div class="container" style="margin-top: 30px">
		<div class="row">
			<div class="col-sm-4">
				<h2>About Me</h2>
				<h5>Photo of me:</h5>
				<div class="fakeimg">Fake Image</div>
				<p>Some text about me in culpa qui officia deserunt mollit
					anim..</p>
				<h3>Some Links</h3>
				<p>Lorem ipsum dolor sit ame.</p>
				<ul class="nav nav-pills flex-column">
					<li class="nav-item"><a class="nav-link active" href="#">Active</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
					<li class="nav-item"><a class="nav-link disabled" href="#">Disabled</a>
					</li>
				</ul>
				<hr class="d-sm-none">
			</div>
			<div class="col-sm-8">
				<h2>TITLE HEADING</h2>
				<h5>Title description, Dec 7, 2017</h5>
				<div class="fakeimg">Fake Image</div>
				<p>Some text..</p>
				<p>Sunt in culpa qui officia deserunt mollit anim id est laborum
					consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
					labore et dolore magna aliqua. Ut enim ad minim veniam, quis
					nostrud exercitation ullamco.</p>
				<br>
				<h2>TITLE HEADING</h2>
				<h5>Title description, Sep 2, 2017</h5>
				<div class="fakeimg">Fake Image</div>
				<p>Some text..</p>
				<p>Sunt in culpa qui officia deserunt mollit anim id est laborum
					consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
					labore et dolore magna aliqua. Ut enim ad minim veniam, quis
					nostrud exercitation ullamco.</p>
			</div>
		</div>
	</div>
</body>
<%@include file="include/footer.jsp"%>
<script>
	$(document).ready(function(e) {

		var form = $('form[role="form"]');

		$(".login").on('click', function(e) {
			e.preventDefault();
			form.attr('action', '/Logins');
			form.submit();
		});
		
		$('#logout').on('click',function(e){
			
			
			$('form[role="form"]').attr('action','/Logout');
			
			$('form[role="form"]').submit();
			
		})
	});
</script>
</body>
</html>
