package dao;

import java.util.List;

import dto.UserDTO;

public interface UserDAO {

	// 회원가입 DAO
	public void insertUser(UserDTO dto);

	// 아이디 중복체크
	public int idCheck(UserDTO dto);

	// 아이디 중복체크
	public int nickCheck(UserDTO dto);

	// 로그인
	public UserDTO login(UserDTO dto);

	public int idpsCheck(UserDTO dto);

	// 마이페이지
	public UserDTO content(UserDTO dto);

	public void update(UserDTO dto);

	// 파일업로드
	public String getFile(int num);

	// 회원탈퇴
	// public int quit(UserDTO dto);
	public void quit(UserDTO dto);
}
