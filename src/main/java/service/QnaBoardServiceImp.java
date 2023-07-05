package service;

import java.io.File;
import java.util.List;

import dao.BoardDAO;
import dto.PageDTO;
import dto.cardPageDTO;
import dto.BoardDTO;

public class QnaBoardServiceImp implements BoardService {
	private BoardDAO qna_dao;

	public QnaBoardServiceImp() {

	}

	public void setQna_dao(BoardDAO qna_dao) {
		this.qna_dao = qna_dao;
	}

	@Override
	public int countProcess() {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public int countProcess(PageDTO pv) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int countProcess(cardPageDTO rpdto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int countProcess(BoardDTO dto) {
		return qna_dao.count(dto);
	}

	@Override
	public List<BoardDTO> listProcess(PageDTO pv) {
		return qna_dao.list(pv);
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
			qna_dao.reStepCount(dto);
			dto.setRe_step(dto.getRe_step() + 1);
			dto.setRe_level(dto.getRe_level() + 1);
		}

		qna_dao.save(dto);
	}

	@Override
	public BoardDTO contentProcess(int num) {
		qna_dao.readCount(num);
		return qna_dao.content(num);
	}

	@Override
	public void reStepProcess(BoardDTO dto) {
		// TODO Auto-generated method stub
	}

	@Override
	public BoardDTO updateSelectProcess(int num) {
		return qna_dao.content(num);
	}

	@Override
	public void updateProcess(BoardDTO dto, String urlpath) {
		String filename = dto.getUpload();

		// 수정한 파일이 있으면
		if (filename != null) {
			String path = qna_dao.getFile(dto.getNum());
			// 기존 첨부파일이 있으면
			if (path != null) {
				File file = new File(urlpath, path);
				file.delete();
			}

		}

		qna_dao.update(dto);

	}

	@Override
	public void deleteProcess(int num, String urlpath) {
		String path = qna_dao.getFile(num);

		// num컬럼에 해당하는 첨부파일이 있으면
		if (path != null) {
			File fe = new File(urlpath, path);
			fe.delete();
		}

		qna_dao.delete(num);
	}

	@Override
	public String fileSelectprocess(int num) {
		return qna_dao.getFile(num);
	}

	
	@Override
	public void commentinsertProcess(BoardDTO dto) {
		
		// 답변글이면
		if (dto.getRef() != 0) {
			qna_dao.reStepCountComment(dto);
			dto.setRe_step(dto.getRe_step() + 1);
			dto.setRe_level(dto.getRe_level() + 1);
		}
		qna_dao.saveComment(dto);
		
	}
	
	@Override
	public List<BoardDTO> commentProcess(int num) {
		return qna_dao.comment(num);
	}

	@Override
	public void deleteCommentProcess(int num) {
		qna_dao.deleteComment(num);		
	}

	@Override
	public void updateCommentProcess(BoardDTO dto) {
		qna_dao.updateComment(dto);
		
	}

	
}// end class
