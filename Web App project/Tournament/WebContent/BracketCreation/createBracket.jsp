<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="addBracket.css">

  <title>Bootstrap Case</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
 <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <script src='http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js' type='text/javascript'></script>  
 <script src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.min.js' type='text/javascript'></script> 
 
   <link rel="stylesheet" type="text/css" href="NewFile.css">
    <%@include file="/includes/head.jsp" %>
      <script>
         $( document ).ready(function() { loadPage() });
      </script>
    
 

 <script type="text/javascript">  
 
 
 var teamInfo = {
	     "team": [{
	             "id": 1,
	             "name": "Team 1",
	             "rank": 1,
	         }, {
	             "id": 2,
	             "name": "Team 2",
	             "rank": 2,
	         }, {
	             "id": 3,
	             "name": "Team 3",
	             "rank": 3,
	         }, {
	             "id": 4,
	             "name": "Team 4",
	             "rank": 4,
	         }, {
	             "id": 5,
	             "name": "Team 5",
	             "rank": 5,
	         }, {
	             "id": 6,
	             "name": "Team 6",
	             "rank": 6,
	         }, {
	             "id": 7,
	             "name": "Team 7",
	             "rank": 7,
	         }, {
	             "id": 8,
	             "name": "Team 8",
	             "rank": 8,
	         }, {
	             "id": 9,
	             "name": "Team 9",
	             "rank": 9,
	         }, {
	             "id": 10,
	             "name": "Team 10",
	             "rank": 10,
	         }, {
	             "id": 11,
	             "name": "Team 11",
	             "rank": 11,
	         }, {
	             "id": 12,
	             "name": "Team 12",
	             "rank": 12,
	         }, {
	             "id": 13,
	             "name": "Team 13",
	             "rank": 13,
	         }, {
	             "id": 14,
	             "name": "Team 14",
	             "rank": 14,
	         }, {
	             "id": 15,
	             "name": "Team 15",
	             "rank": 15,
	         }, {
	             "id": 16,
	             "name": "Team 16",
	             "rank": 16,
	         }
	     ]
	 };



 var matchInfo = {
     "rounds": [{
         "name": "Round1",

         "matches": [{
             "id": 1,
             "p1": teamInfo.team[0].name,           
             "p2": teamInfo.team[15].name,             
         }, {
             "id": 2,
             "p1": teamInfo.team[1].name,         
             "p2": teamInfo.team[14].name,
         }, {
             "id": 3,
             "p1": teamInfo.team[2].name,              
             "p2": teamInfo.team[13].name,
         }, {
             "id": 4,
             "p1": teamInfo.team[3].name,       
             "p2": teamInfo.team[12].name,
         }, {
             "id": 5,
             "p1": teamInfo.team[4].name,           
             "p2": teamInfo.team[11].name,
         }, {
             "id": 6,
             "p1": teamInfo.team[5].name,             
             "p2": teamInfo.team[10].name,
         }, {
             "id": 7,
             "p1": teamInfo.team[6].name,               
             "p2": teamInfo.team[9].name,
         }, {
             "id": 8,
             "p1": teamInfo.team[7].name,              
             "p2": teamInfo.team[8].name,
         }]
     }, {
         "name": "Round2",
         "matches": [{
             "id": 9,
             "p1": null,
             "p2": null
         }, {
             "id": 10,
             "p1": null,
             "p2": null
         }, {
             "id": 11,
             "p1": null,
             "p2": null
         }, {
             "id": 12,
             "p1": null,
             "p2": null
         }]
     }, {
         "name": "Round3",
         "matches": [{
             "id": 13,
             "p1": null,
             "p2": null
         }, {
             "id": 14,
             "p1": null,
             "p2": null
         }, ]
     }, {
         "name": "Round4",
         "matches": [{
             "id": 15,
             "p1": null,
             "p2": null
         }, ]
     }]
 };
    $(document).ready(function($) {         
    	$( "#header" ).load( "../HeaderAndFooter/header.html" );  	
    	
    	
    	
    	
 	  	  var base = $('#writeHere');  
          var matchDivsByRound = [];  
          var num = parseInt($('#num').find('option:selected').text().trim());
         
          for (var roundIndex=0; roundIndex<matchInfo.rounds.length; roundIndex++) {          	  
            var round = matchInfo.rounds[roundIndex];           
            var bracket = checkedAppend('<div class="bracket"></div>', base);  
            var matchDivs = [];  
            matchDivsByRound.push(matchDivs);  
              
            //setup the match boxes round by round  
            
            for (var i=0; i<round.matches.length; i++) {                       
              var vOffset = checkedAppend('<div></div>', bracket);  
              
              
              var match = round.matches[i];        
              var matchHtml = '<div class="match" id="match' + match.id + '">'  
                + '<div class="p1" id='+ match.id +'>' + fmtName(match.p1) + '</div>'  
                + '<div class="spacer"></div>'  
                + '<div class="p2" id='+ match.id +'>' + fmtName(match.p2) + '</div>';  
              matchDiv = checkedAppend(matchHtml, bracket);  
              matchDivs.push(matchDiv);  
            
                
              if (roundIndex > 0) {  
                //row 2+; line up with previous row  
                var alignTo = matchDivsByRound[roundIndex-1][i*2];  
                //offset to line up tops  
                var desiredOffset = alignTo.position().top - matchDiv.position().top;  
                  
                //offset by half the previous match-height  
                desiredOffset += alignTo.height() / 2;  
                vOffset.height(desiredOffset);              
              } else {  
                checkedAppend('<div class="small-spacer"></div>', bracket);  
              }  
                
              if (roundIndex > 0) {  
                //tweak our size so we stretch to the middle of the appropriate element  
                var stretchTo = matchDivsByRound[roundIndex-1][i*2+1];  
                var newH = stretchTo.position().top + stretchTo.height()/2 - matchDiv.position().top;              
                var deltaH = newH - matchDiv.height();  
                matchDiv.height(newH);  
                var spacer = matchDiv.find('.spacer');  
                spacer.height(spacer.height() + deltaH);  
              }            
            }                  
          }  
          //setup the final winners box; just a space for a name whose bottom is centrally aligned with the last match  
          bracket = checkedAppend('<div class="bracket"></div>', base);  
          var vOffset = checkedAppend('<div></div>', bracket);  
          var alignTo = matchDivsByRound[matchInfo.rounds.length - 1][0]; //only 1 match in the last round  
          var html = '<div class="winner"></div>';  
          var winnerDiv = checkedAppend(html, bracket);        
          vOffset.height(alignTo.position().top - winnerDiv.position().top + alignTo.height() / 2 - winnerDiv.height());  
          
	

          $(".p1, .p2").click(function(){
           		//edit info
         	  //matchInfo.rounds[1].matches[0].p1 = "Hi";  		
           		
       		});  	
            
   	
     
    });  
      
    function fmtName(name) {  
      return null != name ? name : '';  
    }  
      
    function checkedAppend(rawHtml, appendTo) {  
      var html = $(rawHtml);  
      if (0 == html.length) {  
        throw "Built ourselves bad html : " + rawHtml;  
      }  
      html.appendTo(appendTo);        
      return html;  
    }  
  </script>  
 
 
 
</head>
<body>
<%@include file="/includes/header.jsp" %>
    
<div id="writeHere" class="tournament"></div>  
</body>
</html>