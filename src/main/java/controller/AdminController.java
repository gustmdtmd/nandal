package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import dto.Admin_memberDTO;
import dto.BoardDTO;
import dto.PageDTO;
import dto.UserDTO;
import dto.cardPageDTO;
import service.AdminService;


// http://localhost:8090/myapp/admin.do

@Controller
public class AdminController {

	private AdminService admin_service;
	private PageDTO pdto;
	private cardPageDTO cpdto;
	private int currentPage;
	
	private SqlSessionTemplate sqlSession;
	
	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	
	public AdminController() {
	
	}

	public void setAdmin_service(AdminService admin_service) {
		this.admin_service = admin_service;
	}
	
	@RequestMapping("/admin.do")
	public String admin_index(HttpSession session) {
		UserDTO user = (UserDTO)session.getAttribute("user");
		
		if(user== null) {
			//로그인 창으로
			return "admin_login";	
		}
		
		if(user.getUsergrade()!=2) {
			//로그아웃 시키고 다시 로그인으로
			System.out.println("관리자가 아님");
			session.removeAttribute("user"); 
			return "admin_login";
		}
		return "admin";
	}//end execute()
	
//	@RequestMapping("/admin_member.do")
//	public String admin_member() {
//		return "admin_member";
//	}//end execute()
	
	@RequestMapping("/admin_member.do")
	public ModelAndView admin_member(PageDTO pv, ModelAndView mav) {
		int totalRecord = admin_service.countProcess();
		if (totalRecord >= 1) {
			if (pv.getCurrentPage() == 0)
				this.currentPage = 1;
			else
				this.currentPage = pv.getCurrentPage();

			this.pdto = new PageDTO(currentPage, totalRecord);
			List<Admin_memberDTO> aList = admin_service.listProcess(this.pdto);

			mav.addObject("aList", aList);
			mav.addObject("pv", this.pdto);
		}
		
		mav.setViewName("admin_member");
		return mav;
	}//end execute()
	
	
	@RequestMapping(value = "/usermodify.do", method = RequestMethod.GET)
	public ModelAndView admin_modify(ModelAndView mav, HttpSession session, 
			@RequestParam(value = "usercode", required = false) int usercode) {
			System.out.println("관리자 수정 도착:" + usercode);
			
		
			UserDTO dto = new UserDTO();
			dto.setUsercode(usercode);
			
			mav.addObject("dto", sqlSession.selectOne("admin.view", dto));
			mav.setViewName("admin_modify");
		
		return mav;
	}//end execute()
	
	
	@RequestMapping(value = "/usermodify.do", method = RequestMethod.POST)
	public ModelAndView updateProMethod(PageDTO pv, ModelAndView mav, UserDTO dto, HttpSession session) {
		System.out.println("관리자 수정 도착:" + dto.getUsercode() + "/"+ dto.getUsergrade());
		sqlSession.update("admin.modify", dto);
		
		int totalRecord = admin_service.countProcess();
		if (totalRecord >= 1) {
			if (pv.getCurrentPage() == 0)
				this.currentPage = 1;
			else
				this.currentPage = pv.getCurrentPage();

			this.pdto = new PageDTO(currentPage, totalRecord);
			List<Admin_memberDTO> aList = admin_service.listProcess(this.pdto);

			mav.addObject("aList", aList);
		}
		mav.setViewName("admin_member");
		
		return mav;
	}
	
	//전체 리뷰 리스트
	@RequestMapping(value = "/areview.do", method = RequestMethod.GET)
	public ModelAndView admin_review(cardPageDTO pv, ModelAndView mav, HttpSession session,
			@RequestParam(value = "list", required = false) String list,
			@RequestParam(value = "searchKey", required = false, defaultValue = "subject") String searchKey,
			@RequestParam(value = "searchWord", required = false, defaultValue = "") String searchWord) {
			
			pv.setSearchKey(searchKey);
			pv.setSearchWord(searchWord);
				
			int totalRecord = sqlSession.selectOne("admin.reviewcount", pv);
			
			if (totalRecord >= 1) {
				if (pv.getCurrentPage() == 0)
					this.currentPage = 1;
				else
					this.currentPage = pv.getCurrentPage();

				this.cpdto = new cardPageDTO(currentPage, totalRecord, searchKey, searchWord);

				List<BoardDTO> aList = sqlSession.selectList("admin.reviewlist", this.cpdto);
				
				mav.addObject("cntt", totalRecord);
				mav.addObject("aList", aList);
				mav.addObject("pv", this.cpdto);		

			}
	
			mav.addObject("list", list);
			mav.addObject("searchKey", searchKey);
			mav.addObject("searchWord", searchWord);
			mav.setViewName("admin_review");
			return mav;
		}

	//전체 질문 리스트
	@RequestMapping(value = "/aqna.do", method = RequestMethod.GET)
	public ModelAndView admin_qna(PageDTO pv, ModelAndView mav, HttpSession session,
			@RequestParam(value = "list", required = false) String list,
			@RequestParam(value = "searchKey", required = false, defaultValue = "subject") String searchKey,
			@RequestParam(value = "searchWord", required = false, defaultValue = "") String searchWord) {
			
			pv.setSearchKey(searchKey);
			pv.setSearchWord(searchWord);
				
			
			int totalRecord = sqlSession.selectOne("admin.qnacount", pv);
				
			if (totalRecord >= 1) {
				if (pv.getCurrentPage() == 0)
					this.currentPage = 1;
				else
					this.currentPage = pv.getCurrentPage();

				this.pdto = new PageDTO(currentPage, totalRecord, searchKey, searchWord);

				List<BoardDTO> aList = sqlSession.selectList("admin.qnalist", this.pdto);
					
				mav.addObject("cntt", totalRecord);
				mav.addObject("aList", aList);
				mav.addObject("pv", this.pdto);		

			}
		
			mav.addObject("list", list);
			mav.addObject("searchKey", searchKey);
			mav.addObject("searchWord", searchWord);
			mav.setViewName("admin_qna");
			return mav;
	}//end execute()
	

}//end class
