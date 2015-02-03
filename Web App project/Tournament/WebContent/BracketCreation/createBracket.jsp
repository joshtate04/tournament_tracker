<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Bracket</title>
<%@include file="/includes/head.jsp" %>
<script type="text/javascript" src="/js/jquery.bracket.min.js"></script>
<script src="/js/underscore-min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/newBracket.css" />


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
        loadPage();
        fillNumTeams(); //Generate a dropdown with numbers to select amount of teams
        
        
         
        
       
        
        
        /*********************************************/
        /* 		Click event to generate bracket 	 */
        /*********************************************/
        $('#genBracket').click(function() {
            $('#bracketContainer').empty();
            $("#teamForm").hide();
            $("#genBracket").hide();
            createTeamList();
            renderBracket();
            $(".match").on('click',function(){
            	  alert("hey!");
            	});

        });
        
       
     

        /*********************************************/
        /* 		Create text boxes for team names	 */
        /*********************************************/
        $("#numTeams").change(function() {
            $('#numTeamsForm').hide();
            $("#genBracket").show();
            num = $(this).val();
            for (i = 1; i <= num; i++) {
                var newTextBoxDiv = $(document.createElement('div')).attr("id", 'team' + i);
                newTextBoxDiv.after().html('<label>Team ' + i + ' : </label>' + '<input type="text" name="textbox' + i + '" id="textbox' + i + '" value="" >');
                newTextBoxDiv.appendTo("#teamForm");
            }
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
                        "id": 1,
                        "p1": teamInfo.team[index].name,
                        "p2": teamInfo.team[index + 1].name,
                    }]
                });
                break;
            case 1.5:
                matchInfo.rounds.push({
                    "name": "Round" + (rounds++),
                    "matches": [{
                        "id": 1,
                        "p1": teamInfo.team[index].name,
                        "p2": 'bye',
                    }, {
                        "id": 2,
                        "p1": teamInfo.team[index + 1].name,
                        "p2": teamInfo.team[index + 2].name,
                    }]
                }, {
                    "name": "Round" + (rounds),
                    "matches": [{
                        "id": 3,
                        "p1": teamInfo.team[0].name,
                        "p2": null
                    }]
                });
                break;
            case 2: //4 teams

                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "id": 1,
                            "p1": teamInfo.team[index].name,
                            "p2": teamInfo.team[index + 1].name,
                        }, {
                            "id": 2,
                            "p1": teamInfo.team[index + 2].name,
                            "p2": teamInfo.team[index + 3].name,
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 3,
                            "p1": null,
                            "p2": null
                        }]
                    }

                );

                break;



            case 2.5: //5 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "id": 1,
                            "p1": teamInfo.team[index].name,
                            "p2": "bye"
                        }, {
                            "id": 2,
                            "p1": teamInfo.team[index + 1].name,
                            "p2": teamInfo.team[index + 2].name
                        }, {
                            "id": 3,
                            "p1": teamInfo.team[index + 3].name,
                            "p2": "bye"
                        }, {
                            "id": 4,
                            "p1": teamInfo.team[index + 4].name,
                            "p2": "bye"
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 5,
                            "p1": teamInfo.team[0].name,
                            "p2": null
                        }, {
                            "id": 6,
                            "p1": teamInfo.team[3].name,
                            "p2": teamInfo.team[4].name
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 7,
                            "p1": null,
                            "p2": null
                        }]
                    }

                );

                break;




            case 3: //6 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "id": 1,
                            "p1": teamInfo.team[index].name,
                            "p2": "bye"
                        }, {
                            "id": 2,
                            "p1": teamInfo.team[index + 1].name,
                            "p2": teamInfo.team[index + 2].name
                        }, {
                            "id": 3,
                            "p1": teamInfo.team[index + 3].name,
                            "p2": teamInfo.team[index + 4].name
                        }, {
                            "id": 4,
                            "p1": teamInfo.team[index + 5].name,
                            "p2": "bye"
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 5,
                            "p1": teamInfo.team[0].name,
                            "p2": null
                        }, {
                            "id": 6,
                            "p1": null,
                            "p2": teamInfo.team[5].name
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 7,
                            "p1": null,
                            "p2": null
                        }]
                    }

                );

                break;




            case 3.5: //7 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "id": 1,
                            "p1": teamInfo.team[index].name,
                            "p2": "bye"
                        }, {
                            "id": 2,
                            "p1": teamInfo.team[index + 1].name,
                            "p2": teamInfo.team[index + 2].name
                        }, {
                            "id": 3,
                            "p1": teamInfo.team[index + 3].name,
                            "p2": teamInfo.team[index + 4].name
                        }, {
                            "id": 4,
                            "p1": teamInfo.team[index + 5].name,
                            "p2": teamInfo.team[index + 6].name
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 5,
                            "p1": teamInfo.team[0].name,
                            "p2": null
                        }, {
                            "id": 6,
                            "p1": null,
                            "p2": null
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 7,
                            "p1": null,
                            "p2": null
                        }]
                    }

                );

                break;




            case 4: //8 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "id": 1,
                            "p1": teamInfo.team[index].name,
                            "p2": teamInfo.team[index + 1].name
                        }, {
                            "id": 2,
                            "p1": teamInfo.team[index + 2].name,
                            "p2": teamInfo.team[index + 3].name
                        }, {
                            "id": 3,
                            "p1": teamInfo.team[index + 4].name,
                            "p2": teamInfo.team[index + 5].name
                        }, {
                            "id": 4,
                            "p1": teamInfo.team[index + 6].name,
                            "p2": teamInfo.team[index + 7].name
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 5,
                            "p1": null,
                            "p2": null
                        }, {
                            "id": 6,
                            "p1": null,
                            "p2": null
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 7,
                            "p1": null,
                            "p2": null
                        }]
                    }

                );

                break;




            case 4.5: //9 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "id": 1,
                            "p1": teamInfo.team[index].name,
                            "p2": "bye"
                        }, {
                            "id": 2,
                            "p1": teamInfo.team[index + 1].name,
                            "p2": teamInfo.team[index + 2].name
                        }, {
                            "id": 3,
                            "p1": teamInfo.team[index + 3].name,
                            "p2": "bye"
                        }, {
                            "id": 4,
                            "p1": teamInfo.team[index + 4].name,
                            "p2": "bye"
                        }, {
                            "id": 5,
                            "p1": teamInfo.team[index + 5].name,
                            "p2": "bye"
                        }, {
                            "id": 6,
                            "p1": teamInfo.team[index + 6].name,
                            "p2": "bye"
                        }, {
                            "id": 7,
                            "p1": teamInfo.team[index + 7].name,
                            "p2": "bye"
                        }, {
                            "id": 8,
                            "p1": teamInfo.team[index + 8].name,
                            "p2": "bye"
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 9,
                            "p1": teamInfo.team[0].name,
                            "p2": null
                        }, {
                            "id": 10,
                            "p1": teamInfo.team[3].name,
                            "p2": teamInfo.team[4].name,
                        }, {
                            "id": 11,
                            "p1": teamInfo.team[5].name,
                            "p2": teamInfo.team[6].name,
                        }, {
                            "id": 12,
                            "p1": teamInfo.team[7].name,
                            "p2": teamInfo.team[8].name,
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
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
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 15,
                            "p1": null,
                            "p2": null
                        }]
                    }

                );

                break;




            case 5: //10 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "id": 1,
                            "p1": teamInfo.team[index].name,
                            "p2": "bye"
                        }, {
                            "id": 2,
                            "p1": teamInfo.team[index + 1].name,
                            "p2": teamInfo.team[index + 2].name
                        }, {
                            "id": 3,
                            "p1": teamInfo.team[index + 3].name,
                            "p2": "bye"
                        }, {
                            "id": 4,
                            "p1": teamInfo.team[index + 4].name,
                            "p2": "bye"
                        }, {
                            "id": 5,
                            "p1": teamInfo.team[index + 5].name,
                            "p2": "bye"
                        }, {
                            "id": 6,
                            "p1": teamInfo.team[index + 6].name,
                            "p2": teamInfo.team[index + 7].name,
                        }, {
                            "id": 7,
                            "p1": teamInfo.team[index + 8].name,
                            "p2": "bye"
                        }, {
                            "id": 8,
                            "p1": teamInfo.team[index + 9].name,
                            "p2": "bye"
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 9,
                            "p1": teamInfo.team[0].name,
                            "p2": null
                        }, {
                            "id": 10,
                            "p1": teamInfo.team[3].name,
                            "p2": teamInfo.team[4].name,
                        }, {
                            "id": 11,
                            "p1": teamInfo.team[5].name,
                            "p2": null
                        }, {
                            "id": 12,
                            "p1": teamInfo.team[8].name,
                            "p2": teamInfo.team[9].name,
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
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
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 15,
                            "p1": null,
                            "p2": null
                        }]
                    }

                );

                break;




            case 5.5: //11 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "id": 1,
                            "p1": teamInfo.team[index].name,
                            "p2": "bye"
                        }, {
                            "id": 2,
                            "p1": teamInfo.team[index + 1].name,
                            "p2": teamInfo.team[index + 2].name
                        }, {
                            "id": 3,
                            "p1": teamInfo.team[index + 3].name,
                            "p2": "bye"
                        }, {
                            "id": 4,
                            "p1": teamInfo.team[index + 4].name,
                            "p2": "bye"
                        }, {
                            "id": 5,
                            "p1": teamInfo.team[index + 5].name,
                            "p2": "bye"
                        }, {
                            "id": 6,
                            "p1": teamInfo.team[index + 6].name,
                            "p2": teamInfo.team[index + 7].name,
                        }, {
                            "id": 7,
                            "p1": teamInfo.team[index + 8].name,
                            "p2": "bye"
                        }, {
                            "id": 8,
                            "p1": teamInfo.team[index + 9].name,
                            "p2": teamInfo.team[index + 10].name,
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 9,
                            "p1": teamInfo.team[0].name,
                            "p2": null
                        }, {
                            "id": 10,
                            "p1": teamInfo.team[3].name,
                            "p2": teamInfo.team[4].name,
                        }, {
                            "id": 11,
                            "p1": teamInfo.team[5].name,
                            "p2": null
                        }, {
                            "id": 12,
                            "p1": teamInfo.team[8].name,
                            "p2": null
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
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
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 15,
                            "p1": null,
                            "p2": null
                        }]
                    }

                );

                break;




            case 6: //12 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "id": 1,
                            "p1": teamInfo.team[index].name,
                            "p2": "bye"
                        }, {
                            "id": 2,
                            "p1": teamInfo.team[index + 1].name,
                            "p2": teamInfo.team[index + 2].name
                        }, {
                            "id": 3,
                            "p1": teamInfo.team[index + 3].name,
                            "p2": "bye"
                        }, {
                            "id": 4,
                            "p1": teamInfo.team[index + 4].name,
                            "p2": teamInfo.team[index + 5].name,
                        }, {
                            "id": 5,
                            "p1": teamInfo.team[index + 6].name,
                            "p2": "bye"
                        }, {
                            "id": 6,
                            "p1": teamInfo.team[index + 7].name,
                            "p2": teamInfo.team[index + 8].name,
                        }, {
                            "id": 7,
                            "p1": teamInfo.team[index + 9].name,
                            "p2": "bye"
                        }, {
                            "id": 8,
                            "p1": teamInfo.team[index + 10].name,
                            "p2": teamInfo.team[index + 11].name,
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 9,
                            "p1": teamInfo.team[0].name,
                            "p2": null
                        }, {
                            "id": 10,
                            "p1": teamInfo.team[3].name,
                            "p2": null
                        }, {
                            "id": 11,
                            "p1": teamInfo.team[6].name,
                            "p2": null
                        }, {
                            "id": 12,
                            "p1": teamInfo.team[9].name,
                            "p2": null
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
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
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 15,
                            "p1": null,
                            "p2": null
                        }]
                    }

                );

                break;




            case 6.5: //13 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "id": 1,
                            "p1": teamInfo.team[index].name,
                            "p2": "bye"
                        }, {
                            "id": 2,
                            "p1": teamInfo.team[index + 1].name,
                            "p2": teamInfo.team[index + 2].name
                        }, {
                            "id": 3,
                            "p1": teamInfo.team[index + 3].name,
                            "p2": teamInfo.team[index + 4].name,
                        }, {
                            "id": 4,
                            "p1": teamInfo.team[index + 5].name,
                            "p2": teamInfo.team[index + 6].name,
                        }, {
                            "id": 5,
                            "p1": teamInfo.team[index + 7].name,
                            "p2": "bye"
                        }, {
                            "id": 6,
                            "p1": teamInfo.team[index + 8].name,
                            "p2": teamInfo.team[index + 9].name,
                        }, {
                            "id": 7,
                            "p1": teamInfo.team[index + 10].name,
                            "p2": "bye"
                        }, {
                            "id": 8,
                            "p1": teamInfo.team[index + 11].name,
                            "p2": teamInfo.team[index + 12].name,
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 9,
                            "p1": teamInfo.team[0].name,
                            "p2": null
                        }, {
                            "id": 10,
                            "p1": null,
                            "p2": null
                        }, {
                            "id": 11,
                            "p1": teamInfo.team[7].name,
                            "p2": null
                        }, {
                            "id": 12,
                            "p1": teamInfo.team[10].name,
                            "p2": null
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
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
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 15,
                            "p1": null,
                            "p2": null
                        }]
                    }

                );

                break;


            case 7: //14 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "id": 1,
                            "p1": teamInfo.team[index].name,
                            "p2": "bye"
                        }, {
                            "id": 2,
                            "p1": teamInfo.team[index + 1].name,
                            "p2": teamInfo.team[index + 2].name
                        }, {
                            "id": 3,
                            "p1": teamInfo.team[index + 3].name,
                            "p2": teamInfo.team[index + 4].name,
                        }, {
                            "id": 4,
                            "p1": teamInfo.team[index + 5].name,
                            "p2": teamInfo.team[index + 6].name,
                        }, {
                            "id": 5,
                            "p1": teamInfo.team[index + 7].name,
                            "p2": "bye"
                        }, {
                            "id": 6,
                            "p1": teamInfo.team[index + 8].name,
                            "p2": teamInfo.team[index + 9].name,
                        }, {
                            "id": 7,
                            "p1": teamInfo.team[index + 10].name,
                            "p2": teamInfo.team[index + 11].name,
                        }, {
                            "id": 8,
                            "p1": teamInfo.team[index + 12].name,
                            "p2": teamInfo.team[index + 13].name,
                        }]
                    }, {
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 9,
                            "p1": teamInfo.team[0].name,
                            "p2": null
                        }, {
                            "id": 10,
                            "p1": null,
                            "p2": null
                        }, {
                            "id": 11,
                            "p1": teamInfo.team[7].name,
                            "p2": null
                        }, {
                            "id": 12,
                            "p1": null,
                            "p2": null
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
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
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 15,
                            "p1": null,
                            "p2": null
                        }]
                    }

                );

                break;



            case 7.5: //15 teams            	
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "id": 1,
                            "p1": teamInfo.team[index].name,
                            "p2": teamInfo.team[index + 1].name
                        }, {
                            "id": 2,
                            "p1": teamInfo.team[index + 2].name,
                            "p2": teamInfo.team[index + 3].name
                        }, {
                            "id": 3,
                            "p1": teamInfo.team[index + 4].name,
                            "p2": teamInfo.team[index + 5].name,
                        }, {
                            "id": 4,
                            "p1": teamInfo.team[index + 6].name,
                            "p2": teamInfo.team[index + 7].name,
                        }, {
                            "id": 5,
                            "p1": teamInfo.team[index + 8].name,
                            "p2": teamInfo.team[index + 9].name,
                        }, {
                            "id": 6,
                            "p1": teamInfo.team[index + 10].name,
                            "p2": teamInfo.team[index + 11].name,
                        }, {
                            "id": 7,
                            "p1": teamInfo.team[index + 12].name,
                            "p2": teamInfo.team[index + 13].name,
                        }, {
                            "id": 8,
                            "p1": teamInfo.team[index + 14].name,
                            "p2": "bye"
                        }]
                    }, {
                        "name": "Round" + (rounds),
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
                            "p2": teamInfo.team[14].name,
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
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
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 15,
                            "p1": null,
                            "p2": null
                        }]
                    }

                );

                break;


            case 8:
                matchInfo.rounds.push({
                        "name": "Round" + (rounds++),
                        "matches": [{
                            "id": 1,
                            "p1": teamInfo.team[index].name,
                            "p2": teamInfo.team[index + 1].name
                        }, {
                            "id": 2,
                            "p1": teamInfo.team[index + 2].name,
                            "p2": teamInfo.team[index + 3].name
                        }, {
                            "id": 3,
                            "p1": teamInfo.team[index + 4].name,
                            "p2": teamInfo.team[index + 5].name,
                        }, {
                            "id": 4,
                            "p1": teamInfo.team[index + 6].name,
                            "p2": teamInfo.team[index + 7].name,
                        }, {
                            "id": 5,
                            "p1": teamInfo.team[index + 8].name,
                            "p2": teamInfo.team[index + 9].name,
                        }, {
                            "id": 6,
                            "p1": teamInfo.team[index + 10].name,
                            "p2": teamInfo.team[index + 11].name,
                        }, {
                            "id": 7,
                            "p1": teamInfo.team[index + 12].name,
                            "p2": teamInfo.team[index + 13].name,
                        }, {
                            "id": 8,
                            "p1": teamInfo.team[index + 14].name,
                            "p2": teamInfo.team[index + 15].name,
                        }]
                    }, {
                        "name": "Round" + (rounds),
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
                        }, ]
                    }, {
                        "name": "Round" + (rounds),
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
                        "name": "Round" + (rounds),
                        "matches": [{
                            "id": 15,
                            "p1": null,
                            "p2": null
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

        for (var roundIndex = 0; roundIndex < matchInfo.rounds.length; roundIndex++) {
            var round = matchInfo.rounds[roundIndex];
            var bracket = checkedAppend('<div class="bracket"></div>', base);
            var matchDivs = [];
            matchDivsByRound.push(matchDivs);

            //setup the match boxes round by round  
            for (var i = 0; i < round.matches.length; i++) {
                var vOffset = checkedAppend('<div></div>', bracket);

                var match = round.matches[i];
             
                  if(fmtName(match.p1) == "bye" || fmtName(match.p2) == "bye"  ){
                	  var matchHtml = '<div  id="match' + match.id + '">' + '<div ></div>' + '<div class="spacer"></div>' ;                	  
                	 
                  }else{                	  
                	  var matchHtml = '<div class="match" id="match' + match.id + '">' + '<div class="p1">' + fmtName(match.p1) + '</div>' + '<div class="spacer"></div>' + '<div class="p2">' + fmtName(match.p2) + '</div>';                	  
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
   <form id='numTeamsForm'>
      How many Teams?
      <select id="numTeams">
      </select>
   </form>
   <br/><br/>
   
   <div class='teams' id='teamForm'></div>
   <div><a href="#" class="btn btn-primary" id="genBracket">GENERATE BRACKET</a></div>
   <div id="bracketContainer" class="tournament"></div> 
</body>
</html>

