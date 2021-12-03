package DMDB;

import java.sql.*;


public class UserDbControl {
	String jdbc_driver;
	String jdbc_url;
	String db_name;
	String db_password;
	
	public UserDbControl() {
		DBInfo info = new DBInfo();
		this.jdbc_driver = info.jdbc_driver;
		this.jdbc_url = info.jdbc_url;
		this.db_name = info.db_name;
		this.db_password = info.db_password;
	}

	public int addNewUserToDb(String uid, String password, String name, String nickName, String phoneNum) {	// 새로운 유저 정보를 추가
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return -1;
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "insert into User(uid, password, name, nickName, phoneNum) values(?, ?, ?, ?, ?)";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			preparedStatement.setString(2, password);
			preparedStatement.setString(3, name);
			preparedStatement.setString(4, nickName);
			preparedStatement.setString(5, phoneNum);
			preparedStatement.executeUpdate();

			preparedStatement.close();
			con.close();
			return 1;

		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
	}

	public boolean checkUid(String uid) {					// 입력받은 아이디가 DB에 저장된 아이디인지 확인
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select uid from User where uid = ?";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			ResultSet result = preparedStatement.executeQuery();

			boolean re;
			if(result.next())
				re = true;
			else
				re = false;

			preparedStatement.close();
			con.close();

			return re;

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}
	
	public boolean checkPassword(String uid, String password) {			// 입력받은 아이디와 비밀번호가 DB상에 저장된 정보와 일치하는지 확인
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select password from User where uid = ?";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			ResultSet result = preparedStatement.executeQuery();

			boolean re;
			if(result.next()){
				if(password.equals(result.getString(1)))
					re = true;
				else
					re = false;
			}
			else
				re = false;

			preparedStatement.close();
			con.close();

			return re;

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}
	
	public String findUid(String name, String phoneNum) {		// 이름과 전화번호로 아이디를 찾는 함수
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select uid from User where name = ? and phoneNum = ?";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, name);
			preparedStatement.setString(2, phoneNum);
			ResultSet result = preparedStatement.executeQuery();

			String uid = null;
			if(result.next()){
				uid = result.getString(1);
			}

			preparedStatement.close();
			con.close();

			return uid;

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}
	
	public String finePassword(String uid, String name, String phoneNum) {		// 이름, 전화번호, 아이디로 비밀번호를 찾는 함수
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select password from User where name = ? and phoneNum = ? and uid = ?";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, name);
			preparedStatement.setString(2, phoneNum);
			preparedStatement.setString(3, uid);
			ResultSet result = preparedStatement.executeQuery();

			String password = null;
			if(result.next()){
				password = result.getString(1);
			}

			preparedStatement.close();
			con.close();

			return password;

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}

	public void setNickName(String uid, String nickName) {			// 유저의 닉네임을 변경
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "update User set nickName = ? where uid = ?";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, nickName);
			preparedStatement.setString(2, uid);
			preparedStatement.executeUpdate();

			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public String getNickName(String uid) {		// uid에 해당하는 닉네임을 리턴
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select nickName from User where uid = ?";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			ResultSet result = preparedStatement.executeQuery();

			String nickName = null;
			if(result.next()){
				nickName = result.getString(1);
			}

			preparedStatement.close();
			con.close();

			return nickName;

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}

	public boolean checkNickName(String nickName) {		// 회원가입시 닉네임의 중복을 확인하기 위한 함수
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select * from User where nickName = ?";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, nickName);
			ResultSet result = preparedStatement.executeQuery();

			boolean is = false;
			if(result.next()){
				is = true;
			}

			preparedStatement.close();
			con.close();

			return is;

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}
	
	public void changePassword(String uid, String password) {
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "update User set password = ? where uid = ?";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, password);
			preparedStatement.setString(2, uid);
			preparedStatement.executeUpdate();

			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public String getName(String uid) {		// uid에 해당하는 name을 리턴
		Connection con = null;
		String name = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select name from User where uid = ?";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			ResultSet result = preparedStatement.executeQuery();

			if(result.next()){
				name = result.getString(1);
			}

			result.close();
			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return name;
	}
	
	public String getPhone(String uid) {		// uid에 해당하는 phone을 리턴
		Connection con = null;
		String phone = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select phoneNum from User where uid = ?";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			ResultSet result = preparedStatement.executeQuery();

			if(result.next()){
				phone = result.getString(1);
			}

			result.close();
			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return phone;
	}
	
	public boolean checkRegisterID(String uid) {
		
		if(uid.length() > 15)
			return false;
		
		for(char a : uid.toCharArray()) {
			if(!Character.isAlphabetic(a) && !Character.isDigit(a))
				return false;
		}
		
		return true;
	}
	
	public void userDelete(String uid) {
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "delete from user where uid = ?";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			preparedStatement.executeUpdate();

			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
