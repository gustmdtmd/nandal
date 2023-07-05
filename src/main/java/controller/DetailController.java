package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import dto.DetailDTO;
import dto.UserDTO;
import service.DetailService;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;



// http://localhost:8090/myapp/detail.do

@Controller
public class DetailController {

	private SqlSessionTemplate sqlSession;
	private DetailService detailService;
	private UserDTO user;
	
	
	public DetailController() {

	}

	
	
	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	
	public void setDetailService(DetailService detailService) {
		this.detailService = detailService;
	}

	
	@RequestMapping(value = "/detail.do")
	public ModelAndView listMethod(ModelAndView mav, HttpSession session,
			@RequestParam(value="contentid", required = false)  String contentid, 
			@RequestParam(value="list", required = false)  String list ) {
		//System.out.println("contentid:"+contentid);
		//System.out.println("session:" + ((UserDTO)session.getAttribute("user")).getUsercode());
		
		System.out.println("detail.do controller 시작 get");
		BufferedReader in = null;
		
		String key = "tO7xUsJKJvOdMlkdvGSuyBvNwiDZMyIMM%2FHh7SK0ZaDFLE5PuAQvbOCNx3GZLbSTJvuyHmJ8OJ7BkEECgTZ7XA%3D%3D";
		
		List<DetailDTO> aList=null;
		try {
			URL obj = new URL("http://apis.data.go.kr/B551011/KorService/detailCommon?ServiceKey=" + key + "&contentTypeId=&contentId=" + contentid + "&MobileOS=ETC&MobileApp=AppTest&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y&_type=json");
																																														// url
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();

			con.setRequestMethod("GET"); // post로 바꾸기

			BufferedReader reader = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));


			
			 aList = new ArrayList<DetailDTO>();
			
			// google
			JsonElement element = JsonParser.parseReader(reader);
			//System.out.println("element: "+element);
			JsonObject res = element.getAsJsonObject();
			//System.out.println("res: "+res);
			element = res.get("response").getAsJsonObject().get("body").getAsJsonObject().get("items").getAsJsonObject().get("item");
		     
			     
			JsonArray jsonList = element.getAsJsonArray();

				
			
			Gson gson = new Gson();
			for (int i = 0; i < jsonList.size(); i++) {
				DetailDTO dto = gson.fromJson(jsonList.get(i), DetailDTO.class);
				aList.add(dto);
			}
			reader.close();			
			mav.addObject("aList", aList);
			
			// 선호도 저장
			// 1. 선호 유형 저장
			DetailDTO dto = (DetailDTO)aList.get(0);
			user = (UserDTO)session.getAttribute("user"); 
			
			System.out.println("contentid: " + dto.getContentid());
			System.out.println("cat3: "+ dto.getCat3());
			System.out.println("loc: "+ dto.getAreacode());
			
			if(session.getAttribute("user")==null) {
				dto.setUsercode(0);
			}else {
				System.out.println("usercode:" + user.getUsercode());
				dto.setUsercode(user.getUsercode());
			}
			
			int existres = detailService.existProcess(dto);
			System.out.println("존재여부:"+ existres);
			if(existres ==0) {
				System.out.println("존재 안함");
				detailService.insertProcess(dto);				
			}
			
			detailService.infoCount(dto);

			//북마크 설정
			
			if(session.getAttribute("user")!=null) {
				System.out.println("북마크 시작------");
				System.out.println("로그인 확인:유저코드"+((UserDTO)session.getAttribute("user")).getUsercode());
				int bookmarkres = sqlSession.selectOne("bookmark.cheak", dto);
				if(bookmarkres ==0) {
					mav.addObject("bookmark", "🤍");
				}else {
					mav.addObject("bookmark", "❤");
				}
				System.out.println("북마크 끝------");
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
		mav.addObject("list", list);
		

		mav.setViewName("detail");
		
		return mav;

		
		//return aList;
	}// end listMethod()

	@RequestMapping("/bookmark.do")
	public void bookmark(DetailDTO dto, HttpSession session, HttpServletResponse resp,
			@RequestParam(value="contentid", required = false)  String contentid, 
			@RequestParam(value="list", required = false)  String list ) throws IOException {

		System.out.println(dto.getUsercode());
		System.out.println(dto.getContentid());
		int data = sqlSession.selectOne("bookmark.cheak", dto);

		System.out.println("북마크 체크:" + data);		
		if(data == 1) {
			sqlSession.delete("bookmark.del", dto);
		}else {
			sqlSession.insert("bookmark.add", dto);
		}
     	 
     	 //alert발생 후 redirect 하는 방법
         resp.setContentType("text/html;charset=UTF-8");
         PrintWriter out = resp.getWriter();
         out.print("<script>location.href='detail.do?list="+list+"&contentid="+contentid+"';</script>");      
         out.flush();
     	 
     	 
  
		
	}
}// end class
