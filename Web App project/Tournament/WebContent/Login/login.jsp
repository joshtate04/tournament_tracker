<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  
   pageEncoding="ISO-8859-1"%>  
<html>
   	<head>
      	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
      	<title>Login Application</title>      
      	<%@include file="/includes/head.jsp" %>
      	<script>
        	$( document ).ready(function() { loadPage() });
      	</script>
   	</head>
	<body>
      	<%@include file="/includes/header.jsp" %>
       	<!-- <div class="main">
      		<div class="login-form">
         		<h1>Member Login</h1>       
         		<form action="/loginServlet" method="post">
         		<
            		<input type="text" name="username" required class="text" value="USERNAME" onFocus="this.value = '';" onBlur="if (this.value == '') {this.value = 'USERNAME';}" >
            		<input type="password" name="userpass" required value="Password" onFocus="this.value = '';" onBlur="if (this.value == '') {this.value = 'Password';}">
            		<div class="submit">
               			<input type="submit" onClick="myFunction()" value="LOGIN" >
            		</div>
            		<p><a href="#">Forgot Password ?</a></p>
         		</form>
      		</div>
      	</div> -->
      	<div class='container'>
	      	<div class='row'>
	      		<div class='col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1'>
	      			<form action="/loginServlet" method="post">
		      			<% if (response.getHeader("login") == "fail") { %>
		      				<div class='panel panel-primary animated shake'>
		      			<% } else { %>
		      				<div class='panel panel-primary'>
		      			<% } %>
		      				<div class='panel-heading text-center'>
		      					<h3 class='panel-title'>Member Login</h3>
		      				</div>
		      				<div class='panel-body'>
		      					<div class='form-group'>
		      						<input type="text" placeholder='Username' class='form-control' name='username' id='username' />
		      					</div>
		      					<div class='form-group'>
		      						<input type="password" placeholder='Password' class='form-control' name='password' id='password' />
		      						<% if (response.getHeader("login") == "fail") { %><span class='text-danger'>Sorry, we couldn't log you in!</span><% } %>
		      					</div>
		      					<div class='form-group'>
		      						<a href='#'>Forgot your password?</a>
		      					</div>
		      					<input type="submit" value="LOGIN" class='btn btn-primary btn-block' />
		      				</div>
		      			</div>
		      		</form>
	      		</div>
	      	</div>
	    </div>
   	</body>
</html>