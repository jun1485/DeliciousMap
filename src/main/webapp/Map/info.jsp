<%@page import="DMDB.UserDbControl"%>
<%@page import="DMDB.Review"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DMDB.Restaurant"%>
<%@page import="DMDB.RestaurantDbControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>상세 정보 || 맛있는 지도</title>
</head>
<link rel="stylesheet" href="style/info.css" />
<link rel="stylesheet" href="../SchedulePage/style/main.css" />
<script defer src="../SchedulePage/js/nav.js"></script>
<script src="https://kit.fontawesome.com/a9ea2ab270.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<%
RestaurantDbControl control = new RestaurantDbControl();
UserDbControl userDB = new UserDbControl();
String r_num = request.getParameter("r_num");
Restaurant restaurant = control.loadRastaurant(r_num);
ArrayList<Review> reviews = control.loadReviews(r_num);
String uid = (String) session.getAttribute("UID");
%>
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
			<div class="main__header">
				<div class="main__header-upper">
					<div class="main__header-left">
						<span class="main__header__title"></span> <span
							class="main__header__score"> <%=control.getScores(r_num)%>
						</span>
					</div>
					<div class="main__header-right">
						<div class="main__header__review" onclick="goReview()">
							<i class="far fa-edit"></i> <span>리뷰쓰기</span>
						</div>
						<div class="main__header__like" onclick="setLike()">
							<i class="far fa-heart"></i> <span>가고싶다</span>
						</div>
					</div>
				</div>
				<div class="main__header-lower">
					<div class="main__header__view-count main__header__count-items">
						<i class="far fa-eye"></i> <span id="view-counter">0</span>
					</div>
					<div class="main__header__reply-count main__header__count-items">
						<i class="fas fa-pen"></i> <span id="review-counter"></span>
					</div>
					<div class="main__header__like-count main__header__count-items">
						<i class="fas fa-heart"></i> <span id="like-counter"></span>
					</div>
				</div>
			</div>
			<div class="info-divider"></div>
			<div class="main__info"></div>
			<div class="divider"></div>
			<div class="main__review">
				<div class="review__header">
					<div class="review__header-left">
						<span class="review__title">리뷰</span> <span class="review__count"></span>
					</div>
					<div class="review__header-right">
						<span class="review__total-count review__category"></span> <span
							class="review__divider">|</span> <span
							class="review__good-count review__category"></span> <span
							class="review__divider">|</span> <span
							class="review__soso-count review__category"></span> <span
							class="review__divider">|</span> <span
							class="review__bad-count review__category"></span>
					</div>
				</div>
				<div class="review__main"></div>
			</div>
		</section>
		<section class="main-right">
			<!--insert map script code-->
		</section>
	</main>
</body>

<script type="text/javascript">
  const reviewBtn = document.querySelector('.main__header__review');
  const likeBtn = document.querySelector('.main__header__like');
  const resName = document.querySelector('.main__header__title');
  const infoContainer = document.querySelector('.main__info');
  const viewCounter = document.querySelector('#view-counter');
  const reviewCounter = document.querySelector('#review-counter');
  const likeCounter = document.querySelector('#like-counter');
  const reviewContainer = document.querySelector('.review__main');
  const reviewCount = document.querySelector('.review__count');
  const reviewMenuTotal = document.querySelector('.review__total-count');
  const reviewMenuGood = document.querySelector('.review__good-count');
  const reviewMenuSoso = document.querySelector('.review__soso-count');
  const reviewMenuBad = document.querySelector('.review__bad-count');
  const reviewCategory = document.querySelectorAll('.review__category');
  const reviewRightMenu = document.querySelector('.review__header-right');

  let LIKE = <%=control.isLikes(r_num, uid)%>; // 즐겨찾기, 미완

  //음식점 정보
  let restaurantDB = {
    name: '<%=restaurant.getName()%>',
    addr: '<%=restaurant.getAddr()%>',
    info_heads: [],
    infos: [],
  };
  
<%for (int i = 0; i < restaurant.getInfos().size(); i++) {%>
	  restaurantDB.info_heads.push('<%=restaurant.getInfo_heads().get(i)%>')
	  restaurantDB.infos.push('<%=restaurant.getInfos().get(i)%>')
<%}%>

  //댓글 db 예시
  let commentDB = [
	  <%for (Review review : reviews) {%>
	  {
	      cNumber: <%=review.getC_num()%>,
	      uid: '<%=userDB.getNickName(review.getUid())%>',
	      content: `<%=review.getContent()%>`,
	      time: '<%=review.getTime()%>',
	      score: <%=review.getScore()%>,
	  },
	  <%}%>
  ];
  
  // 개행처리
  for(var i in commentDB){
	  commentDB[i].content = commentDB[i].content.replace(/\n/gi,'</br>');
  }

  //댓글 평점 별로 정렬
  let goodCommentDB = commentDB.filter((comment) => comment.score == 5);
  let sosoCommentDB = commentDB.filter((comment) => comment.score == 3);
  let badCommentDB = commentDB.filter((comment) => comment.score == 1);

  reviewBtn.addEventListener('click', openReviewPage); //리뷰 작성 페이지 열기
  likeBtn.addEventListener('click', manageLike); // 즐겨찾기
  reviewRightMenu.addEventListener('click', (event) => sortReviewPage(event));
  window.onload = calcViewCounter; // 페이지 로드 시, 페이지 뷰 계산

  function openReviewPage() {
    window.open('./review.html');
  }

  //즐겨찾기 유무에 따라 색상 설정
  function manageLike() {
    if (LIKE) {
      // 좋아요 상태라면
      likeBtn.style.color = '#ec6938';
    } else {
      likeBtn.style.color = '#a9a9a9';
    }
    //웹페이지 색상변경
  }

  //리뷰 정렬, 포인터 위치 조정 필요
  function sortReviewPage(event) {
    console.log(event);
    const target = event.target;

    if (target == reviewMenuTotal) {
      reviewCategory.forEach((menu) => (menu.style.color = '#a9a9a9'));
      reviewMenuTotal.style.color = '#ec6938';
      reviewCount.innerHTML = '(' + commentDB.length  + ')';
      printReview(commentDB);
    } else if (target == reviewMenuGood) {
      reviewCategory.forEach((menu) => (menu.style.color = '#a9a9a9'));
      reviewMenuGood.style.color = '#ec6938';
      reviewCount.innerHTML = '(' + goodCommentDB.length + ')';
      printReview(goodCommentDB);
    } else if (target == reviewMenuSoso) {
      reviewCategory.forEach((menu) => (menu.style.color = '#a9a9a9'));
      reviewMenuSoso.style.color = '#ec6938';
      reviewCount.innerHTML = '(' + sosoCommentDB.length + ')';
      printReview(sosoCommentDB);
    } else {
      reviewCategory.forEach((menu) => (menu.style.color = '#a9a9a9'));
      reviewMenuBad.style.color = '#ec6938';
      reviewCount.innerHTML = '(' + badCommentDB.length + ')';
      printReview(badCommentDB);
    }
  }

  //각 리뷰 평점, 이모티콘으로 출력
  function printScore(score) {
    let scoreImogi;
    if (score == 1) {
      scoreImogi = '<i class="far fa-angry"></i><span>별로</span>';
    } else if (score == 3) {
      scoreImogi = '<i class="far fa-smile"></i><span class=`review__score`>괜찮아요</span>';
    } else {
      scoreImogi = '<i class="far fa-grin-squint"></i><span>맛있어요</span>';
    }
    return scoreImogi;
  }

  //리뷰 출력
  function printReview(DB) {
    reviewContainer.innerHTML = '';
    for (let i = 0; i < DB.length; i++) {
      const db = DB[i];
      const reviewBox = document.createElement('div');
      const reviewLeft = document.createElement('div');
      const reviewCenter = document.createElement('div');
      const reviewRight = document.createElement('div');
      const reviewAvatar = document.createElement('div');
      const reviewId = document.createElement('div');
      const reviewDate = document.createElement('span');
      const reviewContent = document.createElement('span');
      const reviewDivider = document.createElement('div');

      reviewBox.className = 'review review${i}';
      reviewLeft.className = 'review-left';
      reviewCenter.className = 'review-center';
      reviewRight.className = 'review-right';
      reviewAvatar.className = 'review__profile-picture';
      reviewId.className = 'review__profile-id';
      reviewDate.className = 'review__date';
      reviewContent.className = 'review__content';

      reviewContainer.appendChild(reviewBox);
      reviewContainer.appendChild(reviewDivider);
      reviewBox.appendChild(reviewLeft);
      reviewBox.appendChild(reviewCenter);
      reviewBox.appendChild(reviewRight);
      reviewLeft.appendChild(reviewAvatar);
      //reviewAvatar db 코드
      reviewLeft.appendChild(reviewId);
      reviewCenter.appendChild(reviewDate);
      reviewCenter.appendChild(reviewContent);

      //출력
      reviewId.innerHTML = db.uid;
      reviewDate.innerHTML = db.time;
      reviewContent.innerHTML = db.content;
      reviewRight.innerHTML = printScore(db.score); // 음식점 평점을 이모티콘으로 변경
    }
  }

  //리뷰 메뉴 출력
  function printReviewHeader(commentDB) {
    reviewCount.innerHTML = '('+commentDB.length+')';
    reviewMenuTotal.innerHTML = '전체 (' + commentDB.length + ')';
    reviewMenuGood.innerHTML = '맛있다 (' + goodCommentDB.length + ')';
    reviewMenuSoso.innerHTML = '괜찮다 (' + sosoCommentDB.length + ')';
    reviewMenuBad.innerHTML = '별로 (' + badCommentDB.length + ')';
  }

  //상세 페이지 뷰 카운터
  function calcViewCounter() {
    let count = 0;
    count = parseInt(viewCounter.innerHTML);
    count++;
    viewCounter.innerHTML = count;
    // db에 뷰 카운트 보내는 코드
    <%control.addViews(r_num);%>
  }

  //리뷰 카운터 출력
  function printReviewCounter(commentDB) {
    reviewCounter.innerHTML = commentDB.length;
  }

  //음식점 정보 출력
  function printInfos(restaurantDB) {
    const heads = restaurantDB.info_heads;
    const infos = restaurantDB.infos;

    for (let i = 0; i < heads.length; i++) {
      const infoBox = document.createElement('div');
      const infoHead = document.createElement('span');
      const infoData = document.createElement('span');
      infoContainer.appendChild(infoBox);
      infoBox.appendChild(infoHead);
      infoBox.appendChild(infoData);
      infoBox.className = 'nfo__box';
      infoHead.className = 'info__items';
      infoData.className = 'info__data';

      infoHead.innerHTML = heads[i];
      infoData.innerHTML = infos[i];
    }
  }

  let likeCountFromDB = <%=control.getLikesCount(r_num)%>; // 좋아요 카운트 db 예시 값
  function printlikeCounter(likeCountFromDB) {
    likeCounter.innerHTML = likeCountFromDB;
  }

  let viewCountFromDB = { view: <%=restaurant.getViews()%> }; // 뷰 카운트 db 예시 값
  function printViewCounter(viewCountFromDB) {
    viewCounter.innerHTML = viewCountFromDB.view;
  }

  //주소 출력
  function printAddr(restaurantDB) {
    infoContainer.innerHTML = '<div class="info__address info__box"><span class="info__items">주소</span><span class="info__data">' + restaurantDB.addr+ '</span></div>';
  }

  //상호명 출력
  function printTitle(restaurantDB) {
    resName.innerHTML = restaurantDB.name;
  }

  function printAll() {
    printTitle(restaurantDB); // 상호명 출력
    printAddr(restaurantDB); // 주소 출력
    printInfos(restaurantDB); // 상세 정보 출력
    printViewCounter(viewCountFromDB); //인자는 db에서 가져온 뷰 데이터
    printReviewCounter(commentDB); // 인자는 db에서 가져온 코멘트 데이터
    printlikeCounter(likeCountFromDB); //인자는 db에서 가져온 좋아요 데이터
    printReviewCounter(commentDB); // 페이지에 리뷰 출력
    printReviewHeader(commentDB);
    printReview(commentDB);
    manageLike();
  }
  
  console.log(restaurantDB);

  printAll();
  
  function goReview() {
	  let r_num = '<%=r_num%>'
	  location.href="review.html?r_num="+r_num+"&name="+restaurantDB.name
}
  function setLike() {
	if(LIKE){
		likeCountFromDB--;
		LIKE = false;
	}
	else{
		likeCountFromDB++;
		LIKE = true;
	}
	
	likeCounter.innerHTML = likeCountFromDB;
	manageLike();
	
			$.ajax({ // 즐겨찾기 정보를 데이터베이스로 넘겨주기 위함
				url : 'setLike.jsp', //데이터베이스에 접근해 현재페이지로 결과를 뿌려줄 페이지
				mathod : 'post',
				data : {
					r_num : '<%=r_num%>'		// 음식점 id를 넘겨줌
				},
				success : function(data) { //DB접근 후 가져온 데이터
					
				}
			})
}
  </script>
</html>