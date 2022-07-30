package DMDB;

import java.sql.*;
import java.util.ArrayList;

public class PostDbControl {
	String jdbc_driver;
	String jdbc_url;
	String db_name;
	String db_password;
	
	public PostDbControl() {
		DBInfo info = new DBInfo();
		this.jdbc_driver = info.jdbc_driver;
		this.jdbc_url = info.jdbc_url;
		this.db_name = info.db_name;
		this.db_password = info.db_password;
	}

	public void addNewPostToDb(String title, String content, String uid, int s_num) {	// 새로운 게시글을 생성, 저장
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select p_num from Post order by p_num desc;";
			preparedStatement = con.prepareStatement(sql);
			ResultSet resultSet = preparedStatement.executeQuery();

			int p_num = 0;

			if(resultSet.next())
				p_num = resultSet.getInt(1) + 1;

			sql = "insert into Post(p_num, uid, title, content, time, views) values(?, ?, ?, ?, ?, 0);";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, p_num);
			preparedStatement.setString(2, uid);
			preparedStatement.setString(3, title);
			preparedStatement.setString(4, content);
			preparedStatement.setLong(5, System.currentTimeMillis());
			preparedStatement.executeUpdate();

			sql = "insert into P_Schedule(uid, start, end, name) select uid, start, end, name from Schedule where uid = ? and s_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			preparedStatement.setInt(2, s_num);
			preparedStatement.executeUpdate();

			sql = "update P_Schedule set p_num = ? where p_num = -1";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, p_num);
			preparedStatement.executeUpdate();

			sql = "insert into P_Element(uid, start, end, latitude, longitude, name, r_num, isRes) select uid, start, end, latitude, longitude, name, r_num, isRes from Element where uid = ? and s_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			preparedStatement.setInt(2, s_num);
			preparedStatement.executeUpdate();

			sql = "update P_Element set p_num = ? where p_num = -1";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, p_num);
			preparedStatement.executeUpdate();

			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void editPost(String title, String content, int p_num) {
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "update Post set title = ?, content = ? where p_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, title);
			preparedStatement.setString(2, content);
			preparedStatement.setInt(3, p_num);
			preparedStatement.executeUpdate();

			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public Post loadPostFromDb(int post_key) {

		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select * from Post where p_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, post_key);
			ResultSet resultSet = preparedStatement.executeQuery();

			String title = null;
			String content = null;
			String uid = null;
			int views = 0;
			int recommendation_count = 0;
			long posting_time = 0;

			if(resultSet.next()){
				title = resultSet.getString("title");
				content = resultSet.getString("content");
				uid = resultSet.getString("uid");
				views = resultSet.getInt("views");
				recommendation_count = getRecommendCount(post_key);
				posting_time = resultSet.getLong("time");
			}

			Post post = new Post(title, content, uid);
			post.setTime(posting_time);
			post.setViews(views);
			post.setRecommendation_count(recommendation_count);

			ArrayList<Schedule> schedules = new ArrayList<Schedule>();	// post에 저장할 스케줄 배열

			String schedule_name = null;
			Timestamp start_day = null;
			Timestamp end_day = null;

			sql = "select * from P_Schedule where p_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, post_key);
			resultSet = preparedStatement.executeQuery();

			if(resultSet.next()) {
				// 각 날짜의 스케줄에 넣어줄 메모, 키, 이름 정보 저장
				schedule_name = resultSet.getString("name");
				// 시작날짜, 끝날짜 불러옴
				start_day = new Timestamp(resultSet.getLong("start"));
				end_day = new Timestamp(resultSet.getLong("end"));
			}

			// 시작날짜와 끝날짜의 차이만큼 스케줄 객체를 생성해서 배열에 넣음
			int dayCount = (int)((end_day.getTime() - start_day.getTime()) / (24*60*60*1000));

			for(int i = 0; i < dayCount + 1; i++) {
				Schedule schedule = new Schedule(uid);
				schedule.setName(schedule_name);
				schedule.setDate(start_day.getTime() + (long)(i * (24*60*60*1000)));
				schedules.add(schedule);
			}

			sql = "select * from P_Element where p_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, post_key);
			resultSet = preparedStatement.executeQuery();

			while (resultSet.next()) {
				GeoPoint gp = new GeoPoint(resultSet.getDouble("latitude"), resultSet.getDouble("longitude"));
				Timestamp start_time =new Timestamp(resultSet.getLong("start"));
				Timestamp end_time = new Timestamp(resultSet.getLong("end"));
				String name = resultSet.getString("name");
				String r_num = resultSet.getString("r_num");
				boolean isRes = resultSet.getBoolean("isRes");
				Element newElement = new Element(gp, start_time, end_time, name);
				newElement.setR_num(r_num);
				newElement.setRes(isRes);
				schedules.get((int)(start_time.getTime() - start_day.getTime()) / (24*60*60*1000)).addElement(newElement);
			}
			
			post.setSchedule(schedules);

			preparedStatement.close();
			resultSet.close();
			con.close();

			return post;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public void addNewCommentToPost(String content, String uid, int post_key, int reply_comment_key) {
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select c_num from Comment where p_num = ? order by c_num desc";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, post_key);
			ResultSet resultSet = preparedStatement.executeQuery();

			int c_num = 0;

			if(resultSet.next())
				c_num = resultSet.getInt(1) + 1;

			sql = "insert into Comment (c_num, p_num, uid, content, time, upper) VALUES (?, ?, ?, ?, ?, ?);";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, c_num);
			preparedStatement.setInt(2, post_key);
			preparedStatement.setString(3, uid);
			preparedStatement.setString(4, content);
			preparedStatement.setLong(5, System.currentTimeMillis());
			preparedStatement.setInt(6, reply_comment_key);
			preparedStatement.executeUpdate();

			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void editComment(String content, int post_key, int comment_key) {
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "update Comment set content = ? where p_num = ? and c_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, content);
			preparedStatement.setInt(2, post_key);
			preparedStatement.setInt(3, comment_key);
			preparedStatement.executeUpdate();

			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Comment> loadCommentFromDb(int post_key){		// 특정 게시글의 모든 댓글을 배열로 리턴

		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select * from Comment where p_num = ? order by time;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, post_key);
			ResultSet resultSet = preparedStatement.executeQuery();

			ArrayList<Comment> comments = new ArrayList<Comment>();

			while(resultSet.next()){
				String content = resultSet.getString("content");
				String uid = resultSet.getString("uid");
				Timestamp commenting_time = new Timestamp(resultSet.getLong("time"));
				int key = resultSet.getInt("c_num");
				int reply_comment_key = resultSet.getInt("upper");
				if(reply_comment_key == -1)
					comments.add(new Comment(content, uid, commenting_time, key));
				else {
					int i = 0;
					for(; i < comments.size(); i++) {
						if(comments.get(i).getKey() == reply_comment_key) {
							comments.get(i).addReply(content, uid, commenting_time, key);
							break;
						}
					}
					if(i == comments.size())
						System.out.println("댓글 불러오기 에러");
				}
			}

			preparedStatement.close();
			resultSet.close();
			con.close();

			return comments;

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}

	public void addViews(int post_key) {			// DB에 post_key에 해당하는 게시글의 조회수 1증가
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "update Post set views = views + 1 where p_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, post_key);
			preparedStatement.executeUpdate();

			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public ArrayList<Post> loadPostPageFromDb(int page) {

		if(page < 1) {
			System.out.println("잘못된 페이지");
			return null;
		}

		Connection con = null;

		int pageCount = 10 * (page - 1);
		ArrayList<Post> posts = new ArrayList<Post>();

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select title, uid, views, p_num, time from Post order by time desc limit ?, ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, pageCount);
			preparedStatement.setInt(2, pageCount+9);
			ResultSet resultSet = preparedStatement.executeQuery();

			while(resultSet.next()){
				String title = resultSet.getString("title");
				String uid = resultSet.getString("uid");
				int views = resultSet.getInt("views");
				int key = resultSet.getInt("p_num");
				int recommendation_count = getRecommendCount(key);
				long posting_time = resultSet.getLong("time");
				Post post = new Post();
				post.setTime(posting_time);
				post.setKey(key);
				post.setUid(uid);
				post.setTitle(title);
				post.setViews(views);
				post.setRecommendation_count(recommendation_count);
				posts.add(post);
			}

			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return posts;
	}

	public void deletePostFromDb(int post_key) {				// 게시글을 db에서 삭제
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "delete from Post where p_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, post_key);
			preparedStatement.executeUpdate();

			sql = "delete from Comment where p_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, post_key);
			preparedStatement.executeUpdate();

			sql = "delete from Recommend where p_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, post_key);
			preparedStatement.executeUpdate();

			sql = "delete from P_Schedule where p_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, post_key);
			preparedStatement.executeUpdate();

			sql = "delete from P_Element where p_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, post_key);
			preparedStatement.executeUpdate();			// 하나로 압축

			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void deleteCommentFromDb(int post_key, int comment_key) {		// 댓글을 db에서 삭제
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "delete from Comment where p_num = ? and (upper = ? or c_num = ?);";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, post_key);
			preparedStatement.setInt(2, comment_key);
			preparedStatement.setInt(3, comment_key);
			preparedStatement.executeUpdate();

			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public boolean isRecommendation(int post_key, String uid) {			// 특정 유저가 특정 게시글에 추천을 했는지 안햇는지
		Connection con = null;

		boolean result = false;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select * from Recommend where p_num = ? and uid = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, post_key);
			preparedStatement.setString(2, uid);
			ResultSet resultSet = preparedStatement.executeQuery();

			if(resultSet.next())
				result = true;

			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public int setRecommendationToPost(int post_key, String uid) {		// 유저가 추천을 하거나, 이미 추천했으면 추천을 취소
		Connection con = null;
		int result = -1;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = null;

			if(isRecommendation(post_key, uid))
				sql = "delete from Recommend where p_num = ? and uid = ?;";
			else {
				result = 1;
				sql = "insert into Recommend (p_num, uid) VALUES (?, ?);";
			}

			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, post_key);
			preparedStatement.setString(2, uid);
			preparedStatement.executeUpdate();

			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public ArrayList<Post> searchPost(int page, String keyword){

		Connection con = null;
		int pageCount = 10 * (page - 1);
		if(page < 1) {
			System.out.println("잘못된 페이지");
			return null;
		}

		ArrayList<Post> posts = new ArrayList<Post>();

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select * from Post where title like ? or content like ? order by time desc limit ?, ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, '%' + keyword + '%');
			preparedStatement.setString(2, '%' + keyword + '%');
			preparedStatement.setInt(3, pageCount);
			preparedStatement.setInt(4, pageCount + 9);
			ResultSet resultSet = preparedStatement.executeQuery();

			while(resultSet.next()) {
				String title = resultSet.getString("title");
				String uid = resultSet.getString("uid");
				int views = resultSet.getInt("views");
				int key = resultSet.getInt("p_num");
				int recommendation_count = getRecommendCount(key); // 추후 수정
				long posting_time = resultSet.getLong("time");
				Post post = new Post();
				post.setTime(posting_time);
				post.setKey(key);
				post.setUid(uid);
				post.setTitle(title);
				post.setViews(views);
				post.setRecommendation_count(recommendation_count);
				posts.add(post);
			}

			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return posts;
	}
	
	public boolean isExistedSearchedPage(int page, String keyword) {
		Connection con = null;
		int pageCount = 10 * (page - 1);
		boolean result = false;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select * from Post where title like ? or content like ? order by time desc limit ?, ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, '%' + keyword + '%');
			preparedStatement.setString(2, '%' + keyword + '%');
			preparedStatement.setInt(3, pageCount);
			preparedStatement.setInt(4, pageCount + 9);
			ResultSet resultSet = preparedStatement.executeQuery();

			if(resultSet.next())
				result = true;

			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public boolean isExistedPage(int page) {
		Connection con = null;
		int pageCount = 10 * (page - 1);
		boolean result = false;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select * from Post order by time desc limit ?, ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, pageCount);
			preparedStatement.setInt(2, pageCount + 9);
			ResultSet resultSet = preparedStatement.executeQuery();

			if (resultSet.next())
				result = true;

			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public int getRecommendCount(int p_num){
		Connection con = null;
		int recommend = 0;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select count(*) from Recommend where p_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setInt(1, p_num);
			ResultSet resultSet = preparedStatement.executeQuery();

			if (resultSet.next())
				recommend = resultSet.getInt(1);

			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return recommend;
	}
	
	public ArrayList<Post> getWriterPost(int page, String uid){

		Connection con = null;
		int pageCount = 10 * (page - 1);
		if(page < 1) {
			System.out.println("잘못된 페이지");
			return null;
		}

		ArrayList<Post> posts = new ArrayList<Post>();

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select * from Post where uid = ? order by time desc limit ?, ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			preparedStatement.setInt(2, pageCount);
			preparedStatement.setInt(3, pageCount + 9);
			ResultSet resultSet = preparedStatement.executeQuery();

			while(resultSet.next()) {
				String title = resultSet.getString("title");
				int views = resultSet.getInt("views");
				int key = resultSet.getInt("p_num");
				int recommendation_count = getRecommendCount(key); // 추후 수정
				long posting_time = resultSet.getLong("time");
				Post post = new Post();
				post.setTime(posting_time);
				post.setKey(key);
				post.setUid(uid);
				post.setTitle(title);
				post.setViews(views);
				post.setRecommendation_count(recommendation_count);
				posts.add(post);
			}

			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return posts;
	}
	
	public boolean isExistedWriterPage(int page, String uid) {
		Connection con = null;
		int pageCount = 10 * (page - 1);
		boolean result = false;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select * from Post where uid = ? order by time desc limit ?, ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			preparedStatement.setInt(2, pageCount);
			preparedStatement.setInt(3, pageCount + 9);
			ResultSet resultSet = preparedStatement.executeQuery();

			if(resultSet.next())
				result = true;

			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
}
