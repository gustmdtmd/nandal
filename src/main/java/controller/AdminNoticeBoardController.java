package controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dto.PageDTO;
import dto.BoardDTO;
import service.BoardService;

// http://localhost:8090/myapp/list.do

@Controller
public class AdminNoticeBoardController {

	private BoardService anotice_service;
	private PageDTO pdto;
	private int currentPage;

	public AdminNoticeBoardController() {

	}

	public void setAnotice_service(BoardService anotice_service) {
		this.anotice_service = anotice_service;
	}

	@RequestMapping("/anlist.do")
	public ModelAndView listMethod(PageDTO pv, ModelAndView mav) {
		int totalRecord = anotice_service.countProcess();
		if (totalRecord >= 1) {
			if (pv.getCurrentPage() == 0)
				this.currentPage = 1;
			else
				this.currentPage = pv.getCurrentPage();

			this.pdto = new PageDTO(currentPage, totalRecord);
			List<BoardDTO> aList = anotice_service.listProcess(this.pdto);

			mav.addObject("aList", aList);
			mav.addObject("pv", this.pdto);
		}

		mav.setViewName("anlist");
		return mav;
	}// end listMethod()

	@RequestMapping(value = "/anwrite.do", method = RequestMethod.GET)
	public ModelAndView writeMethod(BoardDTO dto, PageDTO pv, ModelAndView mav) {
		if (dto.getRef() != 0) { // 답변글이면
			mav.addObject("currentPage", pv.getCurrentPage());
			mav.addObject("dto", dto);
		}
		mav.setViewName("nwrite");
		return mav;
	}// end writeMethod()

	@RequestMapping(value = "/anwrite.do", method = RequestMethod.POST)
	public String writeProMethod(BoardDTO dto, PageDTO pv, HttpServletRequest request) {
		MultipartFile file = dto.getFilename();
		if (!file.isEmpty()) {
			UUID random = saveCopyFile(file, request);
			dto.setUpload(random + "_" + file.getOriginalFilename());
		}
		dto.setIp(request.getRemoteAddr());

		anotice_service.insertProcess(dto);

		// 답변글이면
		if (dto.getRef() != 0) {
			return "redirect:/anlist.do?courrentPage=" + pv.getCurrentPage();
		} else { // 제목글
			return "redirect:/anlist.do";
		}
	}// end writeProMethod()

	@RequestMapping(value = "/anupdate.do", method = RequestMethod.GET)
	public ModelAndView updateMethod(int num, int currentPage, ModelAndView mav) {
		mav.addObject("dto", anotice_service.updateSelectProcess(num));
		mav.addObject("currentPage", currentPage);
		mav.setViewName("nupdate");
		return mav;
	}// end updateMethod()

	@RequestMapping(value = "/anupdate.do", method = RequestMethod.POST)
	public String updateProMethod(BoardDTO dto, int currentPage, HttpServletRequest request) {
		MultipartFile file = dto.getFilename();
		if (!file.isEmpty()) {
			UUID random = saveCopyFile(file, request);
			dto.setUpload(random + "_" + file.getOriginalFilename());
		}

		anotice_service.updateProcess(dto, urlPath(request));
		return "redirect:/anlist.do?currentPage=" + currentPage;
	}// end updateProMethod()

	@RequestMapping(value = "/andelete.do")
	public String deleteMethod(int num, int currentPage, HttpServletRequest request) {
		anotice_service.deleteProcess(num, urlPath(request));

		int totalRecord = anotice_service.countProcess();
		this.pdto = new PageDTO(this.currentPage, totalRecord);

		return "redirect:/anlist.do?currentPage=" + this.pdto.getCurrentPage();
	}// end deleteMethod()

	private UUID saveCopyFile(MultipartFile file, HttpServletRequest request) {
		String fileName = file.getOriginalFilename();

		// 중복파일명을 처리하기 위해 난수 발생
		UUID random = UUID.randomUUID();

		File fe = new File(urlPath(request));
		if (!fe.exists()) {
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
	}// end saveCopyFile()

	private String urlPath(HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("/");
		// D:\HOJIN\spring_workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\spring_08_board
		System.out.println("root:" + root);
		String saveDirectory = root + "temp" + File.separator;
		return saveDirectory;
	}// end urlPath

	@RequestMapping("/anview.do")
	public ModelAndView viewMethod(int currentPage, int num, ModelAndView mav) {
		mav.addObject("dto", anotice_service.contentProcess(num));
		mav.addObject("currentPage", currentPage);
		mav.setViewName("nview");
		return mav;
	}// viewMethod()

	@RequestMapping("/ancontentdownload.do")
	public ModelAndView downMethod(int num, ModelAndView mav) {
		mav.addObject("num", num);
		mav.setViewName("ndownload");
		return mav;
	}// end downMethod()

}// end class