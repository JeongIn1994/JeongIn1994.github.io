<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<meta name = "google-signin-client_id"content = "908347009003-vgp750ao2k14oudv7hmgc0sinfi3250q.apps.googleusercontent.com">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<%@include file="include/header.jsp"%>
<style>
<!--
	a {margin-top: 5px;margin-bottom: 5px;}	
-->
</style>
<div class="row" style="margin: 5px;">
	
	<div class="col-sm-4"></div>
	<div class="col-sm-4">
		<div class="msg">
			<c:choose>
				<c:when test="${error eq true}">
					<div style="color: red;">
					<i class="fa fa-times" aria-hidden="true"></i>
					<c:out value="Try Again Check Your ID/PW !"/>
					</div>
				</c:when>
				<c:when test="${logout eq true}">
					<div style="color: green;">
					<i class="fa fa-sign-out"aria-hidden="true"></i>
					<c:out value="Logout Success !"/>
					</div>
				</c:when>			
			</c:choose>
		</div>
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
						<a href="#" class="btn btn-lg btn-success btn-block">Login</a>

						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" >
						
					</fieldset>
				</form>
					 <div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"></div>
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
$(document).ready(function(e) { 	
	$(".btn-success").on("click",function(e){
		e.preventDefault();
		$("form").submit();
	})
        //구글 로그아웃
        function signOut() {
            var auth2 = gapi.auth2.getAuthInstance();
            auth2.signOut().then(function(){
          console.log('User signed out.'); 
                });
            auth2.disconnect();
          }

      //구글 로그인
      function onSignIn(googleUser) {
        // Useful data for your client-side scripts:
        var profile = googleUser.getBasicProfile();
        console.log("ID: " + profile.getId()); // Don't send this directly to your server!
        console.log('Full Name: ' + profile.getName());
        console.log('Given Name: ' + profile.getGivenName());
        console.log('Family Name: ' + profile.getFamilyName());
        console.log("Image URL: " + profile.getImageUrl());
        console.log("Email: " + profile.getEmail());
        
        var name = profile.getEmail();
        
        // The ID token you need to pass to your backend:
        var id_token = googleUser.getAuthResponse().id_token;
        console.log("ID Token: " + id_token);
    if (name !== null){
        window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/?name="+name);
    } else if (name == null){
        
        window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/");
    }
    
      }
})
</script>
</body>
</html>