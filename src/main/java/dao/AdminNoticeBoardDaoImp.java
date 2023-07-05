package dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import dto.BoardDTO;
import dto.PageDTO;
import dto.cardPageDTO;

public class AdminNoticeBoardDaoImp implements BoardDAO {
	private SqlSessionTemplate sqlSession;

	public AdminNoticeBoardDaoImp() {

	}

	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public int count() {
		return sqlSession.selectOne("noticeBoard.count");
	}

	@Override
	public List<BoardDTO> list(PageDTO pv) {
		return sqlSession.selectList("noticeBoard.list", pv);
	}

	@Override
	public void readCount(int num) {
		sqlSession.update("noticeBoard.readCount", num);

	}

	@Override
	public BoardDTO content(int num) {
		return sqlSession.selectOne("noticeBoard.view", num);
	}

	@Override
	public void reStepCount(BoardDTO dto) {
		sqlSession.update("noticeBoard.reStepCount", dto);

	}

	@Override
	public void save(BoardDTO dto) {
		sqlSession.insert("noticeBoard.save", dto);
	}

	@Override
	public BoardDTO updateNum(int num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void update(BoardDTO dto) {
		sqlSession.update("noticeBoard.update", dto);

	}

	@Override
	public void delete(int num) {
		sqlSession.delete("noticeBoard.delete", num);

	}

	@Override
	public String getFile(int num) {
		return sqlSession.selectOne("noticeBoard.uploadFile", num);
	}

	@Override
	public int count(BoardDTO dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<BoardDTO> list(cardPageDTO rpv) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public List<BoardDTO> comment(int num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int count(PageDTO pv) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int count(cardPageDTO rpdto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void reStepCountComment(BoardDTO dto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void saveComment(BoardDTO dto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteComment(int num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateComment(BoardDTO dto) {
		// TODO Auto-generated method stub
		
	}

}// end class
