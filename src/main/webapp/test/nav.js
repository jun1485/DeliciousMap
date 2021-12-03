const schedule = document.querySelector('.header__menu__schedule');
const map = document.querySelector('.header__menu__map');
const board = document.querySelector('.header__menu__board');
const logOut = document.querySelector('.header__menu__log-out');
const logo = document.querySelector('.header__icon-logo');

//main.html 주소
logo.addEventListener('click',()=>{
  const manageScheduleUrl = '';
  location.assign(manageScheduleUrl);
})

//main.html 주소
schedule.addEventListener('click', () => {
  const manageScheduleUrl = '';
  location.assign(manageScheduleUrl);
});

//지도 탐색 페이지(?) 주소
map.addEventListener('click', () => {
  const searchMapUrl = '';
  location.assign(searchMapUrl);
});

//게시판 주소
board.addEventListener('click', () => {
  const boardUrl = '';
  location.assign(boardUrl);
});

logOut.addEventListener('click', () => {
  firebase
    .auth()
    .signOut()
    .then(() => {
      location.assign('./index.html');
    });
});
