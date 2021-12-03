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

//firebase.initializeApp(firebaseConfig);

const container = document.querySelector('.container');
const initComponent = document.querySelector('.initial-component');
const containerMain = document.querySelector('.container-main');
const editBtn = document.querySelector('.component__edit-btn');
const delBtn = document.querySelector('.component__delete-btn');
const modalBg = document.querySelector('.modal-bg');
const modal = document.querySelector('.modal');
const modalDelBtn = document.querySelector('.modal-header__btn');

initComponent.addEventListener('click', () => {
  showModal();
}); 

/* 
//스케줄 편집 버튼 - 편집 페이지 url
editBtn.addEventListener('click', () => {
  // edit schedule page
  const schedulePageUrl = '';
  // location.assign(schedulePageUrl);
});


delBtn.addEventListener('click', () => {
  // insert code, delete component from this page
  // insert code, delete schedule DB from firestore
});
*/
modal.addEventListener('click', (event) => {
  const target = event.target;
  if (target.parentNode == modalDelBtn) {
    closeModal();
  }
});

window.addEventListener('click', (event) => {
  const target = event.target;
  target === modalBg ? closeModal() : false;
});

function closeModal() {
  modalBg.classList.remove('show-modal-bg');
  modal.classList.add('hidden-modal');
  modal.classList.remove('show-modal');
}
function showModal() {
  modalBg.classList.add('show-modal-bg');
  modal.classList.remove('hidden-modal');
  modal.classList.add('show-modal');
}

/*
function loadSchedule(){
  SCHEDULE =  // ex)  [schedule, schedule, schedule, schedlue, ...]
  //insert code, load schedule-info from firestore.
}
*/

// 로드된 일정 정보 확인용 예시, 밑의 showLoadedComponent() 작성 후 삭제
function showLoadedComponent() {
  //for (let i = 0; i < SCHEDULE.length; i++) {
  const loadedComponent = document.createElement('section');

  loadedComponent.innerHTML = `
        <div class='component-content'>
          <span class="component__title"></span>
          <div class="component__icons">
            <button class="component__edit-btn">
              <i class="fas fa-pen"></i>
            </button>
            <button class="component__delete-btn">
               <i class="fas fa-trash-alt"></i>
            </button>
          </div>  
        </div>
          <div class="component__date">
            <span class="component__date-start"> 2021-05-15 </span>
            <span class="component__date-separator"> ~ </span>
            <span class="component__Date-end">2021-05-16</span>
          </div>
        `;
  loadedComponent.setAttribute('class', 'component loaded-component');
  containerMain.appendChild(loadedComponent);
  //}
  HTMLFormControlsCollection;

  loadedComponent.addEventListener('click', (event) => {
    const target = event.target;
    if (target.className == 'component-content') {
      const dailyScheduleUrl = './dailyschedule.html';
      location.assign(dailyScheduleUrl);
    }
  });
}

/* 
// db에서 가져온 일정 정보 출력하는 함수, db에서 스케줄 제목, 스케줄 시작일, 스케줄 종료일 가져와야 함
function showLoadedComponent() {
  //for (let i = 0; i < SCHEDULE.length; i++) {
  const loadedComponent = document.createElement('section');
  const title = // 스케줄 제목
  const startDate = //스케줄 시작 날짜
  const endDate = //스케줄 마지막 날짜

  loadedComponent.innerHTML = `
        <div class='component-content'>
          <span class="component__title"> ${title} </span>
          <div class="component__icons">
            <button class="component__edit-btn">
              <i class="fas fa-pen"></i>
            </button>
            <button class="component__delete-btn">
               <i class="fas fa-trash-alt"></i>
            </button>
          </div>  
        </div>
          <div class="component__date">
            <span class="component__date-start">${startDate}</span>
            <span class="component__date-separator"> ~ </span>
            <span class="component__Date-end">${endDate}</span>
          </div>
        `;
  loadedComponent.setAttribute('class', 'component loaded-component');
  containerMain.appendChild(loadedComponent);
  //}
  HTMLFormControlsCollection;
}
*/


function init() {
  //loadSchedule();
  // showLoadedComponent();
}

//init();
