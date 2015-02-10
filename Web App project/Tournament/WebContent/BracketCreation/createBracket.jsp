<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Bracket</title>

<%@include file="/includes/head.jsp" %>
<link rel="stylesheet" type="text/css" href="/css/bracket.css" />
<link rel="stylesheet" type="text/css" href="/css/simple-sidebar.css" />





<script>

    //http://whileonefork.blogspot.ca/2010/10/jquery-json-to-draw-elimination-single.html


    var teamInfo = {
        "team": []
    };
    var matchInfo = {
        "rounds": []

    };


    $(document).ready(function($) {
        $("#genBracket").hide(); //Hide the generate button until number of teams is selected  
        $("#sidebar-wrapper").hide();
        loadPage();
        fillNumTeams(); //Generate a dropdown with numbers to select amount of teams        

        /*********************************************/
        /* 		Click event to generate bracket 	 */
        /*********************************************/
        $('#genBracket').click(function() {
            $('#bracketContainer').empty();
            $("#teamForm").hide();
            $("#genBracket").hide();
            $("#sidebar-wrapper").show();
            createTeamList();
            renderBracket();


       
        });


        /*********************************************/
        /* 		Create text boxes for team names	 */
        /*********************************************/
        $("#numTeams").change(function() {
            $('#numTeamsForm').hide();
            $("#genBracket").show();
            num = $(this).val();
            for (i = 1; i <= num; i++) {
                var newTextBoxDiv = $('<div/>', {
                    id: 'team' + i
                });
                newTextBoxDiv.appendTo("#teamForm");
                newTextBoxDiv.after().html('<label>Team ' + i + ' : </label>' + '<input type="text" name="textbox' + i + '" id="textbox' + i + '" value="" >');
            }
        });
        
       

    });
    
    
    function genHook(){
        $(".score").on('focusin', function() {
            text = $(this).text();
            if (isNaN(text)) {
                $(this).html(' ');
            }
        });




        $(".score").on('focusout', function() {        	
            matchNum = $(this).parent().attr('matchNum');
            matchNum = parseInt(matchNum, "10");
            round = $(this).parent().parent().parent().attr("id");
            round = parseInt(round, "10");
            index = $(this).parent().parent().attr("id");
            index = parseInt(index, "10");
            text = $(this).text();

            if (!isNaN(text) && text >= 0 && text != " ") {
                text = parseInt(text, "10");
                if ($(this).attr('player') == 'p1') {
                    p1Score = text;
                    matchInfo.rounds[round].matches[index].p1Score = p1Score;
                } else if ($(this).attr('player') == 'p2') {
                    p2Score = text;
                    matchInfo.rounds[round].matches[index].p2Score = p2Score;
                }
                if ((!isNaN(matchInfo.rounds[round].matches[index].p1Score) && matchInfo.rounds[round].matches[index].p1Score >= 0 && matchInfo.rounds[round].matches[index].p1Score != null) && (!isNaN(matchInfo.rounds[round].matches[index].p2Score) && matchInfo.rounds[round].matches[index].p2Score >= 0 && matchInfo.rounds[round].matches[index].p2Score != null)) {
                                     
                        switch (matchInfo.rounds[round].matches[index].matchIndex) {                       
                            case 0:
                            	replace = "p1";
                            	newIndex = 0;
                                break;
                            case 1:            
                            	replace = "p2";
                                newIndex = 0;
                                break;                          
                            case 2:
                            	replace = "p1";
                            	newIndex = 1;
                                break;
                            case 3:
                            	replace = "p2";
                            	newIndex = 1;
                                break;                       
                            case 4:
                            	replace = "p1";
                            	newIndex = 2;
                                break;
                            case 5:
                            	replace = "p2";
                            	newIndex = 2;
                                break;                                
                            case 6:
                            	replace = "p1";
                            	newIndex = 3;
                                break;
                            case 7:
                            	replace = "p2";
                            	newIndex = 3;
                                break;
                        }  
                                 
                        if(p1Score > p2Score){
                        	if(replace == 'p1'){                        	
                        		matchInfo.rounds[round + 1].matches[newIndex].p1 = matchInfo.rounds[round].matches[index].p1;                         		
                        	}else if(replace == 'p2'){
                        		matchInfo.rounds[round + 1].matches[newIndex].p2 = matchInfo.rounds[round].matches[index].p1;                         		
                        	}                        	
                        }else if (p2Score > p1Score) { 
                        	if(replace == 'p1'){
                        		matchInfo.rounds[round + 1].matches[newIndex].p1 = matchInfo.rounds[round].matches[index].p2;                         		
                        	}else if(replace == 'p2'){
                        		matchInfo.rounds[round + 1].matches[newIndex].p2 = matchInfo.rounds[round].matches[index].p2;                         		
                        	}                        	
                        }                  

                    $('#bracketContainer').empty();
                    renderBracket();
                }
            } else {

                $(this).html('--');
                if ($(this).attr('player') == 'p1') {
                    matchInfo.rounds[round].matches[index].p1Score = null;
                } else if ($(this).attr('player') == 'p2') {
                    matchInfo.rounds[round].matches[index].p2Score = null;
                }
            }
        });




        $(".match").on('mouseover', function() {
            index = (this.id);
            round = $(this).parent().attr("id");
            matchNum = matchInfo.rounds[round].matches[index].matchNumber;
            team1 = $(".p1[matchNum=" + matchNum + "]").attr('id');
            team2 = $(".p2[matchNum=" + matchNum + "]").attr('id');
            
            /* PATH FOLLOWING TEAM
            if(team1 != ""){
            	 $( "div.p1:contains("+team1+")" ).css( "background-color", "pink");          	
            }
            
            if(team2 != ""){
           	 $( "div.p1:contains("+team2+")" ).css( "background-color", "green");          	
           }
                */         

            $(".p1[matchNum=" + matchNum + "]").css("color", "white");
            $(".p1[matchNum=" + matchNum + "]").css("background-color", "black");
            $(".p2[matchNum=" + matchNum + "]").css("color", "white");
            $(".p2[matchNum=" + matchNum + "]").css("background-color", "black");                  
            $("#matchNumber").html("Match #" + matchNum + "<br/>");
            $("#matchVersus").html("<div id='teamName1'>" + fmtName( matchInfo.rounds[round].matches[index].p1) + "</div> VS <div id='teamName2'> " + fmtName( matchInfo.rounds[round].matches[index].p2) + "</div>");
            $("#matchScore").html(fmtScore(matchInfo.rounds[round].matches[index].p1Score) + " - " + fmtScore(matchInfo.rounds[round].matches[index].p2Score) + "<br/>");
        });


        $(".match").on('mouseout', function() {
            $(".p1[matchNum=" + matchNum + "]").css("color", "black");
            $(".p1[matchNum=" + matchNum + "]").css("background-color", "#E0E0E0");
            $(".p2[matchNum=" + matchNum + "]").css("color", "black");
            $(".p2[matchNum=" + matchNum + "]").css("background-color", "#E0E0E0");
            /*
            if(team1 != ""){
           	 $( "div.p1:contains("+team1+")" ).css( "background-color", "#E0E0E0");          	
           }
           
           if(team2 != ""){
          	 $( "div.p1:contains("+team2+")" ).css( "background-color", "#E0E0E0");          	
          }
           
           */                
            $("#matchNumber").empty();
            $("#matchVersus").empty();
            $("#matchScore").empty();
        });
    	
    }
    
    
    
    


    function fmtScore(score) {
        if (score == null) {
            return '--';
        } else {
            return score;
        }
    }

    function fmtName(name) {
        if (name == null) {
            return 'TBD';
        } else {
            return name;
        }
    }

    function checkedAppend(rawHtml, appendTo) {
        var html = $(rawHtml);
        if (0 == html.length) {
            throw "Built ourselves bad html : " + rawHtml;
        }
        html.appendTo(appendTo);
        return html;
    }

    function createTeamList() {
        index = 1;
        for (j = 1; j <= num; j += 2) {
            team1 = $("#textbox" + (index)).val();
            index++;
            team2 = $("#textbox" + (index)).val();
            index++;
            teamInfo.team.push({
                name: team1,
            });

            teamInfo.team.push({
                name: team2,
            });
        }

        j = num / 2;
        index = 0;
        rounds = 1;
        switch (j) {
            case 1: //2 teams
                matchInfo.rounds.push({
                    "name": "Round1",
                    "matches": [{
                        "matchNumber": 1,
                        "matchIndex": 0,
                        "p1": teamInfo.team[index].name,
                        "p2": teamInfo.team[index + 1].name,
                        "p1Score": null,
                        "p2Score": null,
                    }]
                });
                break;
            case 1.5: //3 teams
                matchInfo.rounds.push({
                    "name": "Round" + (rounds++),
                    "matches": [{
                    	"matchIndex": 0,
                        "p1": teamInfo.team[index].name,
                        "p2": 'bye',
                    }, {
                        "matchNumber": 1,
                        "matchIndex": 1,
                        "p1": teamInfo.team[index + 1].name,
                        "p2": teamInfo.team[index + 2].name,
                        "p1Score": null,
                        "p2Score": null,

                    }, ]
                }, {
                    "name": "Round" + (rounds),
                    "matches": [{
                        "matchNumber": 2,
                        "matchIndex": 0,
                        "p1": teamInfo.team[0].name,
                        "p2": null,
                        "p1Score": null,
                        "p2Score": null,
                    }],


                });
                break;
            case 2: //4 teams

                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "matchNumber": 1,
                            "matchIndex": 0,
                            "p1": teamInfo.team[index].name,
                            "p2": teamInfo.team[index + 1].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 2,
                            "matchIndex": 1,
                            "p1": teamInfo.team[index + 2].name,
                            "p2": teamInfo.team[index + 3].name,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 3,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }

                );

                break;



            case 2.5: //5 teams            	
                matchInfo.rounds.push({
                       
                        "matches": [{
                        	"matchIndex": 0,
                            "p1": teamInfo.team[index].name,
                            "p2": "bye"
                        }, {
                            "matchNumber": 1,
                            "matchIndex": 1,
                            "p1": teamInfo.team[index + 1].name,
                            "p2": teamInfo.team[index + 2].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                        	"matchIndex": 2,
                            "p1": teamInfo.team[index + 3].name,
                            "p2": "bye"
                        }, {
                        	"matchIndex": 3,
                            "p1": teamInfo.team[index + 4].name,
                            "p2": "bye"
                        }]
                    }, {
                       
                        "matches": [{
                            "matchNumber": 2,
                            "matchIndex": 0,
                            "p1": teamInfo.team[0].name,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 3,
                            "matchIndex": 1,
                            "p1": teamInfo.team[3].name,
                            "p2": teamInfo.team[4].name,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }, {
                        
                        "matches": [{
                            "matchNumber": 4,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }

                );

                break;




            case 3: //6 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                        	"matchIndex": 0,
                            "p1": teamInfo.team[index].name,
                            "p2": "bye"
                        }, {
                            "matchNumber": 1,
                            "matchIndex": 1,
                            "p1": teamInfo.team[index + 1].name,
                            "p2": teamInfo.team[index + 2].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 2,
                            "matchIndex": 2,
                            "p1": teamInfo.team[index + 3].name,
                            "p2": teamInfo.team[index + 4].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                        	"matchIndex": 3,
                            "p1": teamInfo.team[index + 5].name,
                            "p2": "bye"
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 3,
                            "matchIndex": 0,
                            "p1": teamInfo.team[0].name,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 4,
                            "matchIndex": 1,
                            "p1": null,
                            "p2": teamInfo.team[5].name,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 5,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }

                );

                break;




            case 3.5: //7 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                        	"matchIndex": 0,
                            "p1": teamInfo.team[index].name,
                            "p2": "bye"
                        }, {
                            "matchNumber": 1,
                            "matchIndex": 1,
                            "p1": teamInfo.team[index + 1].name,
                            "p2": teamInfo.team[index + 2].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 2,
                            "matchIndex": 2,
                            "p1": teamInfo.team[index + 3].name,
                            "p2": teamInfo.team[index + 4].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 3,
                            "matchIndex": 3,
                            "p1": teamInfo.team[index + 5].name,
                            "p2": teamInfo.team[index + 6].name,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 4,
                            "matchIndex": 0,
                            "p1": teamInfo.team[0].name,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 5,
                            "matchIndex": 1,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 6,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }

                );

                break;




            case 4: //8 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "matchNumber": 1,
                            "matchIndex": 0,
                            "p1": teamInfo.team[index].name,
                            "p2": teamInfo.team[index + 1].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 2,
                            "matchIndex": 1,
                            "p1": teamInfo.team[index + 2].name,
                            "p2": teamInfo.team[index + 3].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 3,
                            "matchIndex": 2,
                            "p1": teamInfo.team[index + 4].name,
                            "p2": teamInfo.team[index + 5].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 4,
                            "matchIndex": 3,
                            "p1": teamInfo.team[index + 6].name,
                            "p2": teamInfo.team[index + 7].name,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 5,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 6,
                            "matchIndex": 1,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 7,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }

                );

                break;




            case 4.5: //9 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                        	"matchIndex": 0,
                            "p1": teamInfo.team[index].name,
                            "p2": "bye"
                        }, {
                            "matchNumber": 1,
                            "matchIndex": 1,
                            "p1": teamInfo.team[index + 1].name,
                            "p2": teamInfo.team[index + 2].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                        	"matchIndex": 2,
                            "p1": teamInfo.team[index + 3].name,
                            "p2": "bye"
                        }, {
                        	"matchIndex": 3,
                            "p1": teamInfo.team[index + 4].name,
                            "p2": "bye"
                        }, {
                        	"matchIndex": 4,
                            "p1": teamInfo.team[index + 5].name,
                            "p2": "bye"
                        }, {
                        	"matchIndex": 5,
                            "p1": teamInfo.team[index + 6].name,
                            "p2": "bye"
                        }, {
                        	"matchIndex": 6,
                            "p1": teamInfo.team[index + 7].name,
                            "p2": "bye"
                        }, {
                        	"matchIndex": 7,
                            "p1": teamInfo.team[index + 8].name,
                            "p2": "bye"
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 2,
                            "matchIndex": 0,
                            "p1": teamInfo.team[0].name,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 3,
                            "matchIndex": 1,
                            "p1": teamInfo.team[3].name,
                            "p2": teamInfo.team[4].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 4,
                            "matchIndex": 2,
                            "p1": teamInfo.team[5].name,
                            "p2": teamInfo.team[6].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 5,
                            "matchIndex": 3,
                            "p1": teamInfo.team[7].name,
                            "p2": teamInfo.team[8].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 6,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 7,
                            "matchIndex": 1,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 8,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }

                );

                break;




            case 5: //10 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                        	"matchIndex": 0,
                            "p1": teamInfo.team[index].name,
                            "p2": "bye"
                        }, {
                            "matchNumber": 1,
                            "matchIndex": 1,
                            "p1": teamInfo.team[index + 1].name,
                            "p2": teamInfo.team[index + 2].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                        	"matchIndex": 2,
                            "p1": teamInfo.team[index + 3].name,
                            "p2": "bye"
                        }, {
                        	"matchIndex": 3,
                            "p1": teamInfo.team[index + 4].name,
                            "p2": "bye"
                        }, {
                        	"matchNumber": 2,
                            "matchIndex": 4,
                            "p1": teamInfo.team[index + 6].name,
                            "p2": teamInfo.team[index + 7].name,
                            "p1Score": null,
                            "p2Score": null,                  	
                        	
                        }, {
                        	"matchIndex": 5,
                            "p1": teamInfo.team[index + 5].name,
                            "p2": "bye"
                            
                        }, {
                        	"matchIndex": 6,
                            "p1": teamInfo.team[index + 8].name,
                            "p2": "bye"
                        }, {
                        	"matchIndex": 7,
                            "p1": teamInfo.team[index + 9].name,
                            "p2": "bye"
                        }]
                    }, {
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "matchNumber": 3,
                            "matchIndex": 0,
                            "p1": teamInfo.team[0].name,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 4,
                            "matchIndex": 1,
                            "p1": teamInfo.team[3].name,
                            "p2": teamInfo.team[4].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 5,
                            "matchIndex": 2,
                            "p1": null,
                            "p2": teamInfo.team[5].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 6,
                            "matchIndex": 3,
                            "p1": teamInfo.team[8].name,
                            "p2": teamInfo.team[9].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, ]
                    }, {
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "matchNumber": 7,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 8,
                            "matchIndex": 1,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 9,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }

                );

                break;




            case 5.5: //11 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                        	"matchIndex": 0,
                            "p1": teamInfo.team[index].name,
                            "p2": "bye"
                        }, {
                            "matchNumber": 1,
                            "matchIndex": 1,
                            "p1": teamInfo.team[index + 1].name,
                            "p2": teamInfo.team[index + 2].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                        	"matchIndex": 2,
                            "p1": teamInfo.team[index + 3].name,
                            "p2": "bye"
                        }, {
                        	"matchIndex": 3,
                            "p1": teamInfo.team[index + 4].name,
                            "p2": "bye"
                        }, {
                        	 "matchNumber": 2,
                             "matchIndex": 4,
                             "p1": teamInfo.team[index + 6].name,
                             "p2": teamInfo.team[index + 7].name,
                             "p1Score": null,
                             "p2Score": null,
                        }, {
                        	"matchIndex": 5,                         
                            "p1": teamInfo.team[index + 5].name,
                            "p2": "bye"
                        }, {
                        	"matchIndex": 6,
                            "p1": teamInfo.team[index + 8].name,
                            "p2": "bye"
                        }, {
                            "matchNumber": 3,
                            "matchIndex": 7,
                            "p1": teamInfo.team[index + 9].name,
                            "p2": teamInfo.team[index + 10].name,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }, {
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "matchNumber": 4,
                            "matchIndex": 0,
                            "p1": teamInfo.team[0].name,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 5,
                            "matchIndex": 1,
                            "p1": teamInfo.team[3].name,
                            "p2": teamInfo.team[4].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 6,
                            "matchIndex": 2,
                            "p1": null,
                            "p2": teamInfo.team[5].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 7,
                            "matchIndex": 3,
                            "p1": teamInfo.team[8].name,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, ]
                    }, {
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "matchNumber": 8,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 9,
                            "matchIndex": 1,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 10,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }

                );

                break;




            case 6: //12 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "p1": teamInfo.team[index].name,
                            "p2": "bye"
                        }, {
                            "matchNumber": 1,
                            "matchIndex": 1,
                            "p1": teamInfo.team[index + 1].name,
                            "p2": teamInfo.team[index + 2].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "p1": teamInfo.team[index + 3].name,
                            "p2": "bye"
                        }, {
                            "matchNumber": 2,
                            "matchIndex": 3,
                            "p1": teamInfo.team[index + 4].name,
                            "p2": teamInfo.team[index + 5].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "p1": teamInfo.team[index + 6].name,
                            "p2": "bye"
                        }, {
                            "matchNumber": 3,
                            "matchIndex": 5,
                            "p1": teamInfo.team[index + 7].name,
                            "p2": teamInfo.team[index + 8].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "p1": teamInfo.team[index + 9].name,
                            "p2": "bye"
                        }, {
                            "matchNumber": 4,
                            "matchIndex": 7,
                            "p1": teamInfo.team[index + 10].name,
                            "p2": teamInfo.team[index + 11].name,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 5,
                            "matchIndex": 0,
                            "p1": teamInfo.team[0].name,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 6,
                            "matchIndex": 1,
                            "p1": teamInfo.team[3].name,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 7,
                            "matchIndex": 2,
                            "p1": teamInfo.team[6].name,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 8,
                            "matchIndex": 3,
                            "p1": teamInfo.team[9].name,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 9,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 10,
                            "matchIndex": 1,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 11,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }

                );

                break;




            case 6.5: //13 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "p1": teamInfo.team[index].name,
                            "p2": "bye"
                        }, {
                            "matchNumber": 1,
                            "matchIndex": 1,
                            "p1": teamInfo.team[index + 1].name,
                            "p2": teamInfo.team[index + 2].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 2,
                            "matchIndex": 2,
                            "p1": teamInfo.team[index + 3].name,
                            "p2": teamInfo.team[index + 4].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 3,
                            "matchIndex": 3,
                            "p1": teamInfo.team[index + 5].name,
                            "p2": teamInfo.team[index + 6].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "p1": teamInfo.team[index + 7].name,
                            "p2": "bye"
                        }, {
                            "matchNumber": 4,
                            "matchIndex": 5,
                            "p1": teamInfo.team[index + 8].name,
                            "p2": teamInfo.team[index + 9].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "p1": teamInfo.team[index + 10].name,
                            "p2": "bye"
                        }, {
                            "matchNumber": 5,
                            "matchIndex": 7,
                            "p1": teamInfo.team[index + 11].name,
                            "p2": teamInfo.team[index + 12].name,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 6,
                            "matchIndex": 0,
                            "p1": teamInfo.team[0].name,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 7,
                            "matchIndex": 1,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 8,
                            "matchIndex": 2,
                            "p1": teamInfo.team[7].name,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 9,
                            "matchIndex": 3,
                            "p1": teamInfo.team[10].name,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 10,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 11,
                            "matchIndex": 1,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 12,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }

                );

                break;


            case 7: //14 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "p1": teamInfo.team[index].name,
                            "p2": "bye"
                        }, {
                            "matchNumber": 1,
                            "matchIndex": 1,
                            "p1": teamInfo.team[index + 1].name,
                            "p2": teamInfo.team[index + 2].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 2,
                            "matchIndex": 2,
                            "p1": teamInfo.team[index + 3].name,
                            "p2": teamInfo.team[index + 4].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 3,
                            "matchIndex": 3,
                            "p1": teamInfo.team[index + 5].name,
                            "p2": teamInfo.team[index + 6].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "p1": teamInfo.team[index + 7].name,
                            "p2": "bye"
                        }, {
                            "matchNumber": 4,
                            "matchIndex": 5,
                            "p1": teamInfo.team[index + 8].name,
                            "p2": teamInfo.team[index + 9].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 5,
                            "matchIndex": 6,
                            "p1": teamInfo.team[index + 10].name,
                            "p2": teamInfo.team[index + 11].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 6,
                            "matchIndex": 7,
                            "p1": teamInfo.team[index + 12].name,
                            "p2": teamInfo.team[index + 13].name,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 7,
                            "matchIndex": 0,
                            "p1": teamInfo.team[0].name,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 8,
                            "matchIndex": 1,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 9,
                            "matchIndex": 2,
                            "p1": teamInfo.team[7].name,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 10,
                            "matchIndex": 3,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 11,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 12,
                            "matchIndex": 1,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 13,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }

                );

                break;



            case 7.5: //15 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "matchNumber": 1,
                            "matchIndex": 0,
                            "p1": teamInfo.team[index].name,
                            "p2": teamInfo.team[index + 1].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 2,
                            "matchIndex": 1,
                            "p1": teamInfo.team[index + 2].name,
                            "p2": teamInfo.team[index + 3].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 3,
                            "matchIndex": 2,
                            "p1": teamInfo.team[index + 4].name,
                            "p2": teamInfo.team[index + 5].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 4,
                            "matchIndex": 3,
                            "p1": teamInfo.team[index + 6].name,
                            "p2": teamInfo.team[index + 7].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 5,
                            "matchIndex": 4,
                            "p1": teamInfo.team[index + 8].name,
                            "p2": teamInfo.team[index + 9].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 6,
                            "matchIndex": 5,
                            "p1": teamInfo.team[index + 10].name,
                            "p2": teamInfo.team[index + 11].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 7,
                            "matchIndex": 6,
                            "p1": teamInfo.team[index + 12].name,
                            "p2": teamInfo.team[index + 13].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "p1": teamInfo.team[index + 14].name,
                            "p2": "bye"
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 8,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 9,
                            "matchIndex": 1,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 10,
                            "matchIndex": 2,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 11,
                            "matchIndex": 3,
                            "p1": null,
                            "p2": teamInfo.team[14].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 12,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 13,
                            "matchIndex": 1,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 14,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }

                );

                break;


            case 8: //16 teams
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "matchNumber": 1,
                            "matchIndex": 0,
                            "p1": teamInfo.team[index].name,
                            "p2": teamInfo.team[index + 1].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 2,
                            "matchIndex": 1,
                            "p1": teamInfo.team[index + 2].name,
                            "p2": teamInfo.team[index + 3].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 3,
                            "matchIndex": 2,
                            "p1": teamInfo.team[index + 4].name,
                            "p2": teamInfo.team[index + 5].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 4,
                            "matchIndex": 3,
                            "p1": teamInfo.team[index + 6].name,
                            "p2": teamInfo.team[index + 7].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 5,
                            "matchIndex": 4,
                            "p1": teamInfo.team[index + 8].name,
                            "p2": teamInfo.team[index + 9].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 6,
                            "matchIndex": 5,
                            "p1": teamInfo.team[index + 10].name,
                            "p2": teamInfo.team[index + 11].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 7,
                            "matchIndex": 6,
                            "p1": teamInfo.team[index + 12].name,
                            "p2": teamInfo.team[index + 13].name,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 8,
                            "matchIndex": 7,
                            "p1": teamInfo.team[index + 14].name,
                            "p2": teamInfo.team[index + 15].name,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 9,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 10,
                            "matchIndex": 1,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 11,
                            "matchIndex": 2,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 12,
                            "matchIndex": 3,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 13,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, {
                            "matchNumber": 14,
                            "matchIndex": 1,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "matchNumber": 15,
                            "matchIndex": 0,
                            "p1": null,
                            "p2": null,
                            "p1Score": null,
                            "p2Score": null,
                        }]
                    }

                );

                break;




        }

    }



    /******************************************************************************/
    /* 			Creates the bracket structure and displays it			        */
    /******************************************************************************/

    function renderBracket() {

        var base = $('#bracketContainer');
        var matchDivsByRound = [];
        matchNum = 1;
        for (var roundIndex = 0; roundIndex < matchInfo.rounds.length; roundIndex++) {

            var round = matchInfo.rounds[roundIndex];
            var bracket = checkedAppend('<div class="bracket" id=' + roundIndex + '></div>', base);
            var matchDivs = [];
            matchDivsByRound.push(matchDivs);

            //setup the match boxes round by round  
            for (var i = 0; i < round.matches.length; i++) {
                var vOffset = checkedAppend('<div></div>', bracket);

                var match = round.matches[i];

                if (fmtName(match.p1) == "bye" || fmtName(match.p2) == "bye") {
                    var matchHtml = '<div class="spacer"></div>';

                } else {
                    var matchHtml = '<div class="match"  id=' + match.matchIndex + '>' + '<div class="p1" matchNum=' + matchNum + ' id=' + fmtName(match.p1) + '>' + fmtName(match.p1) + '<div class="score" player="p1" contenteditable >' + fmtScore(match.p1Score) + '</div></div>' + '<div class="spacer"></div>' + '<div class="p2" matchNum=' + matchNum + ' id=' + fmtName(match.p2) + '>' + fmtName(match.p2) + '<div class="score" player="p2"  contenteditable >' + fmtScore(match.p2Score) + '</div></div>';
                    matchNum++;
                }

                matchDiv = checkedAppend(matchHtml, bracket);
                matchDivs.push(matchDiv);

                if (roundIndex > 0) {
                    //row 2+; line up with previous row  
                    var alignTo = matchDivsByRound[roundIndex - 1][i * 2];
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
                    var stretchTo = matchDivsByRound[roundIndex - 1][i * 2 + 1];
                    var newH = stretchTo.position().top + stretchTo.height() / 2 - matchDiv.position().top;
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
        genHook();
    }




    /******************************************************************************/
    /* 		Generate dropdown with numbers 1-16 for amount of team selection	  */
    /******************************************************************************/
    function fillNumTeams() {
        var $select = $("#numTeams");
        for (i = 1; i < 17; i++) {
            $select.append($('<option></option>').val(i).html(i))
        }
    }

    /******************************************************************************/
    /* 						Generate the array of team names					  */
    /******************************************************************************/
    function createTeams() {
        for (x = 1; x <= num; x++) {
            teams[x - 1] = $("#textbox" + x).val();
        }
    }
</script>
</head>
<body>
   <%@include file="/includes/header.jsp" %>
   <div id="wrapper">
      <!-- Sidebar -->
      <div id="sidebar-wrapper">
         <ul class="sidebar-nav">
            <li class="sidebar-brand" id="matchNumber"></li>
           	<li id="matchVersus"></li>  
           	<li id="matchScore"></li>                      
         </ul>
      </div>
      <!-- /#sidebar-wrapper -->
      <!-- Page Content -->
      <div id="page-content-wrapper" >
         <div class="container-fluid">
            <div class="row">
               <div class="col-lg-12">
                  <form id='numTeamsForm'>
                     How many Teams?
                     <select id="numTeams">
                     </select>
                  </form>
                  <br/><br/>           
                  <div class='teams' id='teamForm'></div>
                  
                  
                  <div><a href="#" class="btn btn-primary" id="genBracket">GENERATE BRACKET</a></div>
                  <div id="bracketContainer"  class="tournament"></div>
               </div>
            </div>
         </div>
      </div>
      <!-- /#page-content-wrapper -->
   </div>
   <!-- /#wrapper -->
</body>
</html>