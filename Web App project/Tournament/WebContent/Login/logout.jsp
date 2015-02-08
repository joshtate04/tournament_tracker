<%
session.setAttribute("username", null); 
session.setAttribute("fname", null); 
session.setAttribute("lname", null); 
session.setAttribute("email", null); 
session.setAttribute("permission", null); 
session.invalidate();
response.sendRedirect("index.jsp");
%>