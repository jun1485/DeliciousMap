<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<%@ page import="DMDB.ScheduleDbControl"%>
<%@ page import="DMDB.ScheduleForView"%>
<%
request.setCharacterEncoding("UTF-8");
%>

<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
 <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<title>일정 관리 || 맛있는 지도</title>
<!--css 파일 주소-->
<link rel="stylesheet" href="./style/main.css" />
<!--font awesome key-->
<script src="https://kit.fontawesome.com/a9ea2ab270.js"
	crossorigin="anonymous"></script>
<!--firebase auth-->
<script defer
	src="https://www.gstatic.com/firebasejs/8.5.0/firebase-app.js"></script>
<script defer
	src="https://www.gstatic.com/firebasejs/8.5.0/firebase-auth.js"></script>
<!--js 파일 주소-->
<script defer src="./js/main.js"></script>
<!--navigation 파일 주소-->
<script defer src="./js/nav.js"></script>
</head>
<body>
	<!--네비게이션 바만 필요하다면 header만 -->
	<header class="header nav-header">
		<div class="header__icon-logo"><img
          src="../img/nav-logo.png"
          alt="맛있는지도"
          class="header__icon-logo"
        /></div>
		<div class="header__menu">
			<span class="header__menu__schedule header__menu__item">일정관리</span> <span
				class="header__menu__map header__menu__item">지도탐색</span> <span
				class="header__menu__board header__menu__item">게시판</span>
				<span class="header__menu__my-page header__menu__item">마이페이지</span>
			<div class="header__menu__log-out header__menu__item">로그아웃</div>
		</div>
	</header>
	<div class="container">
		<header class="container-header">
			<div class="container-header__title">일정을 관리해보세요.</div>
			<span class="container-header__contents"> 새로운 일정을 만들거나 기존의 일정을
				편집, 삭제할 수 있습니다. </span>
		</header>
		<div class="container-main">
			<section class="component initial-component">
				<div class="img initial-component__img">
					<i class="fas fa-plus"></i>
				</div>
				<span class="component__title initial-component__title"> 새로운
					일정 만들기 </span>
			</section>
			<section class="componet-container" style="padding: 1%;">
			</section>
		</div>
	</div>
	<form action="jsp/saveNewSchedule.jsp" class="modal-container">
		<div id='modal-bg' class='modal-bg'>
			<div class="modal hidden-modal">
				<header class="modal-header">
					<span class="modal-header__title">일정 정보 입력</span>
					<button type='button' class="modal-header__btn">
						<i class="fas fa-times"></i>
					</button>
				</header>
				<div class="modal-body">
					<div class="modal-body__shcedule-title modal-body__item">
						<label for="schedule-title">여행 제목</label> <input type="text"
							id="schedule-title" class="modal-body__txt-input"
							name="schedule-title" placeholder="몇 글자 이내로 입력하세요."
							maxlength="20" required />
					</div>
					<div class="modal-body__schedule-start-date modal-body__item">
						<label for="schedule-start-date">출발일</label> <input type="date"
							id="schedule-start-date" class="modal-body__txt-input"
							name="schedule-start-date" placeholder="캘린더를 클릭하세요." required />
					</div>
					<div class="modal-body__schedule-end-date modal-body__item">
						<label for="schedule-end-date">도착일</label> <input type="date"
							id="schedule-end-date" class="modal-body__txt-input"
							name="schedule-end-date" placeholder="캘린더를 클릭하세요." required />
					</div>
				</div>
				<footer class="modal-footer">
					<input type="submit" value="완료" class="modal-footer__btn" />
				</footer>
			</div>
		</div>
	</form>

	<%
	ScheduleDbControl dc = new ScheduleDbControl(); // DB에서 불러오기 위한 함수를 가진 객체
	String uid = null; // 유저 아이디를 저장할 변수
	uid = (String) session.getAttribute("UID"); // 세션에서 아이디를 불러옴
	if(uid == null || uid.equals("")){
		%>
		<script>
		alert("로그인이 필요합니다.");
		location.href="index.html";
		</script>
		<% 
	}
	ArrayList<ScheduleForView> views = dc.loadUserSchedulesFromDb(uid); // 한 유저가 저장한 모든 스케줄의 key, name 배열을 가진 객체
	%>
	<script>
	// 스케줄 정보들을 저장할 스케줄 객체와 객체들을 담을 배열 선언
	function loadSchedule(){
		var scheduleName;
		var startDay;
		var endDay;
		var key;
	}
	
	function loadSchedules(){
		const loadedSchedules = [];
	
	// DB로 부터 불러온 정보들을 자바스크립트 schedule 객체로 저장하고 schedules 배열에 추가
	<%for (int i = 0; i < views.size(); i++) {%>
		var sche = new loadSchedule();
		sche.scheduleName = "<%=views.get(i).getName()%>";
		sche.startDay = "<%=views.get(i).getStart_day()%>";
		sche.endDay = "<%=views.get(i).getEnd_day()%>";
		sche.key = "<%=views.get(i).getKey()%>";
		loadedSchedules.push(sche);
	<%}%>
		return loadedSchedules;
			// 배열을 리턴
		}
	
	const SCHEDULE = loadSchedules();
	
	function showLoadedComponent(SCHEDULE) {
		  for (let i = 0; i < SCHEDULE.length; i++) {
		  const loadedComponent = document.createElement('section');
		  const containerMain = document.querySelector('.componet-container');
		  const title = SCHEDULE[i].scheduleName;// 스케줄 제목
		  const startDate = SCHEDULE[i].startDay;//스케줄 시작 날짜
		  const endDate = SCHEDULE[i].endDay;//스케줄 마지막 날짜
		  const key = SCHEDULE[i].key;	// 삭제 수정 버튼을 위한 스케줄의 key값
		  const delURL = "jsp/deleteSchedule.jsp?key=" + key;
		  const editURL = "jsp/editSchedule.jsp?key=" + key;
		  const viewURL = "dailyschedule.jsp?schedule_key=" + key;

		  loadedComponent.innerHTML = `
		        <div class='component-content' >
		          <span class="component__title">` + title + `</span>
		          <div class="component__icons">
		            <button class="component__edit-btn"  onclick="location.href='` + editURL + `'">
		              <i class="fas fa-pen"></i>
		            </button>
		            <button class="component__delete-btn"  onclick="location.href='` + delURL + `'">
		               <i class="fas fa-trash-alt"></i>
		            </button>
		          </div>  
		        </div>
		          <div class="component__date">
		            <span class="component__date-start">` + startDate + `</span>
		            <span class="component__date-separator"> ~ </span>
		            <span class="component__Date-end">` + endDate + `</span>
		          </div>
		        `;
		  loadedComponent.setAttribute('class', 'component loaded-component');
		  containerMain.appendChild(loadedComponent);
		  
		  loadedComponent.addEventListener('click', (event) => {
			    const target = event.target;
			    console.log(target.className);
			    if (target.className == 'component loaded-component' || target.className == 'component__Date-end' 
			    		|| target.className == 'component__date-start' || target.className == 'component__title' || 
			    		target.className == 'component-content' || target.className == 'component__date-separator' ) {
			      const dailyScheduleUrl = viewURL;
			      location.assign(dailyScheduleUrl);
			    }
			  });
		  }
		  HTMLFormControlsCollection;
		}
	
	showLoadedComponent(SCHEDULE); 

	</script>
</body>
</html>