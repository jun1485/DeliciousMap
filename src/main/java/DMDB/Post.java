package DMDB;

import java.sql.Timestamp;
import java.util.ArrayList;

public class Post {
	private String title;
	private String content;
	private String uid;
	private ArrayList<Schedule> schedule;
	private Timestamp posting_time;
	private int key;
	private int views;
	private int recommendation_count;
	
	public Post() {
		schedule = new ArrayList<Schedule>();
	}
	
	public Post(String title, String content, String uid) {
		this.title = title;
		this.content = content;
		this.uid = uid;
	}
	
	public void setSchedule(ArrayList<Schedule> schedule) {
		this.schedule = schedule;
	}
	
	public void setViews(long views) {
		this.views = (int)views;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public void setUid(String uid) {
		this.uid = uid;
	}
	
	public void setTime(long time) {
		posting_time = new Timestamp(time);
	}
	
	public Timestamp getTime() {
		return this.posting_time;
	}
	
	public String getDate() {
		String time = this.posting_time.toString();
		
		return time.substring(0, 10);
	}
	
	public int getViews() {
		return this.views;
	}
	
	public String getTitle() {
		return this.title;
	}
	
	public String getContent() {
		return this.content;
	}
	
	public String getUid() {
		return this.uid;
	}
	
	public ArrayList<Schedule> getSchedule(){
		return this.schedule;
	}

	public int getKey() {
		return key;
	}

	public void setKey(int key) {
		this.key = key;
	}

	public int getRecommendation_count() {
		return recommendation_count;
	}

	public void setRecommendation_count(long recommendation_count) {
		this.recommendation_count = (int)recommendation_count;
	}
}
