'use strict';

const resName = document.querySelector('.res-name');
const goodBtn = document.querySelector('.good-btn');
const sosoBtn = document.querySelector('.soso-btn');
const badBtn = document.querySelector('.bad-btn');
const btnBox = document.querySelector('.comment__button-box');
const btns = document.querySelectorAll('.comment-btns');
const textBox = document.querySelector('.main__comment');
const charCounter = document.querySelector('.string-checker');
const submitBtn = document.querySelector('.write-btn');
const cancelBtn = document.querySelector('.cancel-btn');

btnBox.addEventListener('click', chnageBtnColor);
textBox.addEventListener('input', manageElements);
submitBtn.addEventListener('click', manageInfo);
cancelBtn.addEventListener('click', () => {
	window.close();
}); // 창 닫기

const this_url = new URL(window.location.href);
const urlParams = this_url.searchParams;
const r_num = urlParams.get('r_num');

//서버에서 가져올 레스토랑 정보 예시
let restaurantDB = {
	name: urlParams.get('name'),
};

//서버로 보낼 평점,코멘트
let commentInfo = {};

//평점
let score;

function manageInfo() {
	saveInfo(); // 서버로 보낼 정보 담기
	// 서버로 보내기 코드 작성
	let to_url = 'saveReview.jsp?r_num=' + r_num + '&score=' + commentInfo.score;
	var form = document.createElement("form");
	form.setAttribute("method", "post");
	form.setAttribute("action", to_url);
	var hiddenField = document.createElement("input");
	hiddenField.setAttribute("type", "hidden");
	hiddenField.setAttribute("name", "comment");
	hiddenField.setAttribute("value", commentInfo.comment);
	form.appendChild(hiddenField);
	document.body.appendChild(form);
    form.submit();
}

//서버로 보낼 정보 담기
function saveInfo() {
	if (score) {
		commentInfo.score = score;
	} else {
		commentInfo.score = 3;
	}
	commentInfo.comment = textBox.value;
}

//제출버튼, 글자 수 확인
function manageElements(event) {
	changeBtnState(event);
	printCharCounter(event);
}

//제출 버튼 상태 변경
function changeBtnState(event) {
	const target = event.target;
	const currentLength = target.value.length;

	if (currentLength == 0 || currentLength == undefined) {
		submitBtn.disabled = true;
		submitBtn.classList.remove('available');
		submitBtn.classList.add('disabled');
	} else {
		submitBtn.disabled = false;
		submitBtn.classList.remove('disabled');
		submitBtn.classList.add('available');
	}
}

//글자 수 확인
function printCharCounter(event) {
	const target = event.target;
	const maxLength = target.getAttribute('maxLength');
	const currentLength = target.value.length;
	charCounter.innerHTML = `${currentLength} / ${maxLength}`;
}

//상단 평점 버튼 색상 변경
function chnageBtnColor(event) {
	const target = event.target;
	const parentNode = event.target.parentNode;

	if (target == goodBtn || parentNode == goodBtn) {
		btns.forEach((menu) => (menu.style.color = `#a9a9a9`));
		goodBtn.style.color = '#ec6938';
		score = 5;
	} else if (target == sosoBtn || parentNode == sosoBtn) {
		btns.forEach((menu) => (menu.style.color = `#a9a9a9`));
		sosoBtn.style.color = '#ec6938';
		score = 3;
	} else if (target == badBtn || parentNode == badBtn) {
		btns.forEach((menu) => (menu.style.color = `#a9a9a9`));
		badBtn.style.color = '#ec6938';
		score = 1;
	}
}

//초기 글자 수 출력
function initialCounter() {
	charCounter.innerHTML = `0 / 10000`;
}

//음식점 이름
function printResName(restaurantDB) {
	resName.innerHTML = `${restaurantDB.name}`;
}

function printAll() {
	printResName(restaurantDB); //음식점 이름
	initialCounter(); //초기 글자 수 출력
}

printAll();
