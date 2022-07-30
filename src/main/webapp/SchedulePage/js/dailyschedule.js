'use strict';

//firebabse 웹 페이지 콘솔 -> 프로젝트 설정 -> sdk 설정 및 구성에서 복사
const firebaseConfig = {
  apiKey: 'AIzaSyBY9tPiZh08ejKX16WpQknxb03BQVH-YV8',
  authDomain: 'testlogin-46429.firebaseapp.com',
  databaseURL: 'https://testlogin-46429-default-rtdb.firebaseio.com',
  projectId: 'testlogin-46429',
  storageBucket: 'testlogin-46429.appspot.com',
  messagingSenderId: '1009454182432',
  appId: '1:1009454182432:web:b704be0a4ff752088c0c45',
};
firebase.initializeApp(firebaseConfig);

const navDays = document.querySelector('.main__nav__days');
const main = document.querySelector('.main-center');

//scheduleDB 전역 변수 가정하고 코드 작성했음
//실제 db에서 불러온 값, 속성 명 변경 시, 코드 전체적인 수정 필요함!
const scheduleDB = [
  {
    name: '스타벅스 영남대점',
    date: '2021-05-25',
    category: '카페',
    x: '123123',
    y: '456789',
  },
  {
    name: '스타벅스 중앙로점',
    date: '2021-05-25',
    category: '카페',
    x: '123123',
    y: '456789',
  },
  {
    name: '스타벅스 반월당점',
    date: '2021-05-26',
    category: '카페',
    x: '123123',
    y: '456789',
  },
  {
    name: '스타벅스 인천대점',
    date: '2021-05-27',
    category: '카페',
    x: '123123',
    y: '456789',
  },
  {
    name: '스타벅스 서울대점',
    date: '2021-05-27',
    category: '카페',
    x: '123123',
    y: '456789',
  },
  {
    name: '스타벅스 대전대점',
    date: '2021-05-27',
    category: '카페',
    x: '123123',
    y: '456789',
  },
  {
    name: '스타벅스 부산대점',
    date: '2021-05-27',
    category: '카페',
    x: '123123',
    y: '456789',
  },
  {
    name: '스타벅스 대구대점',
    date: '2021-05-27',
    category: '카페',
    x: '123123',
    y: '456789',
  },
];

let COMPONENTS = [];
let TOTALDAYS; // 일정 총 날짜 수
let STARTDATE; //첫 일정의 시작일

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
    li.innerText = `DAY ${i}`;
    li.dataset.day = `${i}`;
    navDays.appendChild(li);
  }
}

//스케줄을 초기화하는 함수
function setMainComponent() {
  createComponents();
}

//date 객체 string으로 변경
function changeDateObj(dateObj) {
  let yyyy = dateObj.getFullYear();
  let mm = dateObj.getMonth() + 1;
  let dd = dateObj.getDate();
  if (dd < 10) {
    dd = `0${dd}`;
  }
  if (mm < 10) {
    mm = `0${mm}`;
  }
  yyyy = yyyy.toString();
  mm = mm.toString();
  dd = dd.toString();
  let date = `${yyyy}-${mm}-${dd}`;
console.log(date);
  return date;
}

function divideDayInfo(dateObj) {
  const standardDate = changeDateObj(dateObj);
  console.log(standardDate);
  const eachDayInfo = scheduleDB.filter((element) => {
    return element.date == standardDate;
  });
	console.log(eachDayInfo);
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
              DAY ${i}
            </div>
            <div class="component-header__date">
              ${nextDate} 
            </div>
            `;
    component.setAttribute('class', 'main-center__component');
    component.dataset.id = `${i}`;
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

  for (let j = 1; j <= posCount; j++) {
    const body = document.createElement('div');
    body.innerHTML = `
            <div class="component-body__left-icon">
              <div class="component-body__left__number">
                ${j}
              </div>
            </div>
            <div class="component-body__info">
              <div class="component-body__info__txt-info">
                <div class="component-body__info__place">
                  ${placeName[j - 1]}
                </div>
                <div class="component-body__info__category">
                  ${category[j - 1]}
                </div>
              </div>
              <div class="component-body__info-icons">
                <i class="fas fa-info-circle review-btn"></i>
                <i class="fas fa-map-marker-alt marker-btn" data-number="${j}"></i>
              </div>
            </div>
    `;
    body.setAttribute('class', 'component-body');
    body.dataset.id = `${component.dataset.id}-${j}`;
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

console.log(scheduleDB);

function init() {
  getDate();
  printNavDays();
  setMainComponent();
}

init();
