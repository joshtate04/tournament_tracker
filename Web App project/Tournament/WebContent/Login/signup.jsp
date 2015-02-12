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
		      			<div class='panel panel-primary'>
		      				<div class='panel-heading text-center'>
		      					<h3 class='panel-title'>Member Registration</h3>
		      				</div>
		      				<div class='panel-body'>
		      					<% if(response.getHeader("signup") != null) { %>
		      						<span class="text-danger">Sorry, we couldn't complete the sign up</span>
			      					<div class='form-group'>
										<input type="text" placeholder='Username' class='form-control'
											name='username' id='username' 
											value="<% if(response.getHeader("username") != null){
												out.print(response.getHeader("username").toString());
											} %>" />
										<span class="text-danger">
											<% if(response.getHeader("username_error") != null){out.print(response.getHeader("username_error").toString());} %>
										</span>
									</div>
									<div class='form-group'>
										<input type="text" placeholder='First Name' class='form-control'
											name='firstname' id='firstname' 
											value="<% if(response.getHeader("firstname") != null){
												out.print(response.getHeader("firstname"));
											} %>" />
										<span class="text-danger">
											<% if(response.getHeader("firstname_error") != null){out.print(response.getHeader("firstname_error").toString());} %>
										</span>
									</div>
									<div class='form-group'>
										<input type="text" placeholder='Last Name' class='form-control'
											name='lastname' id='lastname' 
											value="<% if(response.getHeader("lastname") != null){
												out.print(response.getHeader("lastname"));
											} %>" />
										<span class="text-danger">
											<% if(response.getHeader("lastname_error") != null){out.print(response.getHeader("lastname_error").toString());} %>
										</span>
									</div>
									<div class='form-group'>
										<input type="text" placeholder='Email Address'
											class='form-control' name='email' id='email' 
											value="<% if(response.getHeader("email") != null){
												out.print(response.getHeader("email"));
											} %>" />
										<span class="text-danger">
											<% if(response.getHeader("email_error") != null){out.print(response.getHeader("email_error").toString());} %>
										</span>
									</div>
									<div class='form-group'>
										<input type="password" placeholder='Password'
											class='form-control' name='password' id='password' />
										<span class="text-danger">
											<% if(response.getHeader("password_error") != null){out.print(response.getHeader("password_error").toString());} %>
										</span>
									</div>
		      					<% } else { %>
		      					<div class='form-group'>
									<input type="text" placeholder='Username' class='form-control'
										name='username' id='username' />
								</div>
								<div class='form-group'>
									<input type="text" placeholder='First Name' class='form-control'
										name='firstname' id='firstname' />
								</div>
								<div class='form-group'>
									<input type="text" placeholder='Last Name' class='form-control'
										name='lastname' id='lastname' />
								</div>
								<div class='form-group'>
									<input type="text" placeholder='Email Address'
										class='form-control' name='email' id='email' />
								</div>
								<div class='form-group'>
									<input type="password" placeholder='Password'
										class='form-control' name='password' id='password' />
								</div>
								<% } %>
		      					<input type="submit" value="Register" class='btn btn-primary btn-block' />
		      				</div>
		      			</div>
		      		</form>
	      		</div>
	      	</div>
	    </div>
</body>
</html>