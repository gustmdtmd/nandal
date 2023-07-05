package view;

import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import dao.BoardDAO;

//다운로드 창을 띄우기 위한 뷰 페이지
public class ReviewBoardDownLoadView extends AbstractView{

	private BoardDAO review_dao;
	
	public ReviewBoardDownLoadView() {
		
	}
	
	public void setReview_dao(BoardDAO review_dao) {
		this.review_dao = review_dao;
	}
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		int num = Integer.parseInt(request.getParameter("num"));
		
		String root = request.getSession().getServletContext().getRealPath("/");
		String saveDirectory = root + "temp" + File.separator;
		
		String upload = review_dao.getFile(num);
		String fileName = upload.substring(upload.indexOf("_")+ 1);
		
		//파일명이 한글일때 인코딩 작업을 한다.
		String str = URLEncoder.encode(fileName, "UTF-8");
		
		//원본파일명에서 공백이 있을 때, +표시가 되므로 공백으로 처리해줌(질문)
		str = str.replace("\\+", "%20");
		
		//컨텐츠 타입
		response.setContentType("application/octet-stream");
		
		//다운로드 창에 보여줄 파일명을 지정한다.
		response.setHeader("Content-Disposition", "attachment;filename="+str+";");
		
		//서버에 저장된 파일을 읽어와 클라이언트에 출력해 준다.
		FileCopyUtils.copy(new FileInputStream(new File(saveDirectory, upload)), response.getOutputStream());
		
	}
}
