<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="include/header.jsp"%>
<div class="msg">
	<h2><c:out value="${error }"/></h2>
	<h2><c:out value="${logout }"/></h2>	
</div>
<div class="row" style="margin: 5px;">
	<div class="col-sm-4"></div>
	<div class="col-sm-4">
		<div class="login-panel panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">Please Sign In</h3>
			</div>
			<div class="panel-body">
				<form role="form" action="/login" method="post">
					<fieldset>
						<div class="form-group">
							<input class="form-control" placeholder="ID" name="username"
								type="email" autofocus>
						</div>
						<div class="form-group">
							<input class="form-control" placeholder="Password"
								name="password" type="password" value="">
						</div>
						<div class="checkbox">
							<label> <input name="remember" type="checkbox"
								value="Remember Me">Auto Login
							</label>
						</div>
						<!-- Change this to a button or input when using this as a form -->
						<a href="index.html" class="btn btn-lg btn-success btn-block">Login</a>
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" >
					</fieldset>
				</form>
			</div>
			<!-- panel body end -->
		</div>
		<!-- login panel end -->
	</div>
	<!-- div col-4 end -->
	<div class="col-sm-4"></div>
</div>
<%@include file="include/footer.jsp"%>
<script type="text/javascript">
	$(".btn-success").on("click",function(e){
		e.preventDefault();
		$("form").submit();
	})

</script>
</body>
</html>