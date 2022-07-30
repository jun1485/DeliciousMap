package DMDB;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import java.util.regex.Pattern;

public class webTest {
	public static void main(String[] args) {
		String url = "https://www.mangoplate.com/restaurants/_q1AG6Jh9V"; 
		Document doc = null;

		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		System.out.println(doc);
		
		String img = doc.select("meta[property=og:image]").get(0).attr("content");
		System.out.println(img);
		
		System.out.println(System.currentTimeMillis());
	}
}
