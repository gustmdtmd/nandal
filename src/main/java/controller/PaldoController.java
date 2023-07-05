package controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.servlet.ModelAndView;

import dto.DetailDTO;

import dto.PaldoPageDTO;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

// http://localhost:8090/myapp/paldo.do

@Controller
public class PaldoController {

	private PaldoPageDTO pdto;
	private int currentPage;

	public PaldoController() {

	}

	@RequestMapping(value = "/paldo.do")
	public ModelAndView listMethod(PaldoPageDTO pv, ModelAndView mav,
			@RequestParam(value = "areacode", required = false, defaultValue = "1") String areacode, 
			@RequestParam(value = "keyword", required = false) String keyword) {
		BufferedReader in = null;
		String key = "tO7xUsJKJvOdMlkdvGSuyBvNwiDZMyIMM%2FHh7SK0ZaDFLE5PuAQvbOCNx3GZLbSTJvuyHmJ8OJ7BkEECgTZ7XA%3D%3D";

		System.out.println("keyword:" + keyword);
		try {
			URL obj; 
			if(keyword != null) {
				System.out.println("키워드 있음");
				obj  = new URL(
						"http://apis.data.go.kr/B551011/KorService/searchKeyword?numOfRows=12&pageNo="+pv.getCurrentPage()+"&MobileOS=ETC&MobileApp=AppTest&ServiceKey="+key+"&listYN=Y&arrange=A&areaCode="+areacode+"&sigunguCode=&cat1=&cat2=&cat3=&keyword="+keyword+"&_type=json");
				
				
			}else {
				System.out.println("키워드 없음");
				obj = new URL(
					"http://apis.data.go.kr/B551011/KorService/areaBasedList?numOfRows=12&pageNo="+ pv.getCurrentPage() +"1&MobileOS=ETC&MobileApp=AppTest&ServiceKey="
							+ key + "&listYN=Y&arrange=A&contentTypeId=&areaCode=" + areacode
							+ "&sigunguCode=&cat1=&cat2=&cat3=&_type=json");
				
			}
			
			// url
			System.out.println("url 검색");
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();
			con.setRequestMethod("GET");
			BufferedReader reader = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));

			// google
			System.out.println("json element 검색");
			
			JsonElement element = JsonParser.parseReader(reader);
			JsonObject res = element.getAsJsonObject();

			JsonElement tc = res.get("response").getAsJsonObject().get("body").getAsJsonObject().get("totalCount");
			System.out.println("tc.getAsInt():" + tc.getAsInt());
			int totalRecord = tc.getAsInt();

			JsonElement cp = res.get("response").getAsJsonObject().get("body").getAsJsonObject().get("pageNo");
			System.out.println("cp.getAsInt():" + cp.getAsInt());
			this.currentPage = cp.getAsInt();
			element = res.get("response").getAsJsonObject().get("body").getAsJsonObject().get("items").getAsJsonObject()
					.get("item");
			JsonArray jsonList = element.getAsJsonArray();
			
			System.out.println("페이징 검색");
			if (totalRecord >= 1) {
				if (pv.getCurrentPage() == 0)
					this.currentPage = 1;
				else
					this.currentPage = pv.getCurrentPage();

				this.pdto = new PaldoPageDTO(currentPage, totalRecord);

				Gson gson = new Gson();
				List<DetailDTO> aList = new ArrayList<DetailDTO>();
				for (int i = 0; i < jsonList.size(); i++) {
					DetailDTO dto = gson.fromJson(jsonList.get(i), DetailDTO.class);
					aList.add(dto);
				}
				reader.close();

				HashMap<Integer, String> loc = new HashMap<Integer,String>();
				loc.put(1,"서울");
				loc.put(2,"인천");
				loc.put(3,"대전");
				loc.put(4,"대구");
				loc.put(5,"광주");
				loc.put(6,"부산");
				loc.put(7,"울산");
				loc.put(8,"세종");
				loc.put(31,"경기");
				loc.put(32,"강원");
				loc.put(33,"충북");
				loc.put(34,"충남");
				loc.put(35,"경북");
				loc.put(36,"경남");
				loc.put(37,"전북");
				loc.put(38,"전남");
				loc.put(39,"제주");
				
				
				
				mav.addObject("areacode", loc.get(Integer.parseInt(areacode)));
				mav.addObject("cntt", totalRecord);
				mav.addObject("aList", aList);
				mav.addObject("pv", this.pdto);

			}

		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			if (in != null)
				try {
					in.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		
		mav.setViewName("paldo");
		return mav;
	}// end listMethod()

}// end class
