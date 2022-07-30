package DMDB;
import java.sql.Timestamp;
import java.util.Calendar;


public class Element {						// 스케줄에 들어가는 한 장소
	private GeoPoint gp;						// 위도, 경도를 가지는 gp
	private Timestamp start_time;			// 타임스탬프 형식의 시작 시간 년,월,일,시,분,초
	private Timestamp end_time;			// 타임스탬프 형식의 끝 시간 년,월,일,시,분,초
	private String name;						// 장소의 이름
	private String memo;						// 장소의 메모
	private int dayCount;						// 시작일로부터 몇 일 후의 스케줄인지를 알기 위한 정수 값
	private String key;							// 스케줄 객체의 요소를 인식하기위한 번호
	private String r_num;						// 상세정보 페이지로 향하기 위한 인식번호
	private boolean isRes;					// 해당 요소가 음식점 인지 아닌지
	
	public boolean isRes() {
		return isRes;
	}

	public void setRes(boolean isRes) {
		this.isRes = isRes;
	}

	public Element(GeoPoint gp,Timestamp start_time2, Timestamp end_time2, String name){	// 생성자1
		this.gp = gp;
		this.start_time = start_time2;
		this.end_time = end_time2;
		this.name = name;
	}
	
	public Element(String name){		// 생성자2
		this.name = name;
	}
	
	public void setR_num(String r_num) {
		this.r_num = r_num;
	}
	
	public void setMemo(String memo) {		
		this.memo = memo;
	}
	
	public void setGP(double x, double y) {		// 위도, 경도로 x, y값을 가짐
		this.gp = new GeoPoint(x, y);
	}
	
	private Timestamp setTime(int y, int m, int d, int h) {					// 타임스탬프 형식으로 저장하기 위한 함수
		String dateTime = y +"-" + m + "-" + d + " " + h+":00:00";
		
        Timestamp timestamp =Timestamp.valueOf(dateTime);
        
        return timestamp;
	}
	
	public void setStartTime(int year, int month, int day, int hour) {
		this.start_time = setTime(year, month, day, hour);
	}
	
	public void setEndTime(int year, int month, int day, int hour) {
		this.end_time = setTime(year, month, day, hour);
	}
	
	public void setStartTime(long time) {
		this.start_time = new Timestamp(time);
	}
	
	public void setEndTime(long time) {
		this.end_time =  new Timestamp(time);
	}
	
	public GeoPoint getGP() {
		// TODO Auto-generated method stub
		return this.gp;
	}
	
	public Timestamp getStartTime_timestamp() {			// timestamp형식의 시작시간
		// TODO Auto-generated method stub
		return this.start_time;
	}
	
	public int getStartTime() {						 // 시작시간의 Hour만 리턴
		int time;
		
		Calendar cal = Calendar.getInstance();
		
		cal.setTimeInMillis(this.start_time.getTime());
		
		int ampm = cal.get(Calendar.AM_PM);
		time = cal.get(Calendar.HOUR);
		if(ampm == 0)
			return time;
		else
			return time + 12;
	}
	public Timestamp getEndTime_timestamp() {		// timestamp 형식의 끝 시간
		// TODO Auto-generated method stub
		return this.end_time;
	}
	public int getEndTime() {						// 끝 시간의 Hour만 리턴
		int time;
		
		Calendar cal = Calendar.getInstance();
		
		cal.setTimeInMillis(this.end_time.getTime());
		
		int ampm = cal.get(Calendar.AM_PM);
		time = cal.get(Calendar.HOUR);
		if(ampm == 0)
			return time;
		else
			return time + 12;
	}
	public String getName() {
		// TODO Auto-generated method stub
		return this.name;
	}
	public String getMemo() {
		// TODO Auto-generated method stub
		return this.memo;
	}

	public int getDayCount() {
		return dayCount;
	}

	public void setDayCount(int dayCount) {
		this.dayCount = dayCount;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String string) {
		this.key = string;
	}
	
	public String getDate() {
		
		Calendar c = Calendar.getInstance();
		c.setTimeInMillis(start_time.getTime());
		int year = c.get(Calendar.YEAR);
		int month = c.get(Calendar.MONTH) + 1;
		int day = c.get(Calendar.DAY_OF_MONTH);
		String mst, dst;
		if(month < 10)
			mst = "0" + month;
		else
			mst = "" + month;
		
		if(day < 10)
			dst = "0" + day;
		else
			dst = "" + day;
		
		String date = year + "-" + mst + "-" + dst;

		return date;
	}
	
	public String timeString() {
		
		Calendar cal = Calendar.getInstance();
		
		cal.setTimeInMillis(this.start_time.getTime());
		
		int sampm = cal.get(Calendar.AM_PM);
		int stime = cal.get(Calendar.HOUR);
		
		String sAP;
		if(sampm == 0)
			sAP = "AM";
		else {
			sAP = "PM";
			if(stime == 0)
				stime = 12;
		}
		
		cal.setTimeInMillis(this.end_time.getTime());
		
		int eampm = cal.get(Calendar.AM_PM);
		int etime = cal.get(Calendar.HOUR);
		
		String eAP;
		if(eampm == 0)
			eAP = "AM";
		else {
			eAP = "PM";
			if(etime == 0)
				etime = 12;
		}
		
		return sAP + " " + stime + " ~ " + eAP + " " + etime;
	}
	
	public String getR_num() {
		return r_num;
	}
}
