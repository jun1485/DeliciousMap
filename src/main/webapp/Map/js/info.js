'use strict';

// 로그인 연동, firebase 사용하지 않는다면 대체 코드 삽입
//
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

const url = new URL(document.location.href);
const urlParams = url.searchParams;

let r_num = urlParams.get('r_num');

reviewBtn.addEventListener('click', openReviewPage); //리뷰 작성 페이지 열기
likeBtn.addEventListener('click', manageLike); // 즐겨찾기
window.onload = calcViewCounter; // 페이지 로드 시, 페이지 뷰 계산

function openReviewPage() {
	window.open('./review.html');
}

//즐겨찾기 기능, 미완
function manageLike() {
	$.ajax({
		url: 'ajaxTest.jsp', //데이터베이스에 접근해 현재페이지로 결과를 뿌려줄 페이지
		mathod: 'post',
		data: {
			r_num: r_num //dbGet.jsp페이지로 데이터를 보냄
		},
		success: function(item) { //DB접근 후 가져온 데이터
			Like = $.trim(item)
			if (LIKE) {
				// 좋아요 상태라면
				likeBtn.style.color = '#a9a9a9';
				LIKE = false;
			} else {
				likeBtn.style.color = '#ec6938';
				LIKE = true;
			}
		}
	})
	//웹페이지 색상변경

	//해당 장소에 좋아요 카운트
	//내 정보에 좋아요 저장
}

//각 리뷰 평점, 이모티콘으로 출력
function printScore(score) {
	let scoreImogi;
	if (score == 1) {
		scoreImogi = `
    <i class="far fa-angry"></i>
    <span>별로</span>
    `;
	} else if (score == 3) {
		scoreImogi = `
    <i class="far fa-smile"></i>
    <span class='review__score'>괜찮아요</span>
    `;
	} else {
		scoreImogi = `
    <i class="far fa-grin-squint"></i>
    <span>맛있어요</span>
    `;
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

		reviewBox.className = `review review${i}`;
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
	reviewCount.innerHTML = `(${commentDB.length})`;
	reviewMenuTotal.innerHTML = `전체 (${commentDB.length})`;
	reviewMenuGood.innerHTML = `맛있다 (${goodCommentDB.length})`;
	reviewMenuSoso.innerHTML = `괜찮다 (${sosoCommentDB.length})`;
	reviewMenuBad.innerHTML = `별로 (${badCommentDB.length})`;
}

//상세 페이지 뷰 카운터
function calcViewCounter() {
	let count = 0;
	count = parseInt(viewCounter.innerHTML);
	count++;
	viewCounter.innerHTML = count;
	// db에 뷰 카운트 보내는 코드
}

//리뷰 카운터 출력
function printReviewCounter(commentDB) {
	reviewCounter.innerHTML = `${commentDB.length}`;
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
		infoBox.className = `info__box`;
		infoHead.className = `info__items`;
		infoData.className = `info__data`;

		infoHead.innerHTML = ` ${heads[i]}`;
		infoData.innerHTML = ` ${infos[i]}`;
	}
}

function printlikeCounter(likeCountFromDB) {
	likeCounter.innerHTML = `${likeCountFromDB}`;
}

function printViewCounter(viewCountFromDB) {
	viewCounter.innerHTML = `${viewCountFromDB.view}`;
}

//주소 출력
function printAddr(restaurantDB) {
	infoContainer.innerHTML = `
  <div class="info__address info__box">
  <span class="info__items">주소</span>
  <span class="info__data">${restaurantDB.addr}</span>
</div>
  `;
}

//상호명 출력
function printTitle(restaurantDB) {
	resName.innerHTML = `${restaurantDB.name}`;
}

function printAll() {
	$.ajax({
		url: 'ajaxTest.jsp', //데이터베이스에 접근해 현재페이지로 결과를 뿌려줄 페이지
		mathod: 'post',
		data: {
			'r_num': r_num //dbGet.jsp페이지로 데이터를 보냄
		},
		success: function(item) { //DB접근 후 가져온 데이터
			json = JSON.parse($.trim(item))
			console.log(json);
			restaurantDB = json.restaurantDB;
			viewCountFromDB = json.viewCountFromDB;
			commentDB = json.commentDB;
			likeCountFromDB = json.likeCountFromDB;

			//댓글 평점 별로 정렬
			let goodCommentDB = commentDB.filter((comment) => comment.score == 5);
			let sosoCommentDB = commentDB.filter((comment) => comment.score == 3);
			let badCommentDB = commentDB.filter((comment) => comment.score == 1);

			//리뷰 정렬, 포인터 위치 조정 필요
			function sortReviewPage(event) {
				console.log(event);
				const target = event.target;

				if (target == reviewMenuTotal) {
					reviewCategory.forEach((menu) => (menu.style.color = `#a9a9a9`));
					reviewMenuTotal.style.color = '#ec6938';
					reviewCount.innerHTML = `(${commentDB.length})`;
					printReview(commentDB);
				} else if (target == reviewMenuGood) {
					reviewCategory.forEach((menu) => (menu.style.color = `#a9a9a9`));
					reviewMenuGood.style.color = '#ec6938';
					reviewCount.innerHTML = `(${goodCommentDB.length})`;
					printReview(goodCommentDB);
				} else if (target == reviewMenuSoso) {
					reviewCategory.forEach((menu) => (menu.style.color = `#a9a9a9`));
					reviewMenuSoso.style.color = '#ec6938';
					reviewCount.innerHTML = `(${sosoCommentDB.length})`;
					printReview(sosoCommentDB);
				} else {
					reviewCategory.forEach((menu) => (menu.style.color = `#a9a9a9`));
					reviewMenuBad.style.color = '#ec6938';
					reviewCount.innerHTML = `(${badCommentDB.length})`;
					printReview(badCommentDB);
				}
			}
			reviewRightMenu.addEventListener('click', (event) => sortReviewPage(event));

			printTitle(restaurantDB); // 상호명 출력
			printAddr(restaurantDB); // 주소 출력
			printInfos(restaurantDB); // 상세 정보 출력
			printViewCounter(viewCountFromDB); //인자는 db에서 가져온 뷰 데이터
			printReviewCounter(commentDB); // 인자는 db에서 가져온 코멘트 데이터
			printlikeCounter(likeCountFromDB); //인자는 db에서 가져온 좋아요 데이터
			printReviewCounter(commentDB); // 페이지에 리뷰 출력
			printReviewHeader(commentDB);
			printReview(commentDB);
		}
	})
}

printAll();
