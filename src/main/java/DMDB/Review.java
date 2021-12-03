package DMDB;

import java.util.Calendar;

import org.json.simple.JSONObject;

public class Review {
	private String r_num;
	private int c_num;
	private String uid;
	private String content;
	private int score;
	private long time;

	public Review(String r_num, String uid, String content, int score, long time, int c_num) {
		this.r_num = r_num;
		this.uid = uid;
		this.content = content;
		this.score = score;
		this.time = time;
		this.c_num = c_num;
	}

	public String getR_num() {
		return r_num;
	}

	public String getUid() {
		return uid;
	}

	public String getContent() {
		return content;
	}

	public int getScore() {
		return score;
	}

	public String getTime() {

		Calendar c = Calendar.getInstance();
		c.setTimeInMillis(time);
		int year = c.get(Calendar.YEAR);
		int month = c.get(Calendar.MONTH) + 1;
		int day = c.get(Calendar.DAY_OF_MONTH);

		return year + "-" + month + "-" + day;
	}

	public int getC_num() {
		return c_num;
	}

	public JSONObject getJson() {
		JSONObject json = new JSONObject();

		json.put("cNumber", c_num);
		json.put("uid", uid);
		json.put("content", content);
		json.put("time", getTime());
		json.put("score", score);

		return json;
	}
}
