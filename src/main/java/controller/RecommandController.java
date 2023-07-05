package controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;

import java.util.HashMap;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.servlet.ModelAndView;

import dto.PageDTO;

// http://localhost:8090/myapp/paldo.do

@Controller
public class RecommandController {

	
	public RecommandController() {

	}

	@RequestMapping(value = "/recommand.do", method = RequestMethod.GET)
	public ModelAndView listMethod(PageDTO pv, ModelAndView mav, HttpServletRequest request) {
		
		String filePath = request.getSession().getServletContext().getRealPath("/resources/data/chart/age.txt");

		System.out.println(new File(filePath).exists());
		
		BufferedReader in = null;

		try {
			BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(filePath), "UTF-8"));

			String total="";
			String line;
            while((line = reader.readLine()) != null) { // response를 차례대로 출력
                total += line;
            }
  
            JSONParser parser = new JSONParser();
			 Object obj = parser.parse(total);
			JSONObject res1 = (JSONObject) obj;
			System.out.println("loc:" +res1.get("loc"));
			
			HashMap<String, Integer> loc = new HashMap<String, Integer>();
			loc.put("서울",	1);
			loc.put("인천",	2);
			loc.put("대전",	3);
			loc.put("대구",	4);
			loc.put("광주",	5);
			loc.put("부산",	6);
			loc.put("울산",	7);
			loc.put("세종",	8);
			loc.put("경기",	31);
			loc.put("강원",	32);
			loc.put("충북",	33);
			loc.put("충남",	34);
			loc.put("경북",	35);
			loc.put("경남",	36);
			loc.put("전북",	37);
			loc.put("전남",	38);
			loc.put("제주",	39);

			mav.addObject("locnum", loc.get((String)res1.get("loc")));
			
	        for (Object key : res1.keySet()){
	            mav.addObject((String)key, (Object)res1.get(key));
	        }

			reader.close();
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

		
			

		mav.setViewName("recommand");
		return mav;
	}//end listMethod()
	}
	