//db에서 실제로 가져와야할 값
let obj = [
  {
    title: '여행 제목',
    start: '2021-05-25',
    end: '2021-05-28', //일정이 25~27일 이라면  + 1일 해서 28일을 End day로 설정할 것, calendar api 문제
  },
];

function printCalendar(obj) {
  var calendarEl = document.getElementById('calendar');

  var calendar = new FullCalendar.Calendar(calendarEl, {
    contentHeight: 'auto',
    initialView: 'dayGridMonth',
    locale: 'ko',
    initialDate: obj[0].start, // 속성 명 변경 시 주의
    headerToolbar: {
      start: '',
      center: 'title',
      end: '',
    },
    events: obj,
  });

  calendar.render();
}

printCalendar(obj);
