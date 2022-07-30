<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="DMDB.ScheduleDbControl"%>
<%@ page import="DMDB.Schedule"%>
<%@ page import="DMDB.Element"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<title>나의 일정 확인 || 맛있는 지도</title>
<!--css 파일 주소-->
<link rel="stylesheet" href="./style/dailyschedule.css" />
<!--font awesome key-->
<script src="https://kit.fontawesome.com/a9ea2ab270.js"
	crossorigin="anonymous"></script>
<!--firebase auth-->
<script defer
	src="https://www.gstatic.com/firebasejs/8.5.0/firebase-app.js"></script>
<script defer
	src="https://www.gstatic.com/firebasejs/8.5.0/firebase-auth.js"></script>
<!--js 파일 주소-->
<!--  <script defer src="./js/dailyschedule.js"></script> -->
<!--navigation 파일 주소-->
<script defer src="./js/nav.js"></script>
<!--calender 파일 주소-->
<link href="./lib/calendar.css" rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@5.7.0/main.min.js"></script>
<script defer src="./lib/calendar.js"></script>
<!--<script defer src="./js/calendar.js"></script> -->
</head>
<body>
	<header class="header nav-header">
		<div class="header__icon">
			<img src="../img/nav-logo.png" alt="맛있는지도" class="header__icon-logo" />
		</div>
		<div class="header__menu">
			<span class="header__menu__schedule header__menu__item">일정관리</span> <span
				class="header__menu__map header__menu__item">지도탐색</span> <span
				class="header__menu__board header__menu__item">게시판</span> <span
				class="header__menu__my-page header__menu__item">마이페이지</span>
			<div class="header__menu__log-out header__menu__item">로그아웃</div>
		</div>
	</header>
	<main class="main">
		<section class="main-left">
			<div class="main__left__calender">
				<div id="calendar"></div>
			</div>
			<div class="main-left__nav">
				<ul class="main__nav__days"></ul>
			</div>
		</section>
		<section class="main-center"></section>
		<section class="main-right">
			<div id="map"
				style="width: 21vw; height: 23vh; position: fixed; border-radius: 10px;"></div>
		</section>
	</main>
	<!--kakao map api key-->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2aa9b1e0c22390334575cf60d01b5c11&libraries=services"></script>
	<!--우측 지도 js 파일 주소-->
	<script src="./js/map.js"></script>

	<%
	String schedule_key = null;
	String uid = null;
	schedule_key = request.getParameter("schedule_key");
	uid = (String) session.getAttribute("UID");
	if (schedule_key == null || uid == null) {
	%>
	<script type="text/javascript">
    	alert("잘못된 접근입니다.");
    	location.href="index.html";
    	</script>
	<%
	}
	ScheduleDbControl control = new ScheduleDbControl();

	ArrayList<Schedule> schedules = control.loadScheduleFromDb(uid, Integer.parseInt(schedule_key));
	%>

	<script type="text/javascript">
    
    const navDays = document.querySelector('.main__nav__days');
    const main = document.querySelector('.main-center');
    
    
    const scheduleDB = [
    		  <%for (int i = 0; i < schedules.size(); i++) {
	for (int j = 0; j < schedules.get(i).getElementCount(); j++) {%> 
    					{
    					name: '<%=schedules.get(i).getElementI(j).getName()%>',
    					date: '<%=schedules.get(i).getElementI(j).getDate()%>',
    					category: "<%=schedules.get(i).getElementI(j).timeString()%>",
    					x: '<%=schedules.get(i).getElementI(j).getGP().getLatitude()%>',
    					y: '<%=schedules.get(i).getElementI(j).getGP().getLongitude()%>',
    					r_num: '<%=schedules.get(i).getElementI(j).getR_num()%>',
    					isRes: '<%=schedules.get(i).getElementI(j).isRes()%>',
    					},
    					<%}
}%>
    ];
    
    var COMPONENTS = [];
    var TOTALDAYS; // 일정 총 날짜 수
    var STARTDATE; //첫 일정의 시작일
				
	navDays.addEventListener('click', moveToComponent);

	// 왼쪽 네비게이션 바의 날짜를 클릭했을 때 해당 일정으로 화면 이동
	function moveToComponent(event) {
	  const target = event.target.dataset.day;
	  const destination = COMPONENTS.filter((component) => {
	    return target == component.dataset.id;
	  });
	  destination[0].scrollIntoView({ behavior: 'smooth' });
	}

	// 왼쪽 날짜 네비게이션 바 초기화
	function printNavDays() {
	  for (let i = 1; i <= TOTALDAYS; i++) {
	    const li = document.createElement('li');
	    li.innerText = 'DAY' + i;
	    li.dataset.day = '' + i;
	    navDays.appendChild(li);
	  }
	}

	//스케줄을 초기화하는 함수
	function setMainComponent() {
	  createComponents();
	}

	//date 객체 string으로 변경
	function changeDateObj(dateObj) {
	  var yyyy = dateObj.getFullYear();
	  var mm = dateObj.getMonth() + 1;
	  var dd = dateObj.getDate();
	  if (dd < 10) {
	    dd = '0' + dd;
	  }
	  if (mm < 10) {
	    mm = '0' + mm;
	  }
	  yyyy = yyyy.toString();
	  mm = mm.toString();
	  dd = dd.toString();
	  var date = yyyy + '-' + mm + '-'+ dd;
	  return date;
	}
	
	function divideDayInfo(dateObj) {
		  const standardDate = changeDateObj(dateObj);
		  const eachDayInfo = scheduleDB.filter((element) => {
		    return element.date == standardDate;
		  });
		  return eachDayInfo;
		}
	
	//일정 날짜 출력하는 함수
	function createComponents() {
	  for (let i = 1; i <= TOTALDAYS; i++) {
	    const startDate = new Date(STARTDATE);
	    const dateObj = new Date(startDate.setDate(startDate.getDate() + i - 1));
	    const nextDate = changeDateObj(dateObj);
	    const eachDayInfo = divideDayInfo(dateObj);
	    const component = document.createElement('div');
	    component.innerHTML = `
	    <header class="component-header">
	            <div class="component-header__day">
	              DAY ` + i + `
	            </div>
	            <div class="component-header__date">
	            ` + nextDate + `
	            </div>
	            `;
	    component.setAttribute('class', 'main-center__component');
	    component.dataset.id = '' + i;
	    COMPONENTS.push(component);
	    main.appendChild(component);

	    createComponentBody(component, eachDayInfo);
	  }
	}

	//날짜 별로 정보 출력
	function createComponentBody(component, eachDayInfo) {
	  const posCount = eachDayInfo.length;
	  const placeName = eachDayInfo.map((element) => element.name);
	  const category = eachDayInfo.map((element) => element.category);
	  const lat =  eachDayInfo.map((element) => element.x);
	  const lon =  eachDayInfo.map((element) => element.y);
	  const r_num =  eachDayInfo.map((element) => element.r_num);
	  const isRes =  eachDayInfo.map((element) => element.isRes);

	  for (let j = 1; j <= posCount; j++) {
	    const body = document.createElement('div');
	    body.innerHTML = `
	            <div class="component-body__left-icon">
	              <div class="component-body__left__number">
	                ` + j + `
	              </div>
	            </div>
	            <div class="component-body__info">
	              <div class="component-body__info__txt-info">
	                <div class="component-body__info__place">
	                ` + placeName[j-1] + `
	                </div>
	                <div class="component-body__info__category">
	                ` + category[j - 1] + `
	                </div>
	              </div>
	              <div class="component-body__info-icons">
	                <i class="fas fa-info-circle review-btn" onclick="open_detail('`+r_num[j-1]+`','`+placeName[j-1]+`',`+lat[j-1]+`,`+lon[j-1]+`,`+isRes[j-1]+`)"></i>
	                <i class="fas fa-map-marker-alt marker-btn" onclick="showLoc(`+lat[j-1]+`,`+lon[j-1]+`)" data-number="` + j + `"></i>
	              </div>
	            </div>
	    `;
	    body.setAttribute('class', 'component-body');
	    body.dataset.id = component.dataset.id + '-' + j;
	    component.appendChild(body);
	  }
	}
	
	function getDate() {
		  const firstEle = scheduleDB[0];
		  const lastEle = scheduleDB[scheduleDB.length - 1];
		  const totalDays =
		    (new Date(lastEle['date']).getTime() -
		      new Date(firstEle['date']).getTime()) /
		      (24 * 3600 * 1000) +
		    1;
		  TOTALDAYS = totalDays;
		  STARTDATE = firstEle['date'];
		}
	
	getDate();
	printNavDays();
	setMainComponent();
	
	//db에서 실제로 가져와야할 값
	var obj = [
	  {
	    title: '<%=schedules.get(0).getName()%>',
	    start: '<%=schedules.get(0).getDateString()%>',
	    end: '<%=schedules.get(schedules.size() - 1).getDateString_plus_1day()%>', //일정이 25~27일 이라면  + 1일 해서 28일을 End day로 설정할 것, calendar api 문제
	  },
	];
	
	function printCalendar(obj) {
	  var calendarEl = document.getElementById('calendar');

	  var calendar = new FullCalendar.Calendar(calendarEl, {
	    contentHeight: 'auto',
	    initialView: 'dayGridMonth',
	    locale: 'ko',
	    initialDate: obj[0].start, // 속성 명 변경 시 주의
	    headerToolbar: {
	      start: '',
	      center: 'title',
	      end: '',
	    },
	    events: obj,
	  });

	  calendar.render();
	}

	printCalendar(obj);
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(33.450701, 126.570667); 
	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
    	position: markerPosition
	});
	
	function showLoc(lat, lng){
	    marker.setMap(null); 
	    marker = new kakao.maps.Marker({
	    position: new kakao.maps.LatLng(lat, lng)
	    });
	    marker.setMap(map);

	    var c  = new kakao.maps.LatLng(lat, lng); 
	    map.setCenter(c);
	}
	
	function open_detail(r_num, name, lat, lng, isRes) {
		
		if(isRes){
			var geocoder = new kakao.maps.services.Geocoder();
	    	let coords = new kakao.maps.LatLng(lat, lng);
	   
	   		let callback = function(result, status) {
	        	if (status === kakao.maps.services.Status.OK) {
					var url = '../Map/loadRastaurant.jsp?r_num=' + r_num + "&name=" + name
							+ "&addr=" + result[0].address.address_name;
					window.open(url);
	        	}
	    	};	
	    	geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
		}
		else{
			var url = 'https://place.map.kakao.com/' + r_num;
    		window.open(url);
		}
	}
	
	showLoc(scheduleDB[0].x, scheduleDB[0].y);
    </script>
</body>
</html>
