package DMDB;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.swing.plaf.basic.BasicTreeUI.TreeCancelEditingAction;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class RestaurantDbControl {
	String jdbc_driver;
	String jdbc_url;
	String db_name;
	String db_password;
	
	public RestaurantDbControl() {
		DBInfo info = new DBInfo();
		this.jdbc_driver = info.jdbc_driver;
		this.jdbc_url = info.jdbc_url;
		this.db_name = info.db_name;
		this.db_password = info.db_password;
	}
	
	public void saveRastaurant(String r_num, String name, String addr, String info_head, String info, String img) {
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "insert into Restaurant(r_num, name, addr, info_head, info, img, views) values (?, ?, ?, ?, ?, ?, 0);";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, r_num);
			preparedStatement.setString(2, name);
			preparedStatement.setString(3, addr);
			preparedStatement.setString(4, info_head);
			preparedStatement.setString(5, info);
			preparedStatement.setString(6, img);
			preparedStatement.executeUpdate();
			
			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public Restaurant loadRastaurant(String r_num) {
		Connection con = null;
		Restaurant rastaurant = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select * from Restaurant where r_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, r_num);
			ResultSet resultSet = preparedStatement.executeQuery();
			
			if(resultSet.next()) {
				String name = resultSet.getString("name");
				String addr = resultSet.getString("addr");
				String info_head = resultSet.getString("info_head");
				String info = resultSet.getString("info");
				String img = resultSet.getString("img");
				int views = resultSet.getInt("views");
				rastaurant = new Restaurant(r_num, name, addr, info_head, info, img, views);
			}
			
			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return rastaurant;
	}
	
	public String loadImage(String r_num) {
		Connection con = null;
		String img = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select img from Restaurant where r_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, r_num);
			ResultSet resultSet = preparedStatement.executeQuery();
			
			if(resultSet.next()) {
				img = resultSet.getString("img");
			}
			
			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return img;
	}
	
	public boolean isRastaurantInDb(String r_num) {
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

			String sql = "select * from Restaurant where r_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1,r_num);
			ResultSet resultSet = preparedStatement.executeQuery();
			
			if(resultSet.next()) {
				result = true;
			}
			
			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public void setLikes(String r_num, String uid) {
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql;
			
			if(isLikes(r_num, uid)) {
				sql = "delete from Likes where r_num = ? and uid = ?;";
			}
			
			else {
				sql = "insert into Likes (r_num, uid) values (?, ?);";
			}
			
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, r_num);
			preparedStatement.setString(2, uid);
			preparedStatement.executeUpdate();
			
			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public boolean isLikes(String r_num, String uid) {
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

			String sql = "select * from Likes where r_num = ? and uid = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, r_num);
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
	
	public int getLikesCount(String r_num) {
		Connection con = null;
		int count = 0;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select count(*) from Likes where r_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, r_num);
			ResultSet resultSet = preparedStatement.executeQuery();
			
			if(resultSet.next())
				count = resultSet.getInt(1);
			
			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return count;
	}
	
	public ArrayList<String> getUserLikes(String uid){
		Connection con = null;
		ArrayList<String> result = new ArrayList<String>();

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select r_num from Likes where uid = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			ResultSet resultSet = preparedStatement.executeQuery();
			
			while(resultSet.next())
				result.add(resultSet.getString(1));
			
			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public void saveReview(String r_num, String uid, String content, int score) {
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;
			
			String sql = "select c_num from Review where r_num = ? order by c_num desc";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, r_num);
			ResultSet resultSet = preparedStatement.executeQuery();

			int c_num = 0;

			if(resultSet.next())
				c_num = resultSet.getInt(1) + 1;

			sql = "insert into Review (r_num, uid, content, score, time, c_num) values (?, ?, ?, ?, ?, ?);";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, r_num);
			preparedStatement.setString(2, uid);
			preparedStatement.setString(3, content);
			preparedStatement.setInt(4, score);
			preparedStatement.setLong(5, System.currentTimeMillis());
			preparedStatement.setInt(6,  c_num);
			preparedStatement.executeUpdate();
			
			
			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Review> loadReviews(String r_num) {
		Connection con = null;
		ArrayList<Review> reviews = new ArrayList<Review>();

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select * from Review where r_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, r_num);
			ResultSet resultSet = preparedStatement.executeQuery();
			
			while(resultSet.next()) {
				String uid = resultSet.getString("uid");
				String content = resultSet.getString("content");
				int score = resultSet.getInt("score");
				long time = resultSet.getLong("time");
				int c_num = resultSet.getInt("c_num");
				reviews.add(new Review(r_num, uid, content, score, time, c_num));
			}
			
			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return reviews;
	}
	
	public void addViews(String r_num) {		
		Connection con = null;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "update Restaurant set views = views + 1 where r_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, r_num);
			preparedStatement.executeUpdate();

			preparedStatement.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public double getScores(String r_num) {
		Connection con = null;
		double score = 0;

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select AVG(score) from Review where r_num = ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, r_num);
			ResultSet resultSet = preparedStatement.executeQuery();
			
			if(resultSet.next())
				score = resultSet.getDouble(1);
			
			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return score;
	}
	
	public String findPage(String name, String address) {
		int page = 1;
		
		String[] addrs = address.split(" ");
		String key_addr = null;
		String key = null;
		int i = 0;
		
		for(; i < addrs.length; i++) {
			if(addrs[i].charAt(addrs[i].length()-1) == '동') {
				key_addr = addrs[i];
				break;
			}
		}
		
		String keyword = key_addr + " " + name;
		
		while(true) {
			String url = "https://www.mangoplate.com/search/" + keyword + "?keyword=" + keyword + "&page=" + page++; 
			Document doc = null;
			System.out.println(url);

			try {
				doc = Jsoup.connect(url).get();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			Elements elements = doc.select(".list-restaurant-item");
			
			if(elements.size() == 0)
				break;
			
			for(Element element : elements) {
				String[] s = element.select(".thumb img").attr("alt").split(" 사진 - ");
				String href = element.select(".info a").attr("href");
				
				String title = s[0];
				String addr = s[1];
				
				System.out.println("---------------------------------");
				System.out.println(title);
				System.out.println(addr);
				System.out.println(href);
				System.out.println("---------------------------------");
				
				if(compareAddr(address, addr)) {
					key = href;
					System.out.println("이거!");
					break;
				}
			}
			if(key != null)
				break;
		}
		
		if(key == null) {
			page = 1;
			keyword = addrs[i-1] + " " + key_addr;
			while(true) {
				String url = "https://www.mangoplate.com/search/" + keyword + "?keyword=" + keyword + "&page=" + page++; 
				Document doc = null;
				System.out.println(url);

				try {
					doc = Jsoup.connect(url).get();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				Elements elements = doc.select(".list-restaurant-item");
				
				if(elements.size() == 0)
					break;
				
				for(Element element : elements) {
					String[] s = element.select(".thumb img").attr("alt").split(" 사진 - ");
					String href = element.select(".info a").attr("href");
					
					String title = s[0];
					String addr = s[1];
					
					System.out.println("---------------------------------");
					System.out.println(title);
					System.out.println(addr);
					System.out.println(href);
					System.out.println("---------------------------------");
					
					if(compareAddr(address, addr)) {
						key = href;
						System.out.println("이거!");
						break;
					}
				}
				if(key != null)
					break;
			}
		}
		
		return key;
	}
	
	public void rPage(String key, String name, String r_num) {
		Document doc = null;
		String url = "https://www.mangoplate.com" + key; 

		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		Element tbody = doc.select(".inner table tbody").first();
		
		String addr = tbody.select("td").get(0).text();
		StringBuilder heads = new StringBuilder();
		StringBuilder infos = new StringBuilder();
		
		for(int i = 1; i < tbody.select("td").size(); i++) {
			String th = tbody.select("th").get(i).text();
			String td = tbody.select("td").get(i).text();
			if(td == "")
				break;
			heads.append(th);
			infos.append(td);
			System.out.println(th+ " : " + td);
			if(i < tbody.select("td").size()-1) {
				heads.append(",,");
				infos.append(",,");
			}
		}
		
		String img = doc.select("meta[property=og:image]").get(0).attr("content");

		saveRastaurant(r_num, name, addr, heads.toString(), infos.toString(), img);
	}
	
	public boolean compareAddr(String addr1, String addr2) {
		String A = null;
		String B = null;
		
		for(int i = 0; i < addr1.length(); i++) {
			if(addr1.charAt(i) == ' ') {
				A = addr1.substring(i+1);
				break;
			}
		}
		for(int i = 0; i < addr2.length(); i++) {
			if(addr2.charAt(i) == ' ') {
				B = addr2.substring(i+1);
				break;
			}
		}
		if(A.equals(B))
			return true;
		else
			return false;
	}
	
	public ArrayList<RestaurantView> getLikeRestaurants(String uid, int page){
		ArrayList<RestaurantView> retaurants = new ArrayList<RestaurantView>();
		Connection con = null;
		int pageCount = 5 * (page - 1);
		if(page < 1) {
			System.out.println("잘못된 페이지");
			return null;
		}

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select likes.r_num, uid, name, addr, img from likes left outer join restaurant on likes.r_num = restaurant.r_num where uid = ? limit ?, ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			preparedStatement.setInt(2, pageCount);
			preparedStatement.setInt(3, pageCount + 5);
			ResultSet resultSet = preparedStatement.executeQuery();

			while(resultSet.next()) {
				String r_num = resultSet.getString("r_num");
				String name = resultSet.getString("name");
				String addr = resultSet.getString("addr");
				String img = resultSet.getString("img");
				retaurants.add(new RestaurantView(name, addr, img, r_num));
			}
			
			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return retaurants;
	}
	
	public ArrayList<RestaurantView> getSearchedLikeRestaurants(String uid, int page, String keyword){
		ArrayList<RestaurantView> retaurants = new ArrayList<RestaurantView>();
		Connection con = null;
		int pageCount = 5 * (page - 1);
		if(page < 1) {
			System.out.println("잘못된 페이지");
			return null;
		}

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select likes.r_num, uid, name, addr, img from likes left outer join restaurant on likes.r_num = restaurant.r_num "
					+ "where uid = ? and (name like ? or addr like ?) limit ?, ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			preparedStatement.setString(2, '%' + keyword + '%');
			preparedStatement.setString(3, '%' + keyword + '%');
			preparedStatement.setInt(4, pageCount);
			preparedStatement.setInt(5, pageCount + 5);
			ResultSet resultSet = preparedStatement.executeQuery();

			while(resultSet.next()) {
				String r_num = resultSet.getString("r_num");
				String name = resultSet.getString("name");
				String addr = resultSet.getString("addr");
				String img = resultSet.getString("img");
				retaurants.add(new RestaurantView(name, addr, img, r_num));
			}
			
			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return retaurants;
	}
	
	public boolean isLikePages(String uid, int page){
		boolean result = false;
		Connection con = null;
		int pageCount = 5 * (page - 1);
		if(page < 1) {
			System.out.println("잘못된 페이지");
			return false;
		}

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select name from likes left outer join restaurant on likes.r_num = restaurant.r_num where uid = ? limit ?, ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			preparedStatement.setInt(2, pageCount);
			preparedStatement.setInt(3, pageCount + 5);
			ResultSet resultSet = preparedStatement.executeQuery();

			if(resultSet.next()) {
				result = true;
			}
			
			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public boolean isSearchedLikePages(String uid, int page, String keyword){
		boolean result = false;
		Connection con = null;
		int pageCount = 5 * (page - 1);
		if(page < 1) {
			System.out.println("잘못된 페이지");
			return false;
		}

		try {
			Class.forName(jdbc_driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(jdbc_url, db_name, db_password);

			PreparedStatement preparedStatement = null;

			String sql = "select name from likes left outer join restaurant on likes.r_num = restaurant.r_num "
					+ "where uid = ? and (name like ? or addr like ?) limit ?, ?;";
			preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, uid);
			preparedStatement.setString(2, '%' + keyword + '%');
			preparedStatement.setString(3, '%' + keyword + '%');
			preparedStatement.setInt(4, pageCount);
			preparedStatement.setInt(5, pageCount + 5);
			ResultSet resultSet = preparedStatement.executeQuery();

			if(resultSet.next()) {
				result = true;
			}
			
			preparedStatement.close();
			resultSet.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
