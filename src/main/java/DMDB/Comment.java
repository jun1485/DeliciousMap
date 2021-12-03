package DMDB;

import java.sql.Timestamp;
import java.util.ArrayList;

public class Comment {		// 댓글을 표현할 객체
	private String content; 	// 내용
	private String uid;			// 댓글 작성자 id
	private Timestamp commenting_time;	// 댓글 작성 시간, 타임스탬프
	private ArrayList<Comment> replys;		// 해당 댓글에 대한 답 댓글들을 가짐
	private int key;							// 댓글의 키 값
	
	public Comment(String content, String uid, Timestamp commenting_time, int key) {
		this.commenting_time = commenting_time;
		this.uid = uid;
		this.key = key;
		replys = new ArrayList<Comment>();
		this.content = content.replace("\r\n", "<br>");;

	}
	
	public String getContent() {
		return this.content;
	}
	
	public String getUid() {
		return this.uid;
	}
	
	public Timestamp getCommenting_time() {
		return this.commenting_time;
	}
	
	public void addReply(String content, String uid, Timestamp commenting_time, int key) {
		Comment reply = new Comment(content, uid, commenting_time, key);
		this.replys.add(reply);
	}
	
	public ArrayList<Comment> getReplys(){
		return this.replys;
	}

	public int getKey() {
		return key;
	}
	
	public int getRelpyCount() {
		return this.replys.size();
	}
}
