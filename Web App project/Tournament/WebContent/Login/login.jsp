<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  
   pageEncoding="ISO-8859-1"%>  
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
      <title>Login Application</title>
      <link rel="stylesheet" type="text/css" href="login.css">
      <%@include file="/includes/head.jsp" %>
      <script>
         $( document ).ready(function() { loadPage() });
      </script>
   </head>
   <body>
      <%@include file="/includes/header.jsp" %>
       <div class="main">
      <div class="login-form">
         <h1>Member Login</h1>       
         <form action="/loginServlet" method="post">
            <input type="text" name="username" required class="text" value="USERNAME" onFocus="this.value = '';" onBlur="if (this.value == '') {this.value = 'USERNAME';}" >
            <input type="password" name="userpass" required value="Password" onFocus="this.value = '';" onBlur="if (this.value == '') {this.value = 'Password';}">
            <div class="submit">
               <input type="submit" onClick="myFunction()" value="LOGIN" >
            </div>
            <p><a href="#">Forgot Password ?</a></p>
         </form>
      </div>
      </div>
   </body>
</html>