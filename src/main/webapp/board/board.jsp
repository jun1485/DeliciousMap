<%@page import="DMDB.UserDbControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
    <%@ page import="DMDB.Post" %>
    <%@ page import="DMDB.PostDbControl" %>
<!DOCTYPE html>
<html lang="kor">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width , initial-scale=1.0">
    <title>맛있는지도</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../SchedulePage/style/main.css" />
    <script defer src="../SchedulePage/js/nav.js"></script>
    <script src="https://kit.fontawesome.com/a9ea2ab270.js" crossorigin="anonymous"></script>
<style>
* {
	box-sizing: border-box;
	font-family: 'Noto Sans KR', sans-serif;
	letter-spacing: -1px;
}

body {
	font-family: 'Noto Sans KR', sans-serif;
}
/*
        nav css
        */
.header {
	width: 93vw;
	height: 20vh;
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin: 0 4em;
	padding: 0 4em;
	border-bottom: 1.5px solid black;
}

.header__menu {
	display: flex;
	padding-top: 3em;
	cursor: pointer;
	transition: transform 300ms ease-in;
}

.header__menu__item {
	padding-left: 2em;
	font-size: 1.4rem;
}

/*
        search header css
        */
.searchAdd_part {
	display: flex;
	align-content: center;
	height: 40%;
	margin-top: 40px;
	margin-bottom: 50px;
	margin-left: 13%;
}

.searchAdd_part img {
	border: 1px black solid;
	border-radius: 100%;
	margin-right: 10px;
}

.searchAdd_part input {
	border-radius: 7px;
}

#searchTitleButton {
	margin-left: 15px;
	margin-right: 53%;
	border-radius: 7px;
	padding: 5px 20px;
}

#articleAdderButton {
	border-radius: 7px;
	padding: 5px 20px;
	background-color: rgb(120, 192, 207);
}

/*
        top header css
        */
.top_menu_items a {
	color: #2196f3;
	text-decoration: none;
	border: #a1887f 1px solid;
	display: flex;
	justify-content: center;
	padding: 0;
	margin: 0;
}

.top_container {
	display: flex;
	margin: 0 6em;
	padding: 0 3em;
	height: 9vh;
	width: 90vw;
	align-items: center;
	border-bottom: black 1px solid;
}

.top_container * {
	width: 6em;
	padding-left: 1em;
	padding-right: 1em;
	font-size: 1.2rem;
	display: flex;
}

/*
        main container top banner css
        */
.main_content_title {
	display: inline;
	margin: top 0 bottom 0;
	margin-left: 30px;
}

.main_content_banner {
	display: flex;
	border-bottom: #a1887f 1px solid;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
	height: 20%;
	padding-bottom: 1%;
	padding-right: 1%;
	backface-visibility: hidden;
	max-height: 20%;
	overflow: hidden;
	padding-top: 10px;
	background-color: rgb(226, 228, 207);
}

.main_content_banner * {
	display: flex;
}

.main_content_banner_name {
	margin-left: 2%;
	width: 77%;
}

.main_content_banner_writer {
	display: inline-block;
	text-align: center;
	width: 20%;
}

.main_content_banner_date {
	display: inline-block;
	text-align: center;
	width: 20%;
}

.main_content_banner_clickNumber {
	display: inline-block;
	text-align: center;
	width: 10%;
}

.main_content_banner_likeNumber {
	display: inline-block;
	text-align: center;
	width: 10%;
}

/*
        article css
        */
.main_content_data {
	display: flex;
	width: 100%;
	height: 3em;
	margin: 0;
	padding: 1%;
	border-bottom: 1px groove #a1887f;
	font-weight: bold;
	text-align: left;
}

.main_content_data:last-child {
	border-bottom-right-radius: 5px;
	border-bottom-left-radius: 5px;
}

.main_content_data span input[type="checkbox"] {
	display: inline;
}

.main_content_data a {
	display: inline-block;
	backface-visibility: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
	text-decoration: none;
	margin-left: 1%;
	width: 74%;
	font-size: 0.9rem;
	margin-right: 3%;
	color: black;
}

.writer_name {
	display: inline-block;
	text-align: center;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
	font-size: 0.8rem;
	width: 20%;
}

.writer_date {
	display: inline-block;
	text-align: center;
	width: 20%;
	flex-wrap: wrap;
}

.click_number {
	display: inline-block;
	text-align: center;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
	width: 10%;
}

.like_number {
	display: inline-block;
	text-align: center;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
	width: 10%;
}

.main_container {
	margin-left: 20vh;
	margin-right: 10vh;
}

/*
        bottom container css
        */
.pageNumber_part {
	display: flex;
	justify-content: center;
	margin-top: 30px;
	margin-bottom: 50px;
}

.prev_page_button {
	border: #a1887f 1px ridge;
	border-radius: 5px;
}

.pageNumber_part label {
	margin: 10px;
	cursor: pointer;
}

.next_page_button {
	border: #a1887f 1px ridge;
	border-radius: 5px;
}

/*
        separate window css
        */
.banner {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.main_content {
	margin-top: 1%;
	width: 90%;
	height: fit-content;
	border: 3px groove #a1887f;
	border-bottom: 1px groove #a1887f;
	border-radius: 10px;
	margin: 0;
	padding: 0;
}

.main_content_service {
	margin: 0;
	padding: 0;
}

.search_btn {
	font-size: 20px;
	outline: none;
	border: none;
	background-color: transparent;
	cursor: pointer;
}

.search_btn:hover {
	transform: scale(1.1);
}

.n_p_btn {
	font-size: 1.2em;
	margin: 1%;
	outline: none;
	border: none;
	background-color: transparent;
	color: black;
}

.n_p_btnX {
	font-size: 1.2em;
	margin: 1%;
	outline: none;
	border: none;
	background-color: transparent;
	color: black;
}

.num_btn {
	font-size: 1.2em;
	margin: 1%;
	outline: none;
	border: none;
	background-color: transparent;
	color: #c8c8c8;
}

.n_p_btn:hover {
	cursor: pointer;
	color: orange;
}

.num_btn:hover {
	cursor: pointer;
	color: orange;
}

.title_c_c:hover {
	color: orange;
}
</style>
</head>

<body class="body_container">
    <!-- 네비게이션 뷰-->
    <header class="header nav-header">
        <div class="header__icon"><img
          src="../img/nav-logo.png"
          alt="맛있는지도"
          class="header__icon-logo"
        /></div>
        <div class="header__menu">
            <span class="header__menu__schedule header__menu__item">일정관리</span>
            <span class="header__menu__map header__menu__item">지도탐색</span>
            <span class="header__menu__board header__menu__item">게시판</span>
            <span class="header__menu__my-page header__menu__item">마이페이지</span>
            <div class="header__menu__log-out header__menu__item">로그아웃</div>
        </div>
    </header>

    <div class="full_container">
        <!--탑 배너-->
        <!--
        <div class="top_container">
            <div class="banner">
                <span class="top_menu">
                    <label class="top_menu_items"><a href="">공지</a> </label>
                </span>
                <span class="top_menu">
                    <label class="top_menu_items"><a href="">리뷰</a> </label>
                </span>
                <span class="top_menu">
                    <label class="top_menu_items"><a href="">질문</a> </label>
                </span>
                <span class="top_menu">
                    <label class="top_menu_items"><a href="">작성글</a> </label>
                </span>
            </div>
        </div>
        -->
        
        <%
                ArrayList<Post> posts;
                PostDbControl control = new PostDbControl();
                UserDbControl userDB = new UserDbControl();
                String page_tmp = request.getParameter("page_num");
                String keyword = request.getParameter("keyword");
                int page_number;
                if (page_tmp == null) {
                	page_number = 1;
                } else {
                	page_number = Integer.parseInt(page_tmp);
                }
                if (keyword == null) {
                	posts = control.loadPostPageFromDb(page_number);
                } else {
                	posts = control.searchPost(page_number, keyword);
                }
                %>
        
        <!--찾기, 게시글 추가 기능-->
        <div class="searchAdd_part">
        	<form action="board.jsp" method="get" class="search_form" style="display: inline; width: 70%; margin-left: 6%;">
           <button class="search_btn" type="submit" style="width: 30px; height: 30px;">
						<i class="fas fa-search" ></i>
					</button>
            <input type="text" style="width: 300px" name="keyword" >
            </form>
            <button id="articleAdderButton" name="articleAdderButton" onclick="location.href='writePage.html'">게시글 추가</button>
        </div>

		<!-- 메인 컨테이너 -->
        <div class="main_container" align="center">
			<div class="main_content">
                <dl class="main_content_service">
                    <!-- 게시물 타이틀-->
                    <div class="main_content_banner">
                        <label class="main_content_banner_name">제목</label>
                        <label class="main_content_banner_writer">작성자</label>
                        <label class="main_content_banner_date">날짜</label>
                        <label class="main_content_banner_clickNumber">조회수</label>
                        <label class="main_content_banner_likeNumber">추천수</label>
                    </div>

                    <!-- 게시물 글들-->
                    <% for(int i = 0; i < posts.size(); i++){ %>
                    	<dd class="main_content_data">
                        <a class="title_c_c" href="board_page.jsp?key=<%=posts.get(i).getKey()%>"><%=posts.get(i).getTitle()%></a>
                        <div class="writer_name"><%=userDB.getNickName(posts.get(i).getUid())%></div>
                        <span class="writer_date"><%=posts.get(i).getDate()%></span>
                        <span class="click_number"><%=posts.get(i).getViews()%></span>
                        <span class="like_number"><%=posts.get(i).getRecommendation_count()%></span>
                    </dd>
                    <% }%>
                </dl>
             </div>

                <!-- 밑 컨테이너-->
                <div class="bottom_banner">

                    <!--페이징 기능-->
                    <div class="pageNumber_part">
                   		<% if(keyword == null) { %>
                        <button class="n_p_btn" id="previous_btn" onclick="location.href='board.jsp?page_num=<%=page_number-1%>'">&lt;</button>
                    	<% 
        				for(int i = page_number - 2; i < page_number + 3; i++){
        					if(i < 1){
        						continue;
        					}
        					if(i == page_number){
        						%><button class="num_btn" style="color: black;" disabled> <%=i%> </button> <% 
        					}
        					else{
        						if(!(control.isExistedPage(i))){
        							break;
        						}
        						else{
        							%><button class="num_btn" onclick="location.href='board.jsp?page_num=<%=i%>'"><%=i%> </button> <% 
        						}
        					}
        				}
        				%>
                        <button class="n_p_btn" id="next_btn" onclick="location.href='board.jsp?page_num=<%=page_number+1%>'">&gt;</button>
                        <% } 
                   		else { %>
                        <button class="n_p_btn" id="previous_btn" onclick="location.href='board.jsp?page_num=<%=page_number-1%>&keyword=<%=keyword%>'">&lt;</button>
                    	<% 
        				for(int i = page_number - 2; i < page_number + 3; i++){
        					if(i < 1){
        						continue;
        					}
        					if(i == page_number){
        						%><button class="num_btn"  style="color: black;" disabled> <%=i%> </button> <% 
        					}
        					else{
        						if(!(control.isExistedSearchedPage(i, keyword))){
        							break;
        						}
        						else{
        							%><button class="num_btn" onclick="location.href='board.jsp?page_num=<%=i%>'"><%=i%> </button> <% 
        						}
        					}
        				}
        				%>
                        <button class="n_p_btn"  id="next_btn" onclick="location.href='board.jsp?page_num=<%=page_number+1%>&keyword=<%=keyword%>'">&gt;</button>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>


        <script>
        <% 
        if(page_number == 1){
        	%>
        	var previous_btn = document.getElementById("previous_btn");
        	previous_btn.disabled = true;
        	previous_btn.className = "n_p_btnX";
        	<%}
		if (keyword == null) {
			if (!(control.isExistedPage(page_number + 1))) {%>
				var next_btn = document.getElementById("next_btn");
				next_btn.disabled = true;
				next_btn.className = "n_p_btnX";
		<%}
		}
		else { 
			if (!(control.isExistedSearchedPage(page_number + 1, keyword))) {%>
			var next_btn = document.getElementById("next_btn");
			next_btn.disabled = true;
			next_btn.className = "n_p_btnX";
		<%}
		}%>
        </script>
</body>
</html>