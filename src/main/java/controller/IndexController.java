package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.ModelAndView;

import dto.DetailDTO;
import dto.UserDTO;

// http://localhost:8090/myapp/index.do

@Controller
public class IndexController {
	private SqlSessionTemplate sqlSession;
	
	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@RequestMapping("/index.do")
	public ModelAndView indexlist(ModelAndView mav, HttpSession session) {
		//조회수 기준 index 정보
		List<DetailDTO> aList = sqlSession.selectList("index.list");
		mav.addObject("aList", aList);
		
		if(session.getAttribute("user") !=null) {
			UserDTO user = (UserDTO)session.getAttribute("user");

		}

		mav.setViewName("index");
		return mav;
	}//end execute()
	

	


	
	
}//end class
