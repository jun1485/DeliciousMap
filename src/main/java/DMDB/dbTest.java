package DMDB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class dbTest {							// 테스트용 
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		String jdbc_driver = "org.mariadb.jdbc.Driver";
		String jdbc_url = "jdbc:mysql://192.168.219.111:3307/DM_DB";
		String db_name = "dm_manager";			// db 아이디
		String db_password = "1234";			// db 비밀번호
		
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);
			
			System.out.println("연결 성공");
			
			con.close();

		} catch (SQLException e) {
			System.out.println("연결 실패");
			e.printStackTrace();
		}
	}
}
