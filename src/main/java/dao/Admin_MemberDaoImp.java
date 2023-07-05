package dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import dto.Admin_memberDTO;
import dto.PageDTO;
import dto.BoardDTO;

public class Admin_MemberDaoImp implements Admin_MemberDao{
	private SqlSessionTemplate sqlSession;
	
	public Admin_MemberDaoImp() {
	
	}
	
	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public int count() {
		return sqlSession.selectOne("admin.count");
	}
	
	@Override
	public List<Admin_memberDTO> memberlist(PageDTO pv) {
		return sqlSession.selectList("admin.memberlist", pv);
	}


	@Override
	public void update(BoardDTO dto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String getFile(int num) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}//end class
