<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  
    pageEncoding="ISO-8859-1"%>  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<title>Welcome <%=session.getAttribute("name")%></title>  
  <%@include file="/includes/head.jsp" %>
      <script>
         $( document ).ready(function() { loadPage() });
      </script>
</head>  
<body>  
 <%@include file="/includes/header.jsp" %>
    <h3>Login successful!!!</h3>  
    <h4>  
        Hello,  
        <%=session.getAttribute("fname")%>
   	</h4>
   	
   	<a href="/UserPage/UserPage.jsp">My Profile</a> 
         
</body>  
</html>  