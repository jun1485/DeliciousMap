<%@page import="DMDB.UserDbControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="DMDB.Post"%>
<%@ page import="DMDB.PostDbControl"%>
<%@ page import="DMDB.Comment"%>
<%@ page import="DMDB.Schedule"%>
<!DOCTYPE html>
<html lang="kor">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://kit.fontawesome.com/a9ea2ab270.js"
	crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="style/comment.css" />
<link rel="stylesheet" href="../SchedulePage/style/main.css" />
<link rel="stylesheet" href="../SchedulePage/style/dailyschedule.css" />
<link rel="stylesheet" href="style/board_page.css" />
<script defer src="../SchedulePage/js/nav.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=95722007ca7e14b3740605bd8bf9389a&libraries=services"></script>
	<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>맛있는지도 게시글</title>
</head>

<body class="body_container">
	<!-- 네비게이션 바-->
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

	<div class="full_container">
		<!-- 탑 배너-->
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
		PostDbControl control = new PostDbControl();
		UserDbControl userDB = new UserDbControl();
		int post_key = Integer.parseInt(request.getParameter("key"));
		String uid = (String) session.getAttribute("UID");
		Post post = control.loadPostFromDb(post_key);
		ArrayList<Comment> comments = control.loadCommentFromDb(post_key);
		control.addViews(post_key);
		post.setViews(post.getViews() + 1);
		ArrayList<Schedule> post_schedule = post.getSchedule();
		%>

		<!-- 메인 컨테이너-->
		<div class="main_container">
			<div class="main_content">

				<div class="main_top">
					<!-- 제목 표시-->
					<div class="article_title_info">
						<div class="article_name" style="width: 98%; display: flex:;">
							<div class="box_box" align="center">제목</div><%=post.getTitle()%>
						</div>
						<%
						if (uid.equals(post.getUid())) {
						%>
						<button class="comment_set_btn" style="font-size: 20px"
							onclick="location.href='deletePost.jsp?post_key=<%=post_key%>'">
							<i class="fas fa-trash"></i>
						</button>
						<%
						}
						%>
					</div>
					<!-- 개인프로필 표시-->
					<div class="article_write_info">
						<div class="article_profile_info">
							<div class="box_box" align="center">작성자</div><%=userDB.getNickName(post.getUid())%>
						</div>
						<!-- 작성날짜 표시-->
						<div class="article_write_date_info">
							<label class="article_write_date_title">
								<div class="box_box2" align="center">&nbsp 작성날짜 &nbsp</div>
								&nbsp <%=post.getDate()%>
							</label> <label class="article_write_date_data">
								<div class="box_box3" align="center">&nbsp 조회수 &nbsp</div> &nbsp
								<%=post.getViews()%>
							</label>
						</div>
					</div>
				</div>


				<!--스케줄 뷰-->
				<!--스케줄 뷰-->
				<div class="schedule_viewPart" align="center">
					<div class="main">
						<div class="move_btn_container">
							<button class="schedule_move_btn" onclick="setDay(-1)"
								id="left_sche_btn">
								<i class="fas fa-chevron-left"></i>
							</button>
						</div>
						<div class="main-center__component" id="schedule_container">
							<header class="component-header">
								<div class="component-header__day" id="dayCount">DAY</div>
								<div class="component-header__date" id="date_string">date</div>
							</header>
						</div>
						<div class="move_btn_container">
							<button class="schedule_move_btn" onclick="setDay(1)"
								id="right_sche_btn">
								<i class="fas fa-chevron-right"></i>
							</button>
						</div>
					</div>
					<div align="center">
						<button class="comment_set_btn" style="font-size: 30px"
							onclick="scheduleAddPopupOpen()">
							<i class="fas fa-save"></i>
						</button>
					</div>
				</div>

				<!-- 게시물 글-->
				<div class="article_text_part"><%=post.getContent()%></div>

				<!-- 게시물 좋아요파트-->
				<div class="article_bottom_part" style="font-size: 30px"
					align="right">
					<button class="comment_set_btn"
						style="font-size: 30px; margin-right: 1%"
						onclick="location.href='setRecommendation.jsp?post_key=<%=post_key%>'">
						<i class="fas fa-thumbs-up"></i>
					</button>
					<label> <%=post.getRecommendation_count()%></label>
				</div>

				<!-- 댓글 뷰부분-->
				<div class="comments_view_part" align="center">
					<div class="write_container">
						<form method="post"
							action="saveNewComment.jsp?post_key=<%=post_key%>">
							<i class="fas fa-user-circle" style="width: 5%"></i>
							<textarea style="width: 80%" name="reply_content"
								id="comment_text" placeholder="댓글을 입력하세요."></textarea>
							<div align="right" style="width: 85%">
								<button class="comment_set_btn" onclick="remove_comment_text()"
									type="button">
									<i class="fas fa-times"></i>
								</button>

								<button class="comment_set_btn" type="submit">
									<i class="fas fa-check"></i>
								</button>
							</div>
						</form>
					</div>
					<% int comment_count = 0;
					for(int i = 0; i < comments.size(); i++) {
						comment_count += 0;
					}
					%>

					<div style="width: 75%" align="left">
						<h3>
							댓글
							<%=comments.size()%></h3>
					</div>

					<br>

					<div class="all_comment_container" align="left">
						<!-- 댓글이 들어갈 공간 -->
						<%
						for (int i = 0; i < comments.size(); i++) {
							int key = comments.get(i).getKey();
						%>
						<div id="">
							<div class="comment_container">
								<div class="comment_a_writer">
									<i class="fas fa-user-circle" style="margin-right: 2%;"></i>
									<%=userDB.getNickName(comments.get(i).getUid())%></div>
								<div class="comment_a_content" id="comment<%=key%>"><%=comments.get(i).getContent()%></div>
								<div class="editBox" id="editBox<%=key%>" style="display: none;">
									<input class="editInput" type="text" id="input<%=key%>"></input>
									<button class="comment_set_btn" onclick="edit_close(<%=key%>)">
										<i class="fas fa-times"></i>
									</button>
									<button class="comment_set_btn"
										onclick="edit_submit('<%=key%>')">
										<i class="fas fa-check"></i>
									</button>
								</div>
								<button class="comment_set_btn" onclick="onReply('<%=i%>_re')">
									<i class="fas fa-reply"></i>
								</button>
								<%
								if (uid.equals(comments.get(i).getUid())) {
								%>
								<button class="comment_set_btn" onclick="editComment(<%=key%>)">
									<i class="fas fa-pen"></i>
								</button>
								<button class="comment_set_btn"
									onclick="location.href='deleteComment.jsp?post_key=<%=post_key%>&comment_key=<%=key%>'">
									<i class="fas fa-trash"></i>
								</button>
								<%
								}
								%>
							</div>
							<hr width="100%">
						</div>

						<div id="<%=i%>_re" style="display: none">
							<div class="write_container">
								<form method="post"
									action="saveNewComment.jsp?post_key=<%=post_key%>&reply_comment_key=<%=key%>">
									<i class="fas fa-reply" style="width: 5%"></i>
									<textarea name="reply_content" style="width: 85%"
										placeholder="댓글을 입력하세요."></textarea>
									<button class="comment_set_btn" type="button"
										onclick='close_re("<%=i%>_re")'>
										<i class="fas fa-times"></i>
									</button>
									<button class="comment_set_btn" type="submit">
										<i class="fas fa-check"></i>
									</button>
								</form>
							</div>
							<hr width="100%">
						</div>
						<%
						for (int j = 0; j < comments.get(i).getReplys().size(); j++) {
							int re_key = comments.get(i).getReplys().get(j).getKey();
						%>
						<div id="">
							<div class="comment_container">
								<div class="comment_a_re_writer" style="width: 22%">
									<i class="fas fa-reply" style="margin-right: 2%;"></i> 
									<i class="fas fa-user-circle" style="margin-right: 2%;"></i>
									<%=userDB.getNickName(comments.get(i).getReplys().get(j).getUid())%></div>
								<div class="comment_a_content" id="comment<%=re_key%>"><%=comments.get(i).getReplys().get(j).getContent()%></div>
								<div class="editBox" id="editBox<%=re_key%>" style="display: none;">
									<input class="editInput" type="text" id="input<%=re_key%>"></input>
									<button class="comment_set_btn" onclick="edit_close(<%=re_key%>)">
										<i class="fas fa-times"></i>
									</button>
									<button class="comment_set_btn"
										onclick="edit_submit('<%=re_key%>')">
										<i class="fas fa-check"></i>
									</button>
								</div>
								<%
								if (uid.equals(comments.get(i).getReplys().get(j).getUid())) {
								%>
								<button class="comment_set_btn" onclick="editComment(<%=re_key%>)">
									<i class="fas fa-pen"></i>
								</button>
								<button class="comment_set_btn"
									onclick="location.href='deleteComment.jsp?post_key=<%=post_key%>&comment_key=<%=re_key%>'">
									<i class="fas fa-trash"></i>
								</button>
								<%
								}
								%>
							</div>
							<hr width="100%">
						</div>
						<%
						}
						}
						%>
					</div>
				</div>
				<div align="center" style="margin: auto;">
					<button class="comment_set_btn" onclick="location.href='board.jsp'"
						style="font-size: 50px">
						<i class="fas fa-list"></i>
					</button>
				</div>
			</div>
		</div>
	</div>
	<script>

        function scheduleAddPopupOpen() {
            <%ArrayList<Schedule> schedules = post.getSchedule();
            session.setAttribute("copy_schedule", schedules);%>
            
            window.open("scheduleCopyPopup.html", "popup01", "width=480,height=230");
        }
        
        function onReply(id) {
			const tmp = document.getElementById(id);
			tmp.style.display = "block";
		}
        
        function close_re(id){
        	const tmp = document.getElementById(id);
			tmp.style.display = 'none';
        }
        
        var dayCount = 0;
        const scheduleDiv = [];
        const dateStrings = [];
        
       
        
        <% for(int i = 0; i < post_schedule.size(); i++){ %>
       		scheduleDiv.push(new Array);
        	dateStrings.push('<%=post_schedule.get(i).getDateString()%>');
        	<% for(int j = 0; j < post_schedule.get(i).getElementCount(); j++){ %>
        			var ele_name = '<%=post_schedule.get(i).getElementI(j).getName()%>';
        			var r_num = '<%=post_schedule.get(i).getElementI(j).getR_num()%>'
        			var lat = '<%=post_schedule.get(i).getElementI(j).getGP().getLatitude()%>'
        			var lng = '<%=post_schedule.get(i).getElementI(j).getGP().getLongitude()%>'
        			var time = '<%=post_schedule.get(i).getElementI(j).timeString()%>'
        			var isRes = <%=post_schedule.get(i).getElementI(j).isRes()%>
        			var div = `<div class="component-body" id="el<%=j%>">
								<div class="component-body__left-icon">
								<div class="component-body__left__number"><%=(j + 1)%></div>
								</div>
								<div class="component-body__info">
								<div class="component-body__info__txt-info" align="left">
								<div class="component-body__info__place">` + ele_name + `
								</div>
								<div class="component-body__info__category">` + time + `
								</div>
								</div>
								<div class="component-body__info-icons">
								<i class="fas fa-info-circle review-btn" onclick="open_info_page('`+r_num+`','`+ele_name+`',`+lat+`,`+lng+`,`+isRes+`)"></i>
								</div>
								</div>
								</div>`;
						scheduleDiv[<%=i%>].push(div);
        		<%}%>
        <%}%>
        
        function open_info_page(r_num, name, lat, lng, isRes) {
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
        
        function setDay(count){
        	if(count != 0){
        		remove_all_div(dayCount);
        		dayCount += count;
        	}
        	
        	if(dayCount == 0){
        		document.getElementById("left_sche_btn").disabled = true;
        	}
        	else{
        		document.getElementById("left_sche_btn").disabled = false;
        	}
        	
        	if(dayCount == scheduleDiv.length -1){
        		document.getElementById("right_sche_btn").disabled = true;
        	}
        	else{
        		document.getElementById("right_sche_btn").disabled = false;
        	}
        	
        	const day_count_div = document.getElementById("dayCount");
        	const day_string_div = document.getElementById("date_string");
        	const schedule_container = document.getElementById("schedule_container");
        	
        	day_count_div.innerText = (dayCount + 1) + "DAY";
        	day_string_div.innerText = dateStrings[dayCount];
        	
        	for(var i = 0; i < scheduleDiv[dayCount].length; i++){
        		schedule_container.innerHTML += scheduleDiv[dayCount][i];
        	}
        }
        
        function remove_all_div(count){
        	const schedule_container = document.getElementById("schedule_container");
        	
        	for(var i = 0; i < scheduleDiv[count].length; i++){
        		const del_div =  document.getElementById("el" + i);
        		
        		schedule_container.removeChild(del_div);
        	}
        }
        
        setDay(0);
        
        function remove_comment_text(){
        	const comment_text = document.getElementById("comment_text");
        	comment_text.value = ""
        }
        
        function editComment(c_num) {
			const text = document.getElementById("comment"+c_num);
			const input = document.getElementById("input"+c_num);
			const editBox = document.getElementById("editBox"+c_num);
			
			text.style.display = "none";
			editBox.style.display = "";
			
			input.value = text.innerText;
		}
        
        function edit_close(c_num) {
        	const editBox = document.getElementById("editBox"+c_num);
        	const text = document.getElementById("comment"+c_num);
        	
			text.style.display = "";
			editBox.style.display = "none";
		}
 
        function edit_submit(c_num) {
			const editBox = document.getElementById("editBox"+c_num);
			const text = document.getElementById("comment"+c_num);
			const input = document.getElementById("input"+c_num);
			const content = input.value;
			
			$.ajax({
				url : 'editComment.jsp',
				mathod : 'post',
				data : {
					c_num : c_num,
					p_num : <%=post_key%>,
					content : content,
				},
				success : function(data){
					text.innerText = content;
					text.style.display = "";
					editBox.style.display = "none";
				}
			})
		}
        
    </script>
</body>

</html>