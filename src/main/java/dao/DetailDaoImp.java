package dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;

import dto.DetailDTO;

public class DetailDaoImp implements DetailDAO {
	private SqlSessionTemplate sqlSession;

	public DetailDaoImp() {

	}

	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public int exist(DetailDTO dto) {
		return sqlSession.selectOne("detail.exist", dto);
	}

	@Override
	public void insertContentid(DetailDTO dto) {
		sqlSession.insert("detail.insertContentid", dto);
		
	}

	@Override
	public void readCount(DetailDTO dto) {
		sqlSession.update("detail.readCount", dto);
		
	}

	@Override
	public void locCount(DetailDTO dto) {
		HashMap<String, String> loc = new HashMap<String, String>();
		loc.put("1","서울");
		loc.put("2","인천");
		loc.put("3","대전");
		loc.put("4","대구");
		loc.put("5","광주");
		loc.put("6","부산");
		loc.put("7","울산");
		loc.put("8","세종");
		loc.put("9","경기");
		loc.put("10","강원");
		loc.put("33","충북");
		loc.put("34","충남");
		loc.put("35","경북");
		loc.put("36","경남");
		loc.put("37","전북");
		loc.put("38","전남");
		loc.put("39","제주");
		dto.setAreacode(loc.get(dto.getAreacode()));
		sqlSession.update("detail.locCount", dto);
		
	}

	@Override
	public void cat3Count(DetailDTO dto) {
		sqlSession.update("detail.cat3Count", dto);
		
	}

	@Override
	public DetailDTO content(DetailDTO dto) {
		return sqlSession.selectOne("detail.content", dto);
	}




}// end class
