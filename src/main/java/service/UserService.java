package service;

import org.springframework.stereotype.Service;

import dto.UserDTO;

@Service
public interface UserService {

	// 회원가입
	public void insertUser(UserDTO dto);

	// 아이디 중복 체크
	public int idCheck(UserDTO dto);

	// 닉네임 중복 체크
	public int nickCheck(UserDTO dto);

	// 로그인
	public UserDTO login(UserDTO dto);

	public int idpsCheck(UserDTO dto);

	// 마이페이지
	public UserDTO contentProcess(UserDTO dto);

	// 마이페이지 - 정보수정
	public UserDTO updateSelectProcess(UserDTO dto);

	public void updateProcess(UserDTO dto, String urlpath);


	// 회원탈퇴
	public void quit(UserDTO dto);
}
