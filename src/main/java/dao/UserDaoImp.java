package dao;

import org.mybatis.spring.SqlSessionTemplate;

import dto.UserDTO;

public class UserDaoImp implements UserDAO {

	private SqlSessionTemplate sqlSession;

	public UserDaoImp() {

	}

	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 회원가입 체크
	@Override
	public void insertUser(UserDTO dto) {
		System.out.println("dao:" + dto.toString());
		sqlSession.insert("user.join", dto);
	}

	// 아이디 중복 체크
	@Override
	public int idCheck(UserDTO dto) {
		// System.out.println("id:" + id.toString());
		return sqlSession.selectOne("user.idCheck", dto);
	}

	// 닉네임 중복 체크
	@Override
	public int nickCheck(UserDTO dto) {
		// System.out.println("id:" + id.toString());
		return sqlSession.selectOne("user.nickCheck", dto);
	}

	// 로그인
	@Override
	public UserDTO login(UserDTO dto) {
		return sqlSession.selectOne("user.login", dto);
	}

	@Override
	public int idpsCheck(UserDTO dto) {
		return sqlSession.selectOne("user.idpsCheck", dto);
	}

	// 마이페이지
	@Override
	public UserDTO content(UserDTO dto) {
		return sqlSession.selectOne("user.view", dto);
	}
	
	// 회원정보 수정
	@Override
	public void update(UserDTO dto) {
		// System.out.println("nickname3: " + dto.getNickname());
		// System.out.println("daoup:" + sqlSession.update("user.modify", dto));
		sqlSession.update("user.modify", dto);
	}
	
	// 파일 업로드
	@Override
	public String getFile(int num) {
		return sqlSession.selectOne("user.uploadFile", num);
	}
	
	// 회원탈퇴
	@Override
	public void quit(UserDTO dto) {
		sqlSession.selectOne("user.quit", dto);
	}

}
