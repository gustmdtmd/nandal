package service;

import java.io.File;
import java.util.List;


import dao.BoardDAO;
import dto.PageDTO;
import dto.cardPageDTO;
import dto.BoardDTO;

public class AdminNoticeBoardServiceImp implements BoardService {
	private BoardDAO anotice_dao;

	public AdminNoticeBoardServiceImp() {

	}

	public void setAnotice_dao(BoardDAO anotice_dao) {
		this.anotice_dao = anotice_dao;
	}

	@Override
	public int countProcess() {
		return anotice_dao.count();
	}

	@Override
	public List<BoardDTO> listProcess(PageDTO pv) {
		return anotice_dao.list(pv);
	}

	@Override
	public void insertProcess(BoardDTO dto) {

		// 답변글이면
		if (dto.getRef() != 0) {
			anotice_dao.reStepCount(dto);
			dto.setRe_step(dto.getRe_step() + 1);
			dto.setRe_level(dto.getRe_level() + 1);
		}

		anotice_dao.save(dto);
	}

	@Override
	public BoardDTO contentProcess(int num) {
		anotice_dao.readCount(num);
		return anotice_dao.content(num);
	}

	@Override
	public void reStepProcess(BoardDTO dto) {
		// TODO Auto-generated method stub

	}

	@Override
	public BoardDTO updateSelectProcess(int num) {
		return anotice_dao.content(num);
	}

	@Override
	public void updateProcess(BoardDTO dto, String urlpath) {
		String filename = dto.getUpload();

		// 수정한 파일이 있으면
		if (filename != null) {
			String path = anotice_dao.getFile(dto.getNum());
			// 기존 첨부파일이 있으면
			if (path != null) {
				File file = new File(urlpath, path);
				file.delete();
			}

		}

		anotice_dao.update(dto);

	}

	@Override
	public void deleteProcess(int num, String urlpath) {
		String path = anotice_dao.getFile(num);

		// num컬럼에 해당하는 첨부파일이 있으면
		if (path != null) {
			File fe = new File(urlpath, path);
			fe.delete();
		}

		anotice_dao.delete(num);
	}

	@Override
	public String fileSelectprocess(int num) {
		return anotice_dao.getFile(num);
	}

	@Override
	public int countProcess(BoardDTO dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<BoardDTO> listProcess(cardPageDTO rpdto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BoardDTO> commentProcess(int num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void commentinsertProcess(BoardDTO dto) {
		// TODO Auto-generated method stub
		
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
	public void deleteCommentProcess(int num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateCommentProcess(BoardDTO dto) {
		// TODO Auto-generated method stub
		
	}

}// end class
