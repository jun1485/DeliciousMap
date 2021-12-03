package DMDB;

public class ScheduleForView {						// 특정 유저의 모든 스케줄을 키, 이름의 정보를 배열로 저장하기 위한 클래스
	private String name;
	private int key;
	private String start_day;
	private String end_day;
	
	public ScheduleForView(String name, int key, String start_day, String end_day) {
		this.name = name;
		this.key = key;
		this.start_day = start_day;
		this.end_day = end_day;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void setKey(int key) {
		this.key = key;
	}
	
	public String getName(){
		return this.name;
	}
	
	public int getKey(){
		return this.key;
	}
	
	public String getStart_day() {
		return this.start_day;
	}
	
	public String getEnd_day() {
		return this.end_day;
	}
}
