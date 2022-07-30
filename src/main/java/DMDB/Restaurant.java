package DMDB;

import java.util.ArrayList;
import java.util.Arrays;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class Restaurant {
	private String r_num;
	private String name;
	private String addr;
	private ArrayList<String> info_heads;
	private ArrayList<String> infos;
	private String img;
	private int views;

	public Restaurant(String r_num, String name, String addr, String info_head, String info, String img, int views) {
		this.r_num = r_num;
		this.name = name;
		this.addr = addr;
		info_heads = new ArrayList<String>(Arrays.asList(info_head.split(",,")));
		infos = new ArrayList<String>(Arrays.asList(info.split(",,")));
		this.img = img;
		
		if(img == null ||img.equals(""))
			this.img = "../img/altImg.png";
		
		this.views = views;
	}

	public String getR_num() {
		return r_num;
	}

	public String getName() {
		return name;
	}

	public String getAddr() {
		return addr;
	}

	public ArrayList<String> getInfo_heads() {
		return info_heads;
	}

	public ArrayList<String> getInfos() {
		return infos;
	}

	public String getImg() {
		return img;
	}

	public int getViews() {
		return views;
	}

	public JSONObject getJson() {
		JSONObject json = new JSONObject();

		json.put("name", name);
		json.put("addr", addr);

		JSONArray heads_arr = new JSONArray();
		JSONArray infos_arr = new JSONArray();

		for (int i = 0; i < infos.size(); i++) {
			heads_arr.add(info_heads.get(i));
			infos_arr.add(infos.get(i));
		}

		json.put("info_heads", heads_arr);
		json.put("infos", infos_arr);

		return json;
	}
}
