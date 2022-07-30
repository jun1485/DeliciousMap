package DMDB;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;

public class Schedule {								// 하나의 스케줄
	private String uid;									// 스케줄을 저장한 유저의 id
	private int key;									// DB에서 해당 스케줄의 고유 키값
	private String name;								// 스케줄의 이름
	private ArrayList<Element> elementArray;	// 스케줄에 포함되는 장소들의 배열
	private String memo;								// 유저가 작성한 스케줄에 대한 메모
	private Timestamp date;							// 해당 스케줄의 날짜
	private Timestamp end_day;					// DB에 저장할 때, 스케줄 배열중 첫번째 스케줄의 정보만 이용하여 저장하기 위해, 스케줄의 끝 날짜
	private boolean [] timeChecker = new boolean [24];			// 스케줄 요소의 시간 중복을 방지하기 위해 사용할 boolean 배열, false으로 초기화
	
	public Schedule(String uid){				// 생성자 uid 설정
		elementArray = new ArrayList<Element>();
		this.uid = uid;
		timeChecker =  new boolean [24];
	}

	public Schedule(){								// 테스트용 생성자
		elementArray = new ArrayList<Element>();
		this.uid = null;
		timeChecker =  new boolean [24];
	}

	public String getUid() {
		return this.uid;
	}
	
	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getName() {
		return this.name;
	}

	public int getKey() {
		return this.key;
	}

	public String getMemo() {
		return this.memo;
	}

	public Timestamp getDate() {
		return this.date;
	}
	
	public String getDateString() {
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(date.getTime());
		
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int day = cal.get(Calendar.DATE);
		
		String monthString = null;
		String dayString = null;
		
		if(month < 10)
			monthString =  "0" + Integer.toString(month);
		else
			monthString = Integer.toString(month);
		
		if(day < 10)
			dayString = "0" + Integer.toString(day);
		else
			dayString = Integer.toString(day);
		
		
		return year + "-" + monthString + "-" + dayString;
		
	}

	public Timestamp getEnd_Day() {
		return this.end_day;
	}
	
	public String getEnd_DayString() {
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(end_day.getTime());
		
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int day = cal.get(Calendar.DATE);
		
		String monthString = null;
		String dayString = null;
		
		if(month < 10)
			monthString =  "0" + Integer.toString(month);
		else
			monthString = Integer.toString(month);
		
		if(day < 10)
			dayString = "0" + Integer.toString(day);
		else
			dayString = Integer.toString(day);
		
		
		return year + "-" + monthString + "-" + dayString;
		
	}
	
	public String getDateString_plus_1day() {
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(date.getTime());
		
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int day = cal.get(Calendar.DATE) + 1;
		
		String monthString = null;
		String dayString = null;
		
		if(month < 10)
			monthString =  "0" + Integer.toString(month);
		else
			monthString = Integer.toString(month);
		
		if(day < 10)
			dayString = "0" + Integer.toString(day);
		else
			dayString = Integer.toString(day);
		
		
		return year + "-" + monthString + "-" + dayString;
	}

	public void addElement(Element element) {
		int i = 0;
		for(; i < elementArray.size(); i++) {
			if(elementArray.get(i).getStartTime() > element.getStartTime()) {
				elementArray.add(i, element);
				break;
			}
		}
		if(i == elementArray.size())
			elementArray.add(element);
		
		for(i = element.getStartTime(); i < element.getEndTime(); i++) {
			timeChecker[i] = true;
		}
	}

	public void setKey(int key) {
		// TODO Auto-generated method stub
		this.key = key;
	}

	public void setName(String name) {
		// TODO Auto-generated method stub
		this.name = name;
	}

	public Element getElementI(int i) {				// 특정 장소 하나
		return this.elementArray.get(i);
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public void setDate(int y, int m, int d) {
		String dateTime = y +"-" + m + "-" + d + " 00:00:00";

		date =Timestamp.valueOf(dateTime);
	}
	
	public void setDate(long time) {

		date = new Timestamp(time);
	}

	public void setEnd_Day(int y, int m, int d) {	
		String dateTime = y +"-" + m + "-" + d + " 00:00:00";

		end_day =Timestamp.valueOf(dateTime);
	}
	
	public void setEnd_Day(long time) {
		end_day = new Timestamp(0);
		
		end_day.setTime(time);
	}

	public ArrayList<Element> getElement(){
		return this.elementArray;
	}

	public int getElementCount() {
		return this.elementArray.size();
	}
	
	public int deleteElement(int start) {
		for(int i = 0; i < elementArray.size(); i++) {
			if(elementArray.get(i).getStartTime()== start) {
				for(int j = elementArray.get(i).getStartTime(); j < elementArray.get(i).getEndTime(); j++) {
					timeChecker[j] = false;
				}
				elementArray.remove(i);
				return 1;
			}
		}
		return -1;
	}
	
	public void setTimeChecker(int start, int end) {
		for(int i = start; i < end; i++) {
			timeChecker[i] = true;
		}
	}
	
	public boolean timeCheck(int start, int end) {
		for(int i = start; i < end; i++) {
			if(timeChecker[i]) {
				return false;					// 이미 있는 시간대 false 리턴
			}
		}
		return true;							// 추가 가능한 시간대 true 리턴
	}
	
	public boolean [] getTimeChecker() {
		return timeChecker;
	}
	
	public Element getElementByStart(int start_time) {
		for(int i = 0; i < elementArray.size(); i++) {
			if(elementArray.get(i).getStartTime() == start_time)
				return elementArray.get(i);
		}
		return null;
	}
}
