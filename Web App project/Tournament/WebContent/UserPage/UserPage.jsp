<%@page import="sessioncontrol.SessionController"%>
<%@page import="mappable.User" %>
<%
	User user = SessionController.CurrentUser(request);
	if(user == null)
		response.sendRedirect("/Login/login.jsp");

%>


<!DOCTYPE html>
<html lang="en">

<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">
	
	<title>User Page</title>
	<%@include file="/includes/head.jsp" %>
      <script>
         $( document ).ready(function() { loadPage() });
      </script>
      
    <%@include file="/includes/header.jsp" %>
	<link href="/css/simple-sidebar.css" rel="stylesheet">
	
	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
	<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
	
	<script>
	$(document).ready(function($) { 
		$('ul.sidebar-nav li').click(function() { 
			
			switch($(this).attr('id')){
			
				case "myProfile":
					$("#update").empty();
					$("#update").html("<h3>My Profile</h3>");
					break;
					
				case "teams":
					$("#update").empty();
					$("#update").html("<h3>Teams</h3>");
					break;
					
				case "brackets":
					$("#update").empty();
					$("#update").html("<h3>Current Brackets</h3>");
					break;
					
				case "pastResults":
					$("#update").empty();
					$("#update").html("<h3>Past Results</h3>");
					break;
					
				case "accountInfo":
					$("#update").empty();
					$("#update").html("<h3>Account Information</h3>");
					break;
			}
		}); 
	});
	</script>
	

</head>

<body>
	
	<div id="wrapper">
	
		<!-- Sidebar -->
		<div id="sidebar-wrapper">
			<ul class="sidebar-nav">
				<li id="myProfile" class="sidebar-brand"><a href="#"><span class="glyphicon glyphicon-user"></span> My Profile</a></li>
				<li id="teams"><a href="#"><span class="glyphicon glyphicon-star"></span>  Teams</a></li>
				<li id="brackets"><a href="#"><span class="glyphicon glyphicon-object-align-horizontal"></span>  Current Brackets</a></li>
				<li id="pastResults"><a href="#"><span class="glyphicon glyphicon-time"></span>  Past Results</a></li>
				<li id="accountInfo"><a href="#"><span class="glyphicon glyphicon-info-sign"></span>  Account Information</a></li>
			</ul>
		</div>
		<!-- /#sidebar-wrapper -->
		
		<!-- Page Content -->
		<div id="page-content-wrapper">
			<div class="container-fluid">
				<div class="row">
					<div class="col-lg-12">
						<h4>
							<img src="/DevRes/defaultProfile.jpg" width="80" height="80" class="img-circle" class="img-thumbnail">
							<%=session.getAttribute("username") %>
						</h4>
						<a href="#menu-toggle" class="btn btn-default" id="menu-toggle">Toggle Menu</a>
						<hr>
					
						<div id="update">
							<h3>My Profile</h3>
	
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /#page-content-wrapper -->
	
	</div>
	<!-- /#wrapper -->
	

	
	<!-- Menu Toggle Script -->
	<script>
	$("#menu-toggle").click(function(e) {
	e.preventDefault();
	$("#wrapper").toggleClass("toggled");
	});
	</script>

</body>

</html>