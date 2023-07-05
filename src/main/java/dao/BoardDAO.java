package dao;

import java.util.List;

import dto.PageDTO;
import dto.BoardDTO;
import dto.cardPageDTO;

public interface BoardDAO {

	public int count();
	public int count(PageDTO pv);
	public int count(BoardDTO dto);
	public int count(cardPageDTO rpdto); 
	public List<BoardDTO> list(PageDTO pv);
	public List<BoardDTO> list(cardPageDTO rpv);
	public void readCount(int num);
	public BoardDTO content(int num);
	public void reStepCount(BoardDTO dto);
	public void save(BoardDTO dto);
	public BoardDTO updateNum(int num);
	public void update(BoardDTO dto);
	public void delete(int num);
	public String getFile(int num);
	
	public List<BoardDTO> comment(int num);
	public void reStepCountComment(BoardDTO dto);
	public void saveComment(BoardDTO dto);
	public void deleteComment(int num);
	public void updateComment(BoardDTO dto);
}
