package dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import dto.BoardDTO;
import dto.PageDTO;
import dto.cardPageDTO;

public class ReviewBoardDaoImp implements BoardDAO {
	private SqlSessionTemplate sqlSession;

	public ReviewBoardDaoImp() {

	}

	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public int count() {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public int count(PageDTO pv) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int count(BoardDTO dto) {
		return sqlSession.selectOne("reviewBoard.count", dto);
	}
	
	@Override
	public int count(cardPageDTO rpdto) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public List<BoardDTO> list(PageDTO pv) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List<BoardDTO> list(cardPageDTO rpv) {
		System.out.println("cardDTO list");
		return sqlSession.selectList("reviewBoard.list", rpv);
	}
	
	@Override
	public void readCount(int num) {
		sqlSession.update("reviewBoard.readCount", num);

	}

	@Override
	public BoardDTO content(int num) {
		return sqlSession.selectOne("reviewBoard.view", num);
	}

	@Override
	public void reStepCount(BoardDTO dto) {
		sqlSession.update("reviewBoard.reStepCount", dto);
	}

	@Override
	public void save(BoardDTO dto) {
		sqlSession.insert("reviewBoard.save", dto);
	}

	@Override
	public BoardDTO updateNum(int num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void update(BoardDTO dto) {
		sqlSession.update("reviewBoard.update", dto);
	}

	@Override
	public void delete(int num) {
		sqlSession.delete("reviewBoard.delete", num);
	}

	@Override
	public String getFile(int num) {
		return sqlSession.selectOne("reviewBoard.uploadFile", num);
	}


	@Override
	public List<BoardDTO> comment(int num) {
		return sqlSession.selectList("reviewComment.list", num);
	}

	@Override
	public void reStepCountComment(BoardDTO dto) {
		sqlSession.update("reviewComment.reStepCount", dto);
	}

	@Override
	public void saveComment(BoardDTO dto) {
		sqlSession.insert("reviewComment.save", dto);	
	}

	@Override
	public void deleteComment(int num) {
		sqlSession.delete("reviewComment.delete", num);	
	}

	@Override
	public void updateComment(BoardDTO dto) {
		sqlSession.update("reviewComment.update", dto);
		
	}


}// end class
