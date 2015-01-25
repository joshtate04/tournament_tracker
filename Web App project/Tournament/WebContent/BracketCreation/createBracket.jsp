<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<%@include file="/includes/head.jsp" %>
 <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript" src="/js/jquery.bracket.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/jquery.bracket.min.css" />


<script>

  
  
$(document).ready(function($) {         
	loadPage();
	var saveData = {
	    teams : [
	             ["Team 1",  "Team 2" ],
	             ["Team 3",  "Team 4" ],
	             ["Team 5",  "Team 6" ],
	             ["Team 7",  "Team 8" ],
	             ["Team 9",  "Team 10"],
	             ["Team 11", "Team 12"],
	             ["Team 13", "Team 14"],
	             ["Team 15", "Team 16"]
	    ],
	    //results : [[1,0], [2,7]]
	  }
	 
	/* Called whenever bracket is modified
	 *
	 * data:     changed bracket object in format given to init
	 * userData: optional data given when bracket is created.
	 */
	function saveFn(data, userData) {
	  var json = jQuery.toJSON(data)
	  $('#saveOutput').text('POST '+userData+' '+json)
	  /* You probably want to do something like this
	  jQuery.ajax("rest/"+userData, {contentType: 'application/json',
	                                dataType: 'json',
	                                type: 'post',
	                                data: json})
	  */
	}
	 
	$(function() {
	    var container = $('#save')
	    container.bracket({
	      init: saveData,	
	      save: saveFn,	   
	      skipConsolationRound: true,
	      })
	 
	    /* You can also inquiry the current data */
	    var data = container.bracket('data')
	    $('#dataOutput').text(jQuery.toJSON(data))
	  })
	
	
});  


</script>

</head>
<body>
<%@include file="/includes/header.jsp" %>
	<div id="save"></div>
</body>
</html>