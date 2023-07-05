package dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import dto.BoardDTO;
import dto.PageDTO;
import dto.cardPageDTO;

public class QnaBoardDaoImp implements BoardDAO {
	private SqlSessionTemplate sqlSession;

	public QnaBoardDaoImp() {

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
		return sqlSession.selectOne("qnaBoard.count", dto);
	}
	
	@Override
	public int count(cardPageDTO rpdto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<BoardDTO> list(PageDTO pv) {
		return sqlSession.selectList("qnaBoard.list", pv);
	}

	@Override
	public List<BoardDTO> list(cardPageDTO rpv) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public void readCount(int num) {
		sqlSession.update("qnaBoard.readCount", num);

	}

	@Override
	public BoardDTO content(int num) {
		return sqlSession.selectOne("qnaBoard.view", num);
	}

	@Override
	public void reStepCount(BoardDTO dto) {
		sqlSession.update("qnaBoard.reStepCount", dto);

	}

	@Override
	public void save(BoardDTO dto) {
		sqlSession.insert("qnaBoard.save", dto);
	}

	@Override
	public BoardDTO updateNum(int num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void update(BoardDTO dto) {
		sqlSession.update("qnaBoard.update", dto);

	}

	@Override
	public void delete(int num) {
		sqlSession.delete("qnaBoard.delete", num);

	}

	@Override
	public String getFile(int num) {
		return sqlSession.selectOne("qnaBoard.uploadFile", num);
	}


	@Override
	public List<BoardDTO> comment(int num) {
		return sqlSession.selectList("qnaComment.list", num);
	}

	@Override
	public void reStepCountComment(BoardDTO dto) {
		sqlSession.update("qnaComment.reStepCount", dto);		
	}

	@Override
	public void saveComment(BoardDTO dto) {
		sqlSession.insert("qnaComment.save", dto);	
	}

	@Override
	public void deleteComment(int num) {
		sqlSession.delete("qnaComment.delete", num);		
	}

	@Override
	public void updateComment(BoardDTO dto) {
		sqlSession.update("qnaComment.update", dto);
		
	}


}// end class
