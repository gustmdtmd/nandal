package service;

import java.io.File;
import java.util.List;


import dao.BoardDAO;
import dto.PageDTO;
import dto.cardPageDTO;
import dto.BoardDTO;

public class NoticeBoardServiceImp implements BoardService {
	private BoardDAO notice_dao;

	public NoticeBoardServiceImp() {

	}

	public void setNotice_dao(BoardDAO notice_dao) {
		this.notice_dao = notice_dao;
	}

	@Override
	public int countProcess() {
		return notice_dao.count();
	}

	@Override
	public int countProcess(PageDTO pv) {
		return notice_dao.count(pv);
	}
	
	@Override
	public int countProcess(cardPageDTO rpdto) {
		return notice_dao.count(rpdto);
	}

	@Override
	public int countProcess(BoardDTO dto) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public List<BoardDTO> listProcess(PageDTO pv) {
		return notice_dao.list(pv);
	}

	@Override
	public List<BoardDTO> listProcess(cardPageDTO rpdto) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public void insertProcess(BoardDTO dto) {

		// 답변글이면
		if (dto.getRef() != 0) {
			notice_dao.reStepCount(dto);
			dto.setRe_step(dto.getRe_step() + 1);
			dto.setRe_level(dto.getRe_level() + 1);
		}

		notice_dao.save(dto);
	}

	@Override
	public BoardDTO contentProcess(int num) {
		notice_dao.readCount(num);
		return notice_dao.content(num);
	}

	@Override
	public void reStepProcess(BoardDTO dto) {
		// TODO Auto-generated method stub
	}

	@Override
	public BoardDTO updateSelectProcess(int num) {
		return notice_dao.content(num);
	}

	@Override
	public void updateProcess(BoardDTO dto, String urlpath) {
		String filename = dto.getUpload();

		// 수정한 파일이 있으면
		if (filename != null) {
			String path = notice_dao.getFile(dto.getNum());
			// 기존 첨부파일이 있으면
			if (path != null) {
				File file = new File(urlpath, path);
				file.delete();
			}
		}

		notice_dao.update(dto);

	}

	@Override
	public void deleteProcess(int num, String urlpath) {
		String path = notice_dao.getFile(num);

		// num컬럼에 해당하는 첨부파일이 있으면
		if (path != null) {
			File fe = new File(urlpath, path);
			fe.delete();
		}

		notice_dao.delete(num);
	}

	@Override
	public String fileSelectprocess(int num) {
		return notice_dao.getFile(num);
	}


	@Override
	public void commentinsertProcess(BoardDTO dto) {
		
		// 답변글이면
		if (dto.getRef() != 0) {
			notice_dao.reStepCountComment(dto);
			dto.setRe_step(dto.getRe_step() + 1);
			dto.setRe_level(dto.getRe_level() + 1);
		}
		notice_dao.saveComment(dto);
		
	}

	@Override
	public List<BoardDTO> commentProcess(int num) {
		return notice_dao.comment(num);
	}

	@Override
	public void deleteCommentProcess(int num) {
		notice_dao.deleteComment(num);			
	}

	@Override
	public void updateCommentProcess(BoardDTO dto) {
		notice_dao.updateComment(dto);
		
	}


}// end class
