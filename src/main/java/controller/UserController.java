package controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.http.HttpRequest;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Controller;

import org.springframework.util.FileCopyUtils;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dto.BoardDTO;
import dto.DetailDTO;
import dto.PageDTO;
import dto.UserDTO;
import dto.cardPageDTO;
import service.UserService;

@Controller
public class UserController {

	private UserService uService;
	private SqlSessionTemplate sqlSession;
	private cardPageDTO rpdto;
	private int currentPage;

	public UserController() {

	}

	public void setUService(UserService uService) {
		this.uService = uService;
	}

	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 이용약관
	@RequestMapping(value = "terms.do")
	public String terms() {
		return "terms";
	}

	// 회원가입
	// join GET
	@RequestMapping(value = "join.do", method = RequestMethod.GET)
	public String insertForm() {
		return "join";
	}

	// join POST
	@RequestMapping(value = "/join.do", method = RequestMethod.POST)
	public String insertData(UserDTO dto, HttpServletRequest request) {
		System.out.println("controller:" + dto.toString());
		MultipartFile file = dto.getFilename();
		String imgName = saveCopyFile(file, request, dto);
		dto.setImg(imgName + ".png");
		uService.insertUser(dto);
		return "redirect:/login.do";
	}

	// 아이디 중복체크
	@RequestMapping(value = "/idCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String idCheck(UserDTO dto, String id) {
		// System.out.println("controller: " + dto.getId());
		int cnt = uService.idCheck(dto);
		// System.out.println("controller: " + cnt);
		String res = "";
		if (cnt == 1) {
			res = "n";
			return res;
		} else {
			res = "y";
			return res;
		}

	}

	// 닉네임 중복체크
	@RequestMapping(value = "/nickCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String nickCheck(UserDTO dto, String nickname) {
		// System.out.println("controller: " + dto.getNickname());
		int cnt = uService.nickCheck(dto);
		// System.out.println("controller: " + cnt);
		String res = "";
		if (cnt == 1) {
			res = "n";
			return res;
		} else {
			res = "y";
			return res;
		}

	}

	// 로그인
	@RequestMapping("/login.do")
	public String loginProcess() {
		System.out.println("login.do get");
		return "login";
	}

	@RequestMapping(value = "/logpro.do", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String loginExecution(UserDTO dto, HttpSession session, String password, String id) {
		int ipc = uService.idpsCheck(dto);

		UserDTO login = uService.login(dto);

		String res = "";
		if (ipc == 1 && login.getUsergrade() != 0) {
			// System.out.println("로그인 성공");
			session.setAttribute("user", login);
			res = login.getNickname();

			return res;
		} else {
			System.out.println("로그인 실패");
			res = "n";
			return res;
		}
	}

	// 로그아웃
	@RequestMapping("/logout.do")
	public String logoutProcess(HttpSession session) {
		session.removeAttribute("user");
		System.out.println("로그아웃");
		return "redirect:/index.do";
	}

	// 마이페이지
	@RequestMapping("/user.do")
	public ModelAndView contentProcess(UserDTO dto, ModelAndView mav, HttpSession session, HttpServletRequest request) {
		dto = uService.contentProcess((UserDTO) session.getAttribute("user"));
		// 이미지 경로
		String filePath = "resources/images/profile/";
		System.out.println(filePath + dto.getImg());
		String img = filePath + dto.getImg();

		dto.setImg(img);

		mav.addObject("dto", dto);
		mav.setViewName("user");
		return mav;
	}

	// 마이페이지 - 정보수정
	// GET은 서버의 리소스에서 데이터를 요청할 때
	@RequestMapping(value = "/modify.do", method = RequestMethod.GET)
	public ModelAndView updateMethod(ModelAndView mav, HttpSession session) {
		// mav.addObject("dto",
		// uService.updateSelectProcess(session.getAttribute("id")));
		mav.addObject("dto", uService.updateSelectProcess((UserDTO) session.getAttribute("user")));
		mav.setViewName("modify");
		return mav;
	}

	// POST는 서버의 리소스를 새로 생성하거나 업데이트할 때 사용
	@RequestMapping(value = "/modify.do", method = RequestMethod.POST)
	public String updateProMethod(UserDTO dto, HttpServletRequest request, HttpSession session) {
		MultipartFile file = dto.getFilename();
		if (!file.isEmpty()) {
			String imgName = saveCopyFile(file, request, dto);
			dto.setImg(imgName + ".png");
		}

		uService.updateProcess(dto, urlPath(request));
		return "redirect:/user.do";
	}

	// 회원탈퇴
	@RequestMapping(value = "/quit.do", method = RequestMethod.POST)
	@ResponseBody
	public String quitExecution(UserDTO dto, HttpSession session) {
		// 탈퇴할 때 500번 오류 발생.
		// update 값이 int로 리턴되지않고 boolean값으로 리턴된다.
		dto = (UserDTO) session.getAttribute("user");

		uService.quit(dto);
		// 탈퇴완료 후 로그아웃된다.

		session.removeAttribute("user");

		return "index.do";
	}

	private String saveCopyFile(MultipartFile file, HttpServletRequest request, UserDTO dto) {
		// String fileName = file.getOriginalFilename();

		String imgName = (String) dto.getId();

		File fe = new File(urlPath(request));
		if (!fe.exists()) {
			fe.mkdir();
		}

		File ff = new File(urlPath(request), imgName + ".png");

		try {
			FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(ff));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return imgName;
	}// end saveCopyFile()

	private String urlPath(HttpServletRequest request) {
		String filePath = request.getSession().getServletContext().getRealPath("/resources/images/profile/");
		System.out.println("urlPath:" + filePath);
		// 경로
		String saveDirectory = filePath + File.separator;
		return saveDirectory;
	}// end urlPath

	// 내가 작성한 리뷰
	@RequestMapping(value = "/userreview.do", method = RequestMethod.GET)
	public ModelAndView userreviewlistSearchMethod(PageDTO pv, ModelAndView mav, HttpSession session,
			@RequestParam(value = "list", required = false) String list,
			@RequestParam(value = "usercode", required = false) String usercode,
			@RequestParam(value = "searchKey", required = false, defaultValue = "subject") String searchKey,
			@RequestParam(value = "searchWord", required = false, defaultValue = "") String searchWord) {

		// 검색을 위한 DTO 객체 생성
		BoardDTO param = new BoardDTO();
		UserDTO udto = new UserDTO();
		udto.setUsercode(Integer.parseInt(usercode));
		param.setWriter(Integer.parseInt(usercode));
		param.setSearchKey(searchKey);
		param.setSearchWord(searchWord);

		int totalRecord = sqlSession.selectOne("user.reviewcount", param);

		if (totalRecord >= 1) {
			if (pv.getCurrentPage() == 0)
				this.currentPage = 1;
			else
				this.currentPage = pv.getCurrentPage();

			this.rpdto = new cardPageDTO(currentPage, totalRecord, param, udto);

			List<BoardDTO> aList = sqlSession.selectList("user.reviewlist", this.rpdto);

			mav.addObject("cntt", totalRecord);
			mav.addObject("aList", aList);
			mav.addObject("pv", this.rpdto);

		}
		mav.addObject("usercdoe", usercode);
		mav.addObject("list", list);
		mav.addObject("searchKey", searchKey);
		mav.addObject("searchWord", searchWord);
		mav.setViewName("userreview");
		return mav;
	}

	// 내가 작성한 질문
	@RequestMapping(value = "/userqna.do", method = RequestMethod.GET)
	public ModelAndView userqnalistSearchMethod(PageDTO pv, ModelAndView mav, HttpSession session,
			@RequestParam(value = "list", required = false) String list,
			@RequestParam(value = "usercode", required = false) String usercode,
			@RequestParam(value = "searchKey", required = false, defaultValue = "subject") String searchKey,
			@RequestParam(value = "searchWord", required = false, defaultValue = "") String searchWord) {

		// 검색을 위한 DTO 객체 생성
		BoardDTO param = new BoardDTO();
		UserDTO udto = new UserDTO();
		udto.setUsercode(Integer.parseInt(usercode));
		param.setWriter(Integer.parseInt(usercode));
		param.setSearchKey(searchKey);
		param.setSearchWord(searchWord);

		int totalRecord = sqlSession.selectOne("user.qnacount", param);

		System.out.println("tc:" + totalRecord);
		// 검색결과 오류 수정되어야 하는 부분
		if (totalRecord >= 1) {
			if (pv.getCurrentPage() == 0)
				this.currentPage = 1;
			else
				this.currentPage = pv.getCurrentPage();

			this.rpdto = new cardPageDTO(currentPage, totalRecord, param, udto);

			List<BoardDTO> aList = sqlSession.selectList("user.qnalist", this.rpdto);

			System.out.println("aList:" + aList.size());
			mav.addObject("cntt", totalRecord);
			mav.addObject("aList", aList);
			mav.addObject("pv", this.rpdto);

		}
		mav.addObject("usercdoe", usercode);
		mav.addObject("list", list);
		mav.addObject("searchKey", searchKey);
		mav.addObject("searchWord", searchWord);
		mav.setViewName("userqna");
		return mav;
	}

	// 내 북마크
	@RequestMapping(value = "/userbookmark.do", method = RequestMethod.GET)
	public ModelAndView userbookmarklistSearchMethod(PageDTO pv, ModelAndView mav, HttpSession session,
			@RequestParam(value = "list", required = false) String list,
			@RequestParam(value = "usercode", required = false) String usercode,
			@RequestParam(value = "searchKey", required = false, defaultValue = "total") String searchKey,
			@RequestParam(value = "searchWord", required = false, defaultValue = "") String searchWord) {
		System.out.println("user bookmark 검색");

		// 검색을 위한 DTO 객체 생성
		BoardDTO param = new BoardDTO();
		UserDTO udto = (UserDTO) session.getAttribute("user");
		if (usercode != null) {
			param.setUsercode(Integer.parseInt(usercode));
		} else {
			param.setUsercode(udto.getUsercode());
		}
		param.setSearchKey(searchKey);
		param.setSearchWord(searchWord);

		// 페이징
//		int totalRecord = sqlSession.selectOne("user.bookmarkcount",param);
//		System.out.println("totalRecord: " + totalRecord);
//		
//		// 검색결과 오류 수정되어야 하는 부분
//		if (totalRecord >= 1) {
//			if (pv.getCurrentPage() == 0)
//				this.currentPage = 1;
//			else
//				this.currentPage = pv.getCurrentPage();
//
//			this.rpdto = new cardPageDTO(currentPage, totalRecord, param, udto);

		List<BoardDTO> aList = sqlSession.selectList("user.bookmarklist", udto);

		System.out.println("aList:" + aList.size());
//			mav.addObject("cntt", totalRecord);
		mav.addObject("aList", aList);
//			mav.addObject("pv", this.rpdto);

//		}

		mav.addObject("list", list);
		mav.addObject("searchKey", searchKey);
		mav.addObject("searchWord", searchWord);
		mav.setViewName("userbookmark");
		return mav;
	}

}
