package DMDB;

import org.json.simple.JSONObject;

public class RestaurantView {
	String name;
	String addr;
	String img;
	String r_num;
	
	public RestaurantView(String name, String addr, String img, String r_num) {
		this.name = name;
		this.addr = addr;
		this.img = img;
		this.r_num = r_num;
		
		if(img == null || img.equals(""))
			this.img = "../img/altImg.png";
	}
	
	public String getName() {
		return name;
	}
	
	public String getAddr() {
		return addr;
	}
	
	public String getImg() {
		return img;
	}
	
	public String getR_num() {
		return r_num;
	}
	
	public JSONObject getJson(){
		JSONObject json = new JSONObject();
		
		json.put("name", name);
		json.put("addr", addr);
		json.put("img", img);
		json.put("r_num", r_num);
		
		return json;
	}
}
