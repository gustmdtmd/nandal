package controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
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

// http://localhost:8090/myapp/calendar.do

@Controller
public class CalendarController {

	private PaldoPageDTO pdto;
	private int currentPage;

	public CalendarController() {

	}

	@RequestMapping(value = "/calendar.do")
	public ModelAndView listMethod(PaldoPageDTO pv, ModelAndView mav,
			@RequestParam(value = "sdate", required = false) String sdate, @RequestParam(value = "edate", required = false) String edate) {
		System.out.println("달력 도착");
//날짜 default
        // 포맷 정의
        DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyyMMdd");
 
        if(sdate==null) {
			// 현재 날짜
	        LocalDate now = LocalDate.now();
	        String formatedNow = now.format(format);
			sdate = formatedNow;
			
		}
        System.out.println("sdate:" + sdate);
		if(edate==null) {
			// 한달 뒤 날짜
			LocalDate plusmonth = LocalDate.now().plusMonths(1);
			String formatedplusmonth = plusmonth.format(format);
			edate = formatedplusmonth;
		}
		System.out.println("edate:" + edate);	
		
		
		BufferedReader in = null;
		String key = "tO7xUsJKJvOdMlkdvGSuyBvNwiDZMyIMM%2FHh7SK0ZaDFLE5PuAQvbOCNx3GZLbSTJvuyHmJ8OJ7BkEECgTZ7XA%3D%3D";

		try {
			URL obj = new URL(
					"http://apis.data.go.kr/B551011/KorService/searchFestival?eventStartDate="+sdate+"&eventEndDate=" + edate + "&areaCode=&sigunguCode=&ServiceKey="+key+"&listYN=Y&MobileOS=ETC&MobileApp=AppTest&arrange=A&numOfRows=12&pageNo="+pv.getCurrentPage()+"&_type=json");
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
				mav.addObject("sdate", sdate);
				mav.addObject("edate", edate);
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
		
		mav.setViewName("calendar");
		System.out.println("calendar 완료");
		return mav;
	}// end listMethod()

}// end class
