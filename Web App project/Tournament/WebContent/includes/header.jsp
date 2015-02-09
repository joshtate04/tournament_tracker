<%@page import="sessioncontrol.SessionController"%>
<%@page import="mappable.User"%>
<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="/">Tournament Tracker</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li id='home' ><a href="/index.jsp">Home</a></li>
         <li id='createBracket'><a href="/BracketCreation/createBracket.jsp">Create Bracket</a></li>
          <li id='page2'><a href="#">Page 2</a></li>
        <li id='page3' class="dropdown">        
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">Page 3 <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="#">Page 3-1</a></li>
            <li><a href="#">Page 3-2</a></li>
            <li><a href="#">Page 3-3</a></li>
          </ul>
        </li>      
      </ul>
      <% 
      	User curr_user = SessionController.CurrentUser(request);
      	if(curr_user == null) {
      %>
      <ul class="nav navbar-nav navbar-right">
      	<li><span class="navbar-text">Session: <% out.print(request.getSession().getAttribute("session_id")); %></span>
        <li><a href="#"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
        <li><a href="/Login/login.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
      </ul>
      <% } else { %>
      <ul class="nav navbar-nav navbar-right">
      	<li><span class="navbar-text">Session: <% out.print(request.getSession().getAttribute("session_id")); %></span>
        <li id='page3' class="dropdown">        
          <a class="dropdown-toggle" data-toggle="dropdown" href="#"><% out.print(curr_user.name()); %> <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="/UserPage/UserPage.jsp">My Page</a></li>
            <li><a href="/logoutServlet">Logout</a></li>
          </ul>
        </li>  
      </ul>
      <% } %>
    </div>
  </div>
</nav>

