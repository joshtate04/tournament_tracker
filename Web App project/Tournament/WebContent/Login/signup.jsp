<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  
   pageEncoding="ISO-8859-1"%>  
<html>
   	<head>
      	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
      	<title>Login Application</title>
      	<!-- <link rel="stylesheet" type="text/css" href="/Login/login.css"> -->
      	<%@include file="/includes/head.jsp" %>
      	<script>
        	$( document ).ready(function() { loadPage() });
      	</script>
   	</head>
<body>
	<%@include file="/includes/header.jsp"%>
	<div class='container'>
	      	<div class='row'>
	      		<div class='col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1'>
	      			<form action="/registerServlet" method="post">
		      			<% if (response.getHeader("login") == "fail") { %>
		      				<div class='panel panel-primary animated shake'>
		      			<% } else { %>
		      				<div class='panel panel-primary'>
		      			<% } %>
		      				<div class='panel-heading text-center'>
		      					<h3 class='panel-title'>Member Registration</h3>
		      				</div>
		      				<div class='panel-body'>
		      					<div class='form-group'>
										<input type="text" placeholder='Username' class='form-control'
											name='username' id='username' />
									</div>
									<div class='form-group'>
										<input type="text" placeholder='Jon' class='form-control'
											name='firstname' id='firstname' />
									</div>
									<div class='form-group'>
										<input type="text" placeholder='Snow' class='form-control'
											name='lastname' id='lastname' />
									</div>
									<div class='form-group'>
										<input type="text" placeholder='example@gmail.com'
											class='form-control' name='email' id='email' />
									</div>
									<div class='form-group'>
										<input type="password" placeholder='Password'
											class='form-control' name='password' id='password' />
										<%
											if (response.getHeader("login") == "fail") {
										%><span class='text-danger'>Sorry, we couldn't register you
											in!</span>
										<%
											}
										%>
									</div>
		      					<input type="submit" value="Register" class='btn btn-primary btn-block' />
		      				</div>
		      			</div>
		      			</div>
		      		</form>
	      		</div>
	      	</div>
	    </div>
</body>
</html>