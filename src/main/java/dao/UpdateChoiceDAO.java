package dao;

import org.mybatis.spring.SqlSessionTemplate;

import dto.DetailDTO;

public class UpdateChoiceDAO {

	private SqlSessionTemplate sqlSession;
	
	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int exist(DetailDTO dto) {
		return sqlSession.selectOne("updateChoice.exist");
	}
	
	public void readCount(int contentid) {
		sqlSession.update("updateChoice.readCount", contentid);

	}
	
	public void insertChoice(DetailDTO dto) {
		sqlSession.insert("updateChoice.insertcat3Count", dto);
		sqlSession.insert("updateChoice.insertareacodeCount", dto);
	}
	

}
