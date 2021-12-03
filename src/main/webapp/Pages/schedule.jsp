<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="DMDB.Schedule" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link rel="stylesheet" href="practice.css" />
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
        <meta charset="utf-8">
        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=95722007ca7e14b3740605bd8bf9389a&libraries=services"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <title>스케줄 편집</title>
        <style>
            html, body{font-family: 'Noto Sans KR', sans-serif; width: 100%; height: 100%; margin:0;padding:0; overflow: hidden;}
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:70%;height:100%;float:right;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
.Left{position:relative;width:30%;height:100%;}
.STitle{background-color: white; width: 100%; height: auto; padding: 0.5em;}
.schedule_element{
    display: block;
    margin: 10px;
    border-radius : 0.5em;
    background-color :white;
}
#date_box{
    text-align: center;
    padding: 1em;
}
.time{
    width: 25%;
    font-size: small;
    padding: 1em;
    border-radius : 0.5em;
    background-color: black;
    color:white;
}
.bar{
    text-align: right;
    background-color: #eec551;
    padding: 0.2em;
    border-radius: 0.5em;
}
.Etitle{
    font-weight:bold;
    margin-bottom: -1em;
    padding: 0.5em;
}
.Btns{
    text-align: right;
}
.Ebtn{
    border:none;
    outline: none;
    margin: 0.5em;
    padding: 0.5em 1em 0.5em 1em;
    background-color: #F47521;
    border-radius: 2em;
}
.Tbtn{
    font-weight: bolder;
    border:none;
    outline: none;
    margin: 0.5em;
    padding: 0.5em 0.8em 0.5em 0.8em;
    background-color: white;
    border-radius: 2em;
}

.customOverlay{
    position: relative;
    padding : 0.5em;
    background-color: #F47521;
    border-radius: 1em;
    bottom: 10em;
}
.Title_customOverlay{
    font-weight:bold;
    margin: 0.5em;
    padding : 0.5em;
    border-radius: 0.5em;
    background-color: white;
}
.img_customOverlay{
    margin: 0.5em;
    padding : 1em;
    border-radius: 0.5em;
    background-color: white;
}
.CBtn{
    border:none;
    outline: none;
    margin: 0.5em;
    padding: 0.5em 1em 0.5em 1em;
    background-color: black;
    color: white;
    border-radius: 2em;
}
.ABtn{
    border:none;
    outline: none;
    margin: 0.5em;
    padding: 0.5em 1em 0.5em 1em;
    background-color: white;
    border-radius: 2em;
}
.SBtn{
    border:none;
    outline: none;
    margin: 1em;
    padding: 0.5em 1em 0.5em 1em;
    color: white;
    background-color: black;
    border-radius: 2em;
}
img{
    padding: 1em;
    width: 1em;
    height: 1em;
}
.img_overlay {
	width: 10vw;
	height: 10vw;
	object-fit: fill;
}
        </style>
    </head>
    <body>
    <%
	ArrayList<Schedule> s = (ArrayList<Schedule>) session.getAttribute("schedules");
	int dayCount = 0;
	%>
    <header class="header nav-header">
        <img
            class="header__icon-logo"
              src="img/nav_logo.png"
              alt="맛있는지도"
            />
        <div class="header__menu">
          <span class="header__menu__schedule header__menu__item">일정관리</span>
          <span class="header__menu__map header__menu__item">지도탐색</span>
          <span class="header__menu__board header__menu__item">게시판</span>
          <span class="header__menu__my-page header__menu__item">마이페이지</span>
          <div class="header__menu__log-out header__menu__item">로그아웃</div>
        </div>
      </header>
	    <div class="map_wrap">
            <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
            <div id="menu_wrap" class="bg_white">
                <div class="option">
                    <div>
                        <form onsubmit="searchPlaces(); return false;">
                            키워드 : <input type="text" value="영남대" id="keyword" size="15"> 
                            <button type="submit">검색하기</button> 
                        </form>
                    </div>
                </div>
                <hr>
                <ul id="placesList"></ul>
                <div id="pagination"></div>
            </div>
        </div>
        <div class="Left">
            <div class="STitle"><%=s.get(0).getName() %><button class="SBtn" onclick="location.href='addAllElements.jsp'" style="float: right;">저장</button></div>
            <div style="width:100%;height:100%;position:relative;overflow:auto;background-color:#F47521;">
                <div id="date_box">
                    <button class="Tbtn" onclick="set_schedule(-1)" id="leftBtn" disabled>&lt;</button>
                    <div id="date" style="color: white; display: inline-block;"></div>
                    <button class="Tbtn" onclick="set_schedule(1)" id="rightBtn">&gt;</button>
                </div>
                <div id="schedule_list"></div>
            </div>
        </div>
        
<script type="text/javascript">
const dateStringArray = [];			// 날짜들을 String 형태로 순서대로 넣을 배열

const divArray = [];					// div들을 넣어놓기 위한 배열

var dayCount = 0;					// 현재 화면에 표시할 날짜 count

const checkDiv = [];				//저장된 요소들의 start 시간들이 저장될 배열

<%
int max = s.size();
for(int i = 0; i < s.size(); i++){
	%>
	dateStringArray.push("<%=s.get(i).getDateString()%>");
	divArray.push(new Array);					// 날짜 만큼의 배열
	checkDiv.push(new Array);
	<%
}
for(int i =0; i < s.size(); i++){
	Schedule schedule = s.get(i);
	for(int j = 0; j < schedule.getElementCount(); j++){
		%>
		var title = '<%=schedule.getElementI(j).getName()%>'
		var start = <%=schedule.getElementI(j).getStartTime()%>
		var end = <%=schedule.getElementI(j).getEndTime()%>
		var sAP = "AM";
		var eAP = "AM";
		var dis_start = start;
		var dis_end = end;
		if(start > 11){
			sAP = "PM"; 
			if(start > 12)
				dis_start = start - 12;
		}
		if(end > 11){
			eAP = "PM"; 
			if(end > 12)
				dis_end = end - 12;
		}
			
		var display_time = sAP + "<br>" + dis_start + "<br>~<br>" + eAP +"<br>" + dis_end;
		var elem_id = "index" + start; //스케줄 요소 CSS에 ID를 부여한다 (예) : index0
   	 	//tmp는 스케줄요소입니다. 수정, 삭제 버튼이 포함됨
   	 	var tmp = "<div class='schedule_element' id='"+elem_id+"'><table style='width:100%'><tr><td class='time' rowspan='2'>"+display_time+"</td>";
        tmp += "<td><div class='Etitle'>"+title+"<br><div class='Escore'></div></div></td><td class='bar' rowspan='2'> </td></tr>";
        tmp += "<tr><td><div class='Btns'><img onclick='open_Epop("+start+","+end+");' src='img/edit.png'></img>";
        tmp += "<img onclick='del_schedule("+elem_id+","+start+","+end+");' src='img/del.png'></img></div></td></tr></table></div>";
    	divArray[<%=i%>].push(tmp);
    	checkDiv[<%=i%>].push(start);
    	<%
	}
}
%> 

function set_schedule(count){
	removeAllElements();
	
	console.log(<%=max%>);
	
	dayCount += count;
	console.log(dayCount);
	if(dayCount <= 0){
		document.getElementById("leftBtn").disabled = true;
		document.getElementById("rightBtn").disabled = false;
	}
	else if(dayCount >= <%=max%>-1){
		document.getElementById("rightBtn").disabled = true;
		document.getElementById("leftBtn").disabled = false;
	}
	else{
		document.getElementById("leftBtn").disabled = false;
		document.getElementById("rightBtn").disabled = false;
	}
	setDate();
	addAllElements();
}

function removeAllElements(){			// 이미 존재하는 화면의 요소들을 제거
	var schedule_list = document.getElementById("schedule_list");
	for(var i = 0; i < checkDiv[dayCount].length; i++){
		
		var tmp = "index" + checkDiv[dayCount][i];
		var tmp_div = document.getElementById(tmp);
		schedule_list.removeChild(tmp_div);
	}
}

function addAllElements(){		// count에 해당하는 날짜의 요소들을 불러옴
	for(var i = 0; i < divArray[dayCount].length; i++){
		document.getElementById('schedule_list').innerHTML += divArray[dayCount][i];
	}
}

function setDate(){					// 화면에 나타나는 날짜를 설정하는 함수
	var dateDiv = document.getElementById("date");
	dateDiv.innerText = dateStringArray[dayCount];
}

addAllElements(); // 초기 데이터 표시
setDate(0);			// 초기 날짜 설정
//customOverlay 변수를 카카오의 오버레이 타입으로 정의
var customOverlay = new kakao.maps.CustomOverlay();

// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {   

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for(var i=0;i<places.length;i++){

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, place) {
            kakao.maps.event.addListener(marker, 'click', function() {
                RunOverlay(place, marker.getPosition().getLat(), marker.getPosition().getLng());
                //displayInfowindow(marker, title);
            });

            //kakao.maps.event.addListener(marker, 'mouseout', function() {
                //RunOverlay(title, marker.getPosition().getLat(), marker.getPosition().getLng());
                //infowindow.close();
            //});

            itemEl.onclick =  function () {
                RunOverlay(place, marker.getPosition().getLat(), marker.getPosition().getLng());
                //displayInfowindow(marker, title);
            };

            itemEl.onmouseout =  function () {
                //infowindow.close();
            };
        })(marker, places[i]);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds); 
} 

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage,
            zIndex: 3
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

//마커 클릭 시에 좌표를 반환합니다
function SendLocation(Lat, Lng){
    document.getElementById("showElm").innerHTML = "위도 : " + Lat + '<br>' + "경도 : " + Lng + '<br>';
    console.log(Lat);
    console.log(Lng);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}

//popup.jsp를 팝업으로 열어 타이틀(장소이름)을 함께 전달
function open_pop(title, lat, lng, r_num, code){
    window.name = "schedule.jsp";
    var isRes = false;
    if(code == "FD6" || code == "CE7")
    	isRes = true;
    var url = 'popup.jsp?title='+ title + "&lat=" + lat + "&lng=" + lng + "&dayCount=" + dayCount + "&r_num=" + r_num + "&isRes=" + isRes;		// jsp가 받을 수 있도록 형식 변경
    window.open(url,'스케줄',"width=600, height=300");
}

//수정용 팝업창 열기(미완)
function open_Epop(start, end){
    window.name = "schedule.jsp";
    var url = 'Editpopup.jsp?start='+ start + "&end=" + end + "&dayCount=" + dayCount;
    window.open(url,'스케줄',"width=600, height=300");
}

function open_delPop(start){
	window.name = "schedule.jsp";
    var url = 'deleteElement.jsp?start='+ start + "&dayCount=" + dayCount;
    window.open(url,'',"width=5, height=5");
}

//새로운 스케줄을 추가하기
function add_schedule(start, end, display_time, title){
    var elem_id = "index" + start; //스케줄 요소 CSS에 ID를 부여한다 (예) : index0
    //tmp는 스케줄요소입니다. 수정, 삭제 버튼이 포함됨
    var tmp = "<div class='schedule_element' id='"+elem_id+"'><table style='width:100%'><tr><td class='time' rowspan='2'>"+display_time+"</td>";
        tmp += "<td><div class='Etitle'>"+title+"<br><div class='Escore'></div></div></td><td class='bar' rowspan='2'> </td></tr>";
        tmp += "<tr><td><div class='Btns'><img onclick='open_Epop("+start+","+end+");' src='img/edit.png'></img>";
        tmp += "<img onclick='del_schedule("+elem_id+","+start+","+end+");' src='img/del.png'></img></div></td></tr></table></div>";
        
    document.getElementById('schedule_list').innerHTML += tmp; //schedule_list라는 div 안에 스케줄요소를 더한다
    if(checkDiv[dayCount].length == 0){			// 설정한 요소가 하나도 없으면
    	checkDiv[dayCount].push(start);				// div 위치는 그대로, checkDiv 배열에 start 추가
    	divArray[dayCount].push(tmp);
    }
	else {
			var content = document.getElementById(elem_id);		// div 정보를 content에 넣음
			var list = document.getElementById("schedule_list");	// schedule_list 정보를 list에 넣음
			var c = 0;
			for (; c < checkDiv[dayCount].length; c++) {								// checkDiv 배열의 길이만큼 반복문을 돈다
				if (start < checkDiv[dayCount][c]) {										// 추가할 요소의 시작시간보다 늦은 시작시간을 만나게 되면 
					var target_id = "index" + checkDiv[dayCount][c];				// 해당 타겟 시간의 아이디 설정
					var target = document.getElementById(target_id);	// 타겟 아이디로 타겟 div를 불러옴
					list.insertBefore(content, target);						// 해당 div 위에 추가할 div 위치
					checkDiv[dayCount].splice(c, 0, start);									// 배열의 현재 위치에 추가할 요소의 시작시간 추가
					divArray[dayCount].splice(c, 0, tmp);
					break;						
				}
			}
			if(c == checkDiv[dayCount].length){										// 현재 존재하는 요소중 가장 늦은 시간의 요소면
				checkDiv[dayCount].push(start);											// div는 그대로 마지막에 나두고 배열의 끝에 시작시간 추가
				divArray[dayCount].push(tmp);
			}
		}
    console.log(checkDiv);
    console.log(divArray);
	}

	//스케줄 요소 삭제
	function del_schedule(id, start, end) {
		if (!confirm("정말 삭제하시겠습니까?")) {
			return;
		} else {
			//스케줄 삭제하니까 배열에 반영
			for(var i = 0; i < checkDiv[dayCount].length; i++){
				if(start == checkDiv[dayCount][i]){
					checkDiv[dayCount].splice(i, 1);
					divArray[dayCount].splice(i, 1);
					break;
				}
			}
			open_delPop(start);
			id.remove();
			alert("삭제되었습니다.");
		}
	}
	
	function del_original(id, start, end){
		console.log(checkDiv);
		console.log(divArray);
		console.log(id);
		for(var i = 0; i < checkDiv[dayCount].length; i++){
			if(start == checkDiv[dayCount][i]){
				checkDiv[dayCount].splice(i, 1);
				divArray[dayCount].splice(i, 1);
				break;
			}
		}
		var tmp = document.getElementById(id);
		console.log(tmp);
		tmp.remove();
	}

	//오버레이 실행
    function RunOverlay(place, lat, lng){
        CloseOverlay(); //기존 오버레이를 초기화
        console.log(place);
        const title = place.place_name;
        const id = place.id;
        const code = place.category_group_code;
        var tmp = '<div class="customOverlay">'
			+ '<div class="Title_customOverlay" onclick="open_detail(&quot;'
			+ id
			+ '&quot;,&quot;'
			+ title
			+ '&quot;,'
			+ lat
			+ ','
			+ lng
			+ ',&quot;'
			+ code
			+ '&quot;)">'
			+ title
			+ '</div>'
			+ '<div class="img_customOverlay" onclick="open_detail(&quot;'
			+ id + '&quot;,&quot;' + title + '&quot;,' + lat + ',' + lng + ',&quot;' + code + '&quot;'
			+ ')"><img class="img_overlay" id="img_overlay" alt="IMG"></img></div>';
        tmp += '<div class="Btns"><button onclick="open_pop(`'+title+'`,'+lat+','+lng+',`'+id+'`,`'+code+'`)" class="ABtn">추가</button><button onclick="CloseOverlay()" class="CBtn">닫기</button></div></div>';

        customOverlay = new kakao.maps.CustomOverlay({
        map: map,
        clickable: true,
        content: tmp,
        position: new kakao.maps.LatLng(lat, lng),
        zIndex : 3
        });
        
		$.ajax({ // 이미지, 평점, 즐겨찾기 유무를 가져오기 위함
			url : '../Map/getOv.jsp', //데이터베이스에 접근해 현재페이지로 결과를 뿌려줄 페이지
			mathod : 'post',
			data : {
				r_num : id	// 음식점 id를 넘겨줌
			},
			success : function(data) { //DB접근 후 가져온 데이터
				const json = JSON.parse($.trim(data));
				document.getElementById('img_overlay').src = json.img;	// 이미지 설정
			}
		})
    }
	
	function open_detail(id, name, lat, lng, code) {
		console.log(code);
		if(code == "FD6" || code == "CE7"){
			var geocoder = new kakao.maps.services.Geocoder()
		
	    	let coords = new kakao.maps.LatLng(lat, lng)
	   
	    	let callback = function(result, status) {
	        	if (status === kakao.maps.services.Status.OK) {
					var url = '../Map/loadRastaurant.jsp?r_num=' + id + "&name=" + name
							+ "&addr=" + result[0].address.address_name
					window.open(url)
	        	}
	    	};	
	    	geocoder.coord2Address(coords.getLng(), coords.getLat(), callback)
		}
		else{
			var url = 'https://place.map.kakao.com/' + id;
    		window.open(url);
		}
	}

	//오버레이 닫기
	function CloseOverlay() {
		customOverlay.setMap(null);
	}
	
	const schedule = document.querySelector('.header__menu__schedule');
	const searchMap = document.querySelector('.header__menu__map');
	const board = document.querySelector('.header__menu__board');
	const logOut = document.querySelector('.header__menu__log-out');
	const logo = document.querySelector('.header__icon-logo');
	const myPage = document.querySelector('.header__menu__my-page ');

	//main.html 주소
	logo.addEventListener('click', () => {
	  const manageScheduleUrl = '../SchedulePage/main.jsp';
	  location.assign(manageScheduleUrl);
	});

	//main.html 주소
	schedule.addEventListener('click', () => {
	  const manageScheduleUrl = '../SchedulePage/main.jsp';
	  location.assign(manageScheduleUrl);
	});

	//지도 탐색 페이지(?) 주소
	searchMap.addEventListener('click', () => {
	  const searchMapUrl = '../Map/mapSearch.jsp';
	  location.assign(searchMapUrl);
	});

	//게시판 주소
	board.addEventListener('click', () => {
	  const boardUrl = '../board/board.jsp';
	  location.assign(boardUrl);
	});
	
	myPage.addEventListener('click', () => {
		  const myPageUrl = '../MyPage/myPage.html';
		  location.assign(myPageUrl);
		});

	logOut.addEventListener('click', () => {
		/*
	  firebase
	    .auth()
	    .signOut()
	    .then(() => {
	      location.assign('./index.html');
	    });*/
	  const logOutUrl = '../logout.jsp';
	  location.assign(logOutUrl);
	});
</script>
    </body>
</html>