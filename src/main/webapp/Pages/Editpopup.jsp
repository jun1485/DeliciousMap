<%@page import="DMDB.Element"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<%@ page import="DMDB.ScheduleDbControl"%>
<%@ page import="DMDB.Schedule"%>
<html>
    <head>
        <meta charset="utf-8">
        <title>스케줄 편집</title>
        <style>
            html, body{
                font-family: 'Noto Sans KR', sans-serif;
                margin: 0;
                padding: 0.5em;
                height: 100%;
                overflow: hidden;
            }
            div{
                display: block;
            }
            #cTitle{
                font-weight: bold;
                position: relative;
                color:black;
                background-color: #F47521;
                padding:0.5em;
                height: auto;
                border-radius: 0.5em;
            }
            .Btn{
                float: right;
                border:none;
                outline: none;  
                padding: 0.5em 1em 0.5em 1em;
                margin: 0.5em;
                background-color: black;
                color: white;
                border-radius: 2em;
            }
            td {
                vertical-align: middle;
                padding: 0.5em;
            }
            img { display: block; margin: 0px auto; }
        </style>
    </head>
    <body>
        <script type="text/javascript">
            var prt_title = ""; //넘겨받은 타이틀(장소이름) 저장용

            //url로 넘겨진 파라메터에서 타이틀 분리해서 저장
            window.onload = function(){
            	<%
            	int start_time = Integer.parseInt(request.getParameter("start"));
            	int end_time = Integer.parseInt(request.getParameter("end"));
            	ArrayList<Schedule> schedules = null;
            	schedules = (ArrayList<Schedule>) session.getAttribute("schedules");
            	int dayCount;
            	dayCount = Integer.parseInt(request.getParameter("dayCount"));
            	Element element = schedules.get(dayCount).getElementByStart(start_time);
            	String title = element.getName();
            	double lat = element.getGP().getLatitude();
            	double lng = element.getGP().getLongitude();
            	%>
            	prt_title = "<%=title%>";
               	//var tmp = decodeURI(window.location);
                //var title = tmp.split('?');
                document.getElementById('cTitle').innerHTML= prt_title;
                //prt_title = title[1];
                lat = <%=lat%>;
                lng = <%=lng%>;
                dayCount = <%=dayCount%>;
                
                setBox(<%=start_time%>, <%=end_time%>);
            }
            function setValue(){
                //시작, 마침 시간 검사용
                var S_target = document.getElementById("start_time");
                var E_target = document.getElementById("end_time");

                var start = parseInt(S_target.value);
                var end = parseInt(E_target.value);
                
                if(!(end>start)){
                    alert("마침 시간이 시작 시간보다 커야합니다.");
                    return;
                }
                
                <% 
                boolean [] checker = schedules.get(dayCount).getTimeChecker();%>
                
                const checker = [];
                
                <%
                for(int i = 0; i < 24; i++){
                	if(i >= start_time && i < end_time){
                		%>
                		checker.push(false);
                		<%
                	}
                	else{
                	%>
                	checker.push(<%=checker[i]%>);
                	<%
                	}
                }
                %>
                
                for(var se = start; se < end; se++){
                	if(checker[se] == true){
                		alert("이미 존재하는 시간 입니다.");
                        return;
                	}
                }
                
        		var sAP = "AM";
        		var eAP = "AM";
        		var dis_start = start;
        		var dis_end = end;
        		if(start > 11){
        			sAP = "PM"; 4
        			if(start > 12)
        				dis_start = start - 12;
        		}
        		if(end > 11){
        			eAP = "PM"; 
        			if(end > 12)
        				dis_end = end - 12;
        		}
                //"시작시간 ~ 마침시간" 으로 표시하는 용
               var display_time = sAP + "<br>" + dis_start + "<br>~<br>" + eAP +"<br>" + dis_end;
               <%
               schedules.get(dayCount).deleteElement(start_time);
               %>
               opener.parent.del_original("index" + <%=start_time%>, <%=start_time%>, <%=end_time%>);
               window.location="saveNewElement.jsp?start=" + start + "&end=" + end + "&prt_title=" + prt_title
                		+ "&lat=" + lat + "&lng=" + lng + "&dayCount=" + dayCount;
                
                //부모창의 함수(add_schedule)를 컨트롤해서 인수 전달
                opener.parent.add_schedule(start, end, display_time, prt_title);
                
                window.close();
            }
            
            function setBox(start, end) {
				start_box = document.getElementById("start_time");
				end_box = document.getElementById("end_time");
				start_box.options[start].selected = true;
				end_box.options[end].selected = true;
			}
            
        </script>
            <div style="margin: 0 auto; width: 80%;">
                <div id="cTitle">
                    장소 이름
                </div>
                <div>
                    <table>
                        <tr>
                            <td>
                                <img src="img/calendar_icon.png" alt="Time" width="20px" height="20px">
                            </td>
                            <td>
                                <%=schedules.get(dayCount).getDateString()%> <!-- 현재 날짜 넣어주세요 수정 불가. 표시용임-->
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <img src="img/clock_icon.png" alt="Time" width="20px" height="20px">
                            </td>
                            <td>
                                <label for="start"></label>
                                <select id="start_time" name="start">
                                    <option value="0" selected="selected">00:00</option>
                                    <option value="1">01:00</option>
                                    <option value="2">02:00</option>
                                    <option value="3">03:00</option>
                                    <option value="4">04:00</option>
                                    <option value="5">05:00</option>
                                    <option value="6">06:00</option>
                                    <option value="7">07:00</option>
                                    <option value="8">08:00</option>
                                    <option value="9">09:00</option>
                                    <option value="10">10:00</option>
                                    <option value="11">11:00</option>
                                    <option value="12">12:00</option>
                                    <option value="13">13:00</option>
                                    <option value="14">14:00</option>
                                    <option value="15">15:00</option>
                                    <option value="16">16:00</option>
                                    <option value="17">17:00</option>
                                    <option value="18">18:00</option>
                                    <option value="19">19:00</option>
                                    <option value="20">20:00</option>
                                    <option value="21">21:00</option>
                                    <option value="22">22:00</option>
                                    <option value="23">23:00</option>
                                </select>
                                ~
                                <label for="end"></label>
                                <select id="end_time" name="end">
                                    <option value="0" selected="selected">00:00</option>
                                    <option value="1">01:00</option>
                                    <option value="2">02:00</option>
                                    <option value="3">03:00</option>
                                    <option value="4">04:00</option>
                                    <option value="5">05:00</option>
                                    <option value="6">06:00</option>
                                    <option value="7">07:00</option>
                                    <option value="8">08:00</option>
                                    <option value="9">09:00</option>
                                    <option value="10">10:00</option>
                                    <option value="11">11:00</option>
                                    <option value="12">12:00</option>
                                    <option value="13">13:00</option>
                                    <option value="14">14:00</option>
                                    <option value="15">15:00</option>
                                    <option value="16">16:00</option>
                                    <option value="17">17:00</option>
                                    <option value="18">18:00</option>
                                    <option value="19">19:00</option>
                                    <option value="20">20:00</option>
                                    <option value="21">21:00</option>
                                    <option value="22">22:00</option>
                                    <option value="23">23:00</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="padding: 0.5em;">
                    <button class="Btn" onclick="window.close();">취소</button>
                    <button class="Btn" onclick="setValue();">추가</button>
                </div>
            </div>
    </body>
</html>