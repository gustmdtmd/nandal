package controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dto.cardPageDTO;
import dto.PageDTO;
import dto.BoardDTO;
import service.BoardService;

// http://localhost:8090/myapp/rlist.do

@Controller
public class ReviewBoardController {

	private BoardService review_service;
	private cardPageDTO rpdto;
	private int currentPage;

	public ReviewBoardController() {

	}

	public void setReview_service(BoardService review_service) {
		this.review_service = review_service;
	}

	//본글 부분-------------------------------------------------------	
	//본글 리스트
	@RequestMapping(value = "/rlist.do", method = RequestMethod.GET)
	public ModelAndView listMethod(cardPageDTO pv, ModelAndView mav,
			@RequestParam(value = "contentid", required = false) int contentid,
			@RequestParam(value = "list", required = false) String list,
			@RequestParam(value = "searchKey", required = false, defaultValue = "subject") String searchKey,
			@RequestParam(value = "searchWord", required = false, defaultValue = "") String searchWord) {

		// 검색을 위한 DTO 객체 생성
		BoardDTO param = new BoardDTO();
		param.setSearchKey(searchKey);
		param.setSearchWord(searchWord);
		param.setContentid(contentid);
		
		// 검색어 리스트 수 조회
		int totalRecord = review_service.countProcess(param);
		
		if (totalRecord >= 1) {
			if (pv.getCurrentPage() == 0)
				this.currentPage = 1;
			else
				this.currentPage = pv.getCurrentPage();
		
			this.rpdto = new cardPageDTO(currentPage, totalRecord, contentid, searchKey, searchWord);

			List<BoardDTO> aList = review_service.listProcess(this.rpdto);
			mav.addObject("cntt", totalRecord);
			mav.addObject("aList", aList);
			mav.addObject("pv", this.rpdto);
		}
		mav.addObject("contentid", contentid);
		mav.addObject("list", list);
		mav.addObject("searchKey", searchKey);
		mav.addObject("searchWord", searchWord);
		mav.setViewName("rlist");
		return mav;
	}// end listMethod()
	
	//본글 작성폼
	@RequestMapping(value = "/rwrite.do", method = RequestMethod.GET)
	public ModelAndView writeMethod(BoardDTO dto, cardPageDTO pv, ModelAndView mav) {
		// 답변글이면
		if (dto.getRef() != 0) { 
			mav.addObject("currentPage", pv.getCurrentPage());
			mav.addObject("dto", dto);
		}
		mav.addObject("contentid", dto.getContentid());
		mav.setViewName("rwrite");
		return mav;
	}// end writeMethod()

	//본글 작성
	@RequestMapping(value = "/rwrite.do", method = RequestMethod.POST)
	public String writeProMethod(BoardDTO dto, cardPageDTO pv, HttpServletRequest request, HttpSession session) {
		//파일명
		MultipartFile file = dto.getFilename();
		if(!file.isEmpty()) {
			UUID random = saveCopyFile(file, request);
			dto.setUpload(random+"_"+file.getOriginalFilename());
		}
		
		// ip 값
		dto.setIp(request.getRemoteAddr());
		
		review_service.insertProcess(dto);

		// 답변글이면
		if (dto.getRef() != 0) {
			return "redirect:/rlist.do?contentid="+dto.getContentid()+"&courrentPage=" + pv.getCurrentPage();
		} else { // 제목글
			return "redirect:/rlist.do?contentid="+dto.getContentid();
		}
	} // end writeProMethod()

	
	//본글 수정폼
	@RequestMapping(value = "/rupdate.do", method = RequestMethod.GET)
	public ModelAndView updateMethod(BoardDTO dto, int num, int currentPage, ModelAndView mav) {
		mav.addObject("contentid", dto.getContentid());
		mav.addObject("dto", review_service.updateSelectProcess(num));
		mav.addObject("currentPage", currentPage);
		mav.setViewName("rupdate");
		return mav;
	}// end updateMethod()

	//본글 수정
	@RequestMapping(value = "/rupdate.do", method = RequestMethod.POST)
	public String updateProMethod(BoardDTO dto, int currentPage, HttpServletRequest request) {
		MultipartFile file = dto.getFilename();
		if(!file.isEmpty()) {
			UUID random = saveCopyFile(file, request);
			dto.setUpload(random + "_" + file.getOriginalFilename());
		}

		review_service.updateProcess(dto, urlPath(request));
		return "redirect:/rlist.do?contentid="+dto.getContentid()+"&currentPage=" + currentPage;
	}// end updateProMethod()

	//본글 삭제
	@RequestMapping(value = "/rdelete.do")
	public String deleteMethod(int num, int currentPage, HttpServletRequest request) {
		review_service.deleteProcess(num, urlPath(request));

		int totalRecord = review_service.countProcess();
		this.rpdto = new cardPageDTO(this.currentPage, totalRecord);
		
		return "redirect:/rlist.do?currentPage=" + this.rpdto.getCurrentPage();
	}// end deleteMethod()
	
	//본글 이미지 다운로드
	@RequestMapping("/rcontentdownload.do")
	public ModelAndView downMethod(int num, ModelAndView mav) {
		mav.addObject("num", num);
		mav.setViewName("rdownload");
		return mav;
	}// end downMethod()
	
	
	//본글 보기
	@RequestMapping("/rview.do")
	public ModelAndView viewMethod(int currentPage, int num, int contentid, ModelAndView mav) {
		mav.addObject("dto", review_service.contentProcess(num));
		mav.addObject("currentPage", currentPage);
		mav.addObject("contentid", contentid);
		
		//댓글(페이징 미처리)
		List<BoardDTO> bList = review_service.commentProcess(num);
		//mav.addObject("cntt", dao.count(dto));
		mav.addObject("bList", bList);
		//mav.addObject("pv", this.pdto);
		//}
		
		
		mav.setViewName("rview");
		return mav;
	}// viewMethod()
	
	//댓글 작성
	@RequestMapping("/rrview.do")
	public ModelAndView commentlist(int currentPage, BoardDTO dto, ModelAndView mav, PageDTO pv, int num, HttpServletRequest request){
		//dto 받은 정보로 댓글 쓰기
		dto.setIp(request.getRemoteAddr());		
		review_service.commentinsertProcess(dto);

		//본글
		mav.addObject("dto", review_service.contentProcess(num));
		mav.addObject("currentPage", currentPage);
		
		//댓글
		List<BoardDTO> bList = review_service.commentProcess(num);
		//mav.addObject("cntt", dao.count(dto));
		mav.addObject("bList", bList);
		//mav.addObject("pv", this.pdto);
		//}
		
		mav.setViewName("rview");		
		return mav;
	}// end commentlist()

	// 댓글 삭제
	@RequestMapping(value = "/rrdelete.do")
	public ModelAndView deleteCommentMethod(int pnum, int num, int currentPage, BoardDTO dto, ModelAndView mav) {
		//System.out.println("댓글 삭제");
		//System.out.println("nrdelete: " + num + "cp:" + currentPage +"pnum:" + pnum);
		review_service.deleteCommentProcess(dto.getNum());

		//return "redirect:/nlist.do?currentPage=" + currentPage + "&num=" + dto.getPnum();
		
		//본글
		mav.addObject("dto", review_service.contentProcess(pnum));
		mav.addObject("currentPage", currentPage);
		
		//댓글
		List<BoardDTO> bList = review_service.commentProcess(pnum);
		//mav.addObject("cntt", dao.count(dto));
		mav.addObject("bList", bList);
		//mav.addObject("pv", this.pdto);
		//}
		mav.setViewName("rview");		
		return mav;
	}// end deleteCommentMethod()

	// 댓글 수정
	@RequestMapping(value = "/rrupdate.do", method = RequestMethod.POST)
	public ModelAndView updateCommentProMethod(int pnum, int num, int currentPage, BoardDTO dto, ModelAndView mav) {
		//댓글 수정
		review_service.updateCommentProcess(dto);
		
		//본글
		mav.addObject("dto", review_service.contentProcess(pnum));
		mav.addObject("currentPage", currentPage);
		
		//댓글
		List<BoardDTO> bList = review_service.commentProcess(pnum);
		//mav.addObject("cntt", dao.count(dto));
		mav.addObject("bList", bList);
		//mav.addObject("pv", this.pdto);
		//}
		mav.setViewName("rview");		
		return mav;
	}// end deleteCommentMethod()
	
	
	//파일 저장
	private UUID saveCopyFile(MultipartFile file, HttpServletRequest request) {
		String fileName = file.getOriginalFilename();
		
		//중복파일명을 처리하기 위해 난수 발생
		UUID random = UUID.randomUUID();
		
		File fe = new File(urlPath(request));
		if(!fe.exists()) {
			fe.mkdir();
		}
		
		File ff = new File(urlPath(request), random + "_" + fileName);
		
		try {
			FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(ff));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return random;
	}//end saveCopyFile()

	//파일 저장 경로
	private String urlPath(HttpServletRequest request) {
		String filePath = request.getSession().getServletContext().getRealPath("/resources/board/review/");
		System.out.println("urlPath:" + filePath);
		// 경로 
		String saveDirectory = filePath + File.separator;
		return saveDirectory;
	}// end urlPath

}// end class