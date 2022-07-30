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
