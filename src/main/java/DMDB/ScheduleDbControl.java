package DMDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;


public class ScheduleDbControl {

	String jdbc_driver;
	String jdbc_url;
	String db_name;
	String db_password;
	
	public ScheduleDbControl() {
		DBInfo info = new DBInfo();
		this.jdbc_driver = info.jdbc_driver;
		this.jdbc_url = info.jdbc_url;
		this.db_name = info.db_name;
		this.db_password = info.db_password;
	}

	public int addNewScheduleToDB(Schedule schedule) {	// 새로운 스케줄을 생성
		Connection con = null;
		int s_num = -1;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select s_num from Schedule where uid = ? order by s_num desc";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, schedule.getUid());
			ResultSet resultSet = preparedStatement.executeQuery();

			s_num = 0;
			if(resultSet.next())
				s_num = resultSet.getInt(1) + 1;

			sql = "insert into Schedule(uid, s_num, start, end, name, memo) values(?, ?, ?, ?, ?, ?)";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, schedule.getUid());
			preparedStatement.setInt(2, s_num);
			preparedStatement.setLong(3, schedule.getDate().getTime());
			preparedStatement.setLong(4, schedule.getEnd_Day().getTime());
			preparedStatement.setString(5, schedule.getName());
			preparedStatement.setString(6, schedule.getMemo());
			preparedStatement.executeUpdate();

			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return s_num;
	}

	public void updateScheduleToDB(Schedule schedule) {		// 기존의 스케줄을 업데이트
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "update Schedule set name = ?, memo = ?, start = ?, end = ? where uid = ? and s_num = ?";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, schedule.getName());
			preparedStatement.setString(2, schedule.getMemo());	// s_num
			preparedStatement.setLong(3, schedule.getDate().getTime());
			preparedStatement.setLong(4, schedule.getEnd_Day().getTime());
			preparedStatement.setString(5, schedule.getUid());
			preparedStatement.setInt(6, schedule.getKey());
			preparedStatement.executeUpdate();

			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void deleteScheduleFromDb(String uid, int s_num) {
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "delete from Schedule where uid = ? and s_num = ?";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			preparedStatement.setInt(2, s_num);
			preparedStatement.executeUpdate();
			
			sql = "delete from Element where uid = ? and s_num = ?";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			preparedStatement.setInt(2, s_num);
			preparedStatement.executeUpdate();
					
			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public int setElementsToSchedule(ArrayList<Schedule> schedules) {		// 스케줄 요소를 설정하는 함수
		Connection con = null;

		String uid = schedules.get(0).getUid();
		int s_num = schedules.get(0).getKey();

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);
			PreparedStatement preparedStatement = null;
			
			String sql = "delete from Element where uid = ? and s_num = ?";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			preparedStatement.setInt(2, s_num);
			preparedStatement.executeUpdate();

			for(Schedule schedule : schedules) {
				for (int j = 0; j < schedule.getElementCount(); j++) {
					Element element = schedule.getElementI(j);

					sql = "insert into Element (uid, s_num, start, end, latitude, longitude, memo, name, r_num, isRes) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
					preparedStatement = con.prepareStatement(sql);
					preparedStatement.setString(1, uid);
					preparedStatement.setInt(2, s_num);
					preparedStatement.setLong(3, element.getStartTime_timestamp().getTime());
					preparedStatement.setLong(4, element.getEndTime_timestamp().getTime());
					preparedStatement.setDouble(5, element.getGP().getLatitude());
					preparedStatement.setDouble(6, element.getGP().getLongitude());
					preparedStatement.setString(7, element.getMemo());
					preparedStatement.setString(8, element.getName());
					preparedStatement.setString(9, element.getR_num());
					preparedStatement.setBoolean(10, element.isRes());
					preparedStatement.executeUpdate();
				}
			}

			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return 1;
	}

	public ArrayList<ScheduleForView> loadUserSchedulesFromDb(String uid) {	// 특정 사용자의 모든 스케줄의 name, key, 시작날짜, 끝날짜를 배열로 모두 불러오는 함수

		ArrayList<ScheduleForView> views = new ArrayList<ScheduleForView>(); // 리턴 해줄 ArrayList 생성

		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);
			PreparedStatement preparedStatement = null;

			String sql = "select name, s_num, start, end from Schedule where uid = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			ResultSet resultSet = preparedStatement.executeQuery();

			while(resultSet.next()){
				String name = resultSet.getString(1);
				int s_num = resultSet.getInt(2);
				String start_day = TimestampToDay(new Timestamp(resultSet.getLong(3)));
				String end_day = TimestampToDay(new Timestamp(resultSet.getLong(4)));
				views.add(new ScheduleForView(name, s_num, start_day, end_day));
			}

			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		// views 리턴
		return views;
	}

	public String TimestampToDay(Timestamp ts) {
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(ts.getTime());
		return cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH) + 1) + "-" + cal.get(Calendar.DATE); 
	}

	public ArrayList<Schedule> loadScheduleFromDb(String uid, int s_num) {		// 특정 사용자의 특정 키값을 가지는 스케줄을 불러오는 함수

		// 특정 사용자의 특정 키값의 문서를 불러옴

		ArrayList<Schedule> schedules = new ArrayList<Schedule>();	// 리턴해줄 배열 생성

		String memo = null;
		int key = -1;
		String scheduleName = null;
		Timestamp start_day = null;
		Timestamp end_day = null;

		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);
			PreparedStatement preparedStatement = null;

			String sql = "select * from Schedule where uid = ? and s_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			preparedStatement.setInt(2, s_num);
			ResultSet resultSet = preparedStatement.executeQuery();

			if(resultSet.next()) {
				// 각 날짜의 스케줄에 넣어줄 메모, 키, 이름 정보 저장
				memo = resultSet.getString("memo");
				key = resultSet.getInt("s_num");
				scheduleName = resultSet.getString("name");
				// 시작날짜, 끝날짜 불러옴
				start_day = new Timestamp(resultSet.getLong("start"));
				end_day = new Timestamp(resultSet.getLong("end"));
			}

			// 시작날짜와 끝날짜의 차이만큼 스케줄 객체를 생성해서 배열에 넣음
			int dayCount = (int)((end_day.getTime() - start_day.getTime()) / (24*60*60*1000));

			for(int i = 0; i < dayCount + 1; i++) {
				Schedule schedule = new Schedule(uid);
				schedule.setMemo(memo);
				schedule.setKey(key);
				schedule.setName(scheduleName);
				schedule.setDate(start_day.getTime() + (long)(i * (24*60*60*1000)));
				schedules.add(schedule);
			}

			sql = "select * from Element where uid = ? and s_num = ?";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			preparedStatement.setInt(2, s_num);
			resultSet = preparedStatement.executeQuery();

			while (resultSet.next()) {
				GeoPoint gp = new GeoPoint(resultSet.getDouble("latitude"), resultSet.getDouble("longitude"));
				Timestamp start_time = new Timestamp(resultSet.getLong("start"));
				Timestamp end_time = new Timestamp(resultSet.getLong("end"));
				String name = resultSet.getString("name");
				String elm_memo = resultSet.getString("memo");
				String r_num = resultSet.getString("r_num");
				boolean isRes = resultSet.getBoolean("isRes");
				Element newElement = new Element(gp, start_time, end_time, name);
				newElement.setMemo(elm_memo);
				newElement.setR_num(r_num);
				newElement.setRes(isRes);
				schedules.get((int)(start_time.getTime() - start_day.getTime()) / (24*60*60*1000)).addElement(newElement);
			}

			resultSet.close();
			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return schedules;
	}

	public boolean checkScheduleDate(long start_day, long end_day, String uid) {

		ArrayList<Long> existedDate = new ArrayList<Long>();

		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);
			PreparedStatement preparedStatement = null;

			String sql = "select start, end from Schedule where uid = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			ResultSet resultSet = preparedStatement.executeQuery();

			while(resultSet.next()){
				long schedule_start_day = resultSet.getLong(1);
				long schedule_end_day = resultSet.getLong(2);

				for(long day = schedule_start_day; day < schedule_end_day; day += (24*60*60*1000))
					existedDate.add(day);
			}

			resultSet.close();
			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		long day = start_day;
		while(true) {
			if(existedDate.contains(day))
				return false;

			day += (24*60*60*1000);
			if(day == end_day)
				break;
		}

		return true;
	}
}
