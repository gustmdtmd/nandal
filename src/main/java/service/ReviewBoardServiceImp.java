package service;

import java.io.File;
import java.util.List;

import dao.BoardDAO;

import dto.cardPageDTO;
import dto.PageDTO;
import dto.BoardDTO;

public class ReviewBoardServiceImp implements BoardService {
	private BoardDAO review_dao;

	public ReviewBoardServiceImp() {

	}

	public void setReview_dao(BoardDAO review_dao) {
		this.review_dao = review_dao;
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
		return review_dao.count(dto);
	}

	@Override
	public List<BoardDTO> listProcess(PageDTO pv) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BoardDTO> listProcess(cardPageDTO rpv) {
		return review_dao.list(rpv);
	}

	@Override
	public void insertProcess(BoardDTO dto) {

		// 답변글이면
		if (dto.getRef() != 0) {
			review_dao.reStepCount(dto);
			dto.setRe_step(dto.getRe_step() + 1);
			dto.setRe_level(dto.getRe_level() + 1);
		}

		review_dao.save(dto);
	}

	@Override
	public BoardDTO contentProcess(int num) {
		review_dao.readCount(num);
		return review_dao.content(num);
	}

	@Override
	public void reStepProcess(BoardDTO dto) {
		// TODO Auto-generated method stub
	}

	@Override
	public BoardDTO updateSelectProcess(int num) {
		return review_dao.content(num);
	}

	@Override
	public void updateProcess(BoardDTO dto, String urlpath) {
		String filename = dto.getUpload();

		// 수정한 파일이 있으면
		if (filename != null) {
			String path = review_dao.getFile(dto.getNum());
			// 기존 첨부파일이 있으면
			if (path != null) {
				File file = new File(urlpath, path);
				file.delete();
			}

		}

		review_dao.update(dto);

	}

	@Override
	public void deleteProcess(int num, String urlpath) {
		String path = review_dao.getFile(num);

		// num컬럼에 해당하는 첨부파일이 있으면
		if (path != null) {
			File fe = new File(urlpath, path);
			fe.delete();
		}

		review_dao.delete(num);
	}

	@Override
	public String fileSelectprocess(int num) {
		return review_dao.getFile(num);
	}


	@Override
	public List<BoardDTO> commentProcess(int num) {
		return review_dao.comment(num);
	}

	@Override
	public void commentinsertProcess(BoardDTO dto) {
		
		// 답변글이면
		if (dto.getRef() != 0) {
			review_dao.reStepCountComment(dto);
			dto.setRe_step(dto.getRe_step() + 1);
			dto.setRe_level(dto.getRe_level() + 1);
		}
		review_dao.saveComment(dto);
		
	}

	@Override
	public void deleteCommentProcess(int num) {
		review_dao.deleteComment(num);	
	}

	@Override
	public void updateCommentProcess(BoardDTO dto) {
		review_dao.updateComment(dto);
		
	}

	
}// end class