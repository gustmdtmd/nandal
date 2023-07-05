package controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;

import java.util.HashMap;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.servlet.ModelAndView;

import dto.DetailDTO;
import dto.PageDTO;
import dto.UserDTO;

// http://localhost:8090/myapp/paldo.do

@Controller
public class BookmarkListController {
	private SqlSessionTemplate sqlSession;
	
	public BookmarkListController() {

	}
	
	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}
	

	@RequestMapping(value = "/bookmarklist.do", method = RequestMethod.GET)
	public ModelAndView listMethod(PageDTO pv, ModelAndView mav, HttpSession session) {
		
		//조회수 기준 index 정보
		List<DetailDTO> aList = sqlSession.selectList("bookmarklist.list");
		mav.addObject("aList", aList);
		
		if(session.getAttribute("user") !=null) {
			UserDTO user = (UserDTO)session.getAttribute("user");

		}


		mav.setViewName("bookmarklist");
		return mav;
	}//end listMethod()
	}
	