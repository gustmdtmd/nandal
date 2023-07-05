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

import dto.PageDTO;
import dto.BoardDTO;
import service.BoardService;

// http://localhost:8090/myapp/nlist.do

@Controller
public class NoticeBoardController {

	private BoardService notice_service;
	private PageDTO pdto;
	private int currentPage;
	
	public NoticeBoardController() {

	}

	public void setNotice_service(BoardService notice_service) {
		this.notice_service = notice_service;
	}
	
	//본글 부분-------------------------------------------------------	
	//본글 리스트
	@RequestMapping(value = "/nlist.do", method = RequestMethod.GET)
	public ModelAndView listSearchMethod(PageDTO pv, ModelAndView mav, HttpSession session,
			@RequestParam(value = "searchKey", required = false, defaultValue = "subject") String searchKey,
			@RequestParam(value = "searchWord", required = false, defaultValue = "") String searchWord) {
		
		pv.setSearchKey(searchKey);
		pv.setSearchWord(searchWord);
		
		int totalRecord = notice_service.countProcess();
		// 검색결과 오류 수정되어야 하는 부분
		if (totalRecord >= 1) {
			if (pv.getCurrentPage() == 0)
				this.currentPage = 1;
			else
				this.currentPage = pv.getCurrentPage();

			this.pdto = new PageDTO(currentPage, totalRecord, searchKey, searchWord);

			List<BoardDTO> aList = notice_service.listProcess(this.pdto);
			mav.addObject("cntt", totalRecord);
			mav.addObject("aList", aList);
			mav.addObject("pv", this.pdto);

		}

		mav.setViewName("nlist");
		return mav;
	}

	
	//본글 작성폼
	@RequestMapping(value = "/nwrite.do", method = RequestMethod.GET)
	public ModelAndView writeMethod(BoardDTO dto, PageDTO pv, ModelAndView mav) {
		// 답변글이면
		if (dto.getRef() != 0) { 
			mav.addObject("currentPage", pv.getCurrentPage());
			mav.addObject("dto", dto);
		}
		mav.setViewName("nwrite");
		return mav;
	}// end writeMethod()

	//본글 작성
	@RequestMapping(value = "/nwrite.do", method = RequestMethod.POST)
	public String writeProMethod(BoardDTO dto, PageDTO pv, HttpServletRequest request, HttpSession session) {
		//파일명
		MultipartFile file = dto.getFilename();
		if(!file.isEmpty()) {
			UUID random = saveCopyFile(file, request);
			dto.setUpload(random+"_"+file.getOriginalFilename());
		}
		
		// ip 값
		dto.setIp(request.getRemoteAddr());
		
		notice_service.insertProcess(dto);

		// 답변글이면
		if (dto.getRef() != 0) {
			return "redirect:/nlist.do?courrentPage=" + pv.getCurrentPage();
		} else { // 제목글
			return "redirect:/nlist.do";
		}
	}// end writeProMethod()

	
	//본글 수정폼
	@RequestMapping(value = "/nupdate.do", method = RequestMethod.GET)
	public ModelAndView updateMethod(int num, int currentPage, ModelAndView mav) {
		mav.addObject("dto", notice_service.updateSelectProcess(num));
		mav.addObject("currentPage", currentPage);
		mav.setViewName("nupdate");
		return mav;
	}// end updateMethod()

	//본글 수정
	@RequestMapping(value = "/nupdate.do", method = RequestMethod.POST)
	public String updateProMethod(BoardDTO dto, int currentPage, HttpServletRequest request) {
		MultipartFile file = dto.getFilename();
		if(!file.isEmpty()) {
			UUID random = saveCopyFile(file, request);
			dto.setUpload(random + "_" + file.getOriginalFilename());
		}
		
		notice_service.updateProcess(dto, urlPath(request));
		return "redirect:/nlist.do?currentPage=" + currentPage;
	}// end updateProMethod()
	
	//본글 삭제
	@RequestMapping(value = "/ndelete.do")
	public String deleteMethod(int num, int currentPage, HttpServletRequest request) {
		notice_service.deleteProcess(num, urlPath(request));

		int totalRecord = notice_service.countProcess();
		this.pdto = new PageDTO(this.currentPage, totalRecord);

		return "redirect:/nlist.do?currentPage=" + this.pdto.getCurrentPage();
	}// end deleteMethod()

	//본글 이미지 다운로드
	@RequestMapping("/ncontentdownload.do")
	public ModelAndView downMethod(int num, ModelAndView mav) {
		mav.addObject("num", num);
		mav.setViewName("ndownload");
		return mav;
	}// end downMethod()
	
	//본글 보기
	@RequestMapping("/nview.do")
	public ModelAndView viewMethod(int currentPage, BoardDTO dto, ModelAndView mav, PageDTO pv, int num) {
		mav.addObject("dto", notice_service.contentProcess(num));
		mav.addObject("currentPage", currentPage);
		
		//댓글(페이징 미처리)
		List<BoardDTO> bList = notice_service.commentProcess(num);
		//mav.addObject("cntt", dao.count(dto));
		mav.addObject("bList", bList);
		//mav.addObject("pv", this.pdto);
		//}
		
		mav.setViewName("nview");		
		return mav;
	}// viewMethod()

	//댓글 작성
	@RequestMapping("/nrview.do")
	public ModelAndView commentlist(int currentPage, BoardDTO dto, ModelAndView mav, PageDTO pv, int num, HttpServletRequest request){
		//dto 받은 정보로 댓글 쓰기
		dto.setIp(request.getRemoteAddr());		
		notice_service.commentinsertProcess(dto);

		//본글
		mav.addObject("dto", notice_service.contentProcess(num));
		mav.addObject("currentPage", currentPage);
		
		//댓글
		List<BoardDTO> bList = notice_service.commentProcess(num);
		//mav.addObject("cntt", dao.count(dto));
		mav.addObject("bList", bList);
		//mav.addObject("pv", this.pdto);
		//}
		
		mav.setViewName("nview");		
		return mav;
	}// end commentlist()

	// 댓글 삭제
	@RequestMapping(value = "/nrdelete.do")
	public ModelAndView deleteCommentMethod(int pnum, int num, int currentPage, BoardDTO dto, ModelAndView mav) {
		//System.out.println("댓글 삭제");
		//System.out.println("nrdelete: " + num + "cp:" + currentPage +"pnum:" + pnum);
		notice_service.deleteCommentProcess(dto.getNum());

		//return "redirect:/nlist.do?currentPage=" + currentPage + "&num=" + dto.getPnum();
		
		//본글
		mav.addObject("dto", notice_service.contentProcess(pnum));
		mav.addObject("currentPage", currentPage);
		
		//댓글
		List<BoardDTO> bList = notice_service.commentProcess(pnum);
		//mav.addObject("cntt", dao.count(dto));
		mav.addObject("bList", bList);
		//mav.addObject("pv", this.pdto);
		//}
		mav.setViewName("nview");		
		return mav;
	}// end deleteCommentMethod()

	// 댓글 수정
	@RequestMapping(value = "/nrupdate.do", method = RequestMethod.POST)
	public ModelAndView updateCommentProMethod(int pnum, int num, int currentPage, BoardDTO dto, ModelAndView mav) {
		//댓글 수정
		notice_service.updateCommentProcess(dto);
		
		//본글
		mav.addObject("dto", notice_service.contentProcess(pnum));
		mav.addObject("currentPage", currentPage);
		
		//댓글
		List<BoardDTO> bList = notice_service.commentProcess(pnum);
		//mav.addObject("cntt", dao.count(dto));
		mav.addObject("bList", bList);
		//mav.addObject("pv", this.pdto);
		//}
		mav.setViewName("nview");		
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
		String filePath = request.getSession().getServletContext().getRealPath("/resources/board/notice/");
		System.out.println("urlPath:" + filePath);
		// 경로 
		String saveDirectory = filePath + File.separator;
		return saveDirectory;
	}// end urlPath

}// end class