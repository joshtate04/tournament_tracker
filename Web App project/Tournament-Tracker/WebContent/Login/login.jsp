<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  
    pageEncoding="ISO-8859-1"%>  
<html>  
<head>  
<link rel="stylesheet" type="text/css" href="login.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<title>Login Application</title>  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
</head>  
<body>  
    <div class="main">
     <script>
 $( document ).ready(function() {	
	 	 $( "#header" ).load( "../HeaderAndFooter/header.html" );
	});
 
 </script>
 <div id='header'></div>
		<div class="login-form">
			<h1>Member Login</h1>
					<div class="head">
						<img src="user.png" alt=""/>
					</div>
				<form >  
				<%-- <form action="loginServlet" method="post">   --%>	
						<input type="text" name="username" required class="text" value="USERNAME" onFocus="this.value = '';" onBlur="if (this.value == '') {this.value = 'USERNAME';}" >
						<input type="password" name="userpass" required value="Password" onFocus="this.value = '';" onBlur="if (this.value == '') {this.value = 'Password';}">
						<div class="submit">
							<input type="submit" onClick="myFunction()" value="LOGIN" >
					</div>	
					<p><a href="#">Forgot Password ?</a></p>
				</form>
			</div>
			<!--//End-login-form-->	
		</div>
    
    
    
</body>  
</html> 