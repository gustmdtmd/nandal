package service;

import java.io.File;

import dao.UserDAO;
import dto.UserDTO;

//@Service
public class UserServiceImp implements UserService {

	private UserDAO userDao;

	public UserServiceImp() {

	}

	public void setUserDao(UserDAO userDao) {
		this.userDao = userDao;
	}

	// 회원가입
	@Override
	public void insertUser(UserDTO dto) {
		userDao.insertUser(dto);
	}

	// 아이디 중복 체크
	@Override
	public int idCheck(UserDTO dto) {
		return userDao.idCheck(dto);
	}

	// 닉네임 중복 체크
	@Override
	public int nickCheck(UserDTO dto) {
		return userDao.nickCheck(dto);
	}

	// 로그인
	@Override
	public UserDTO login(UserDTO dto) {
		return userDao.login(dto);
	}

	@Override
	public int idpsCheck(UserDTO dto) {
		return userDao.idpsCheck(dto);
	}

	// 마이페이지
	@Override
	public UserDTO contentProcess(UserDTO dto) {
		return userDao.content(dto);
	}

	// 마이페이지 - 정보수정
	public UserDTO updateSelectProcess(UserDTO dto) {
		return userDao.content(dto);
	}

	// 파일 수정
	@Override
	public void updateProcess(UserDTO dto, String urlpath) {
		String filename = dto.getImg();
		
		// 수정한 파일이 있으면
//		if (filename != null) {
//			String path = userDao.getFile(dto.getUsercode());
//			// 기존 첨부파일이 있으면
//			if (path != null) {
//				File file = new File(urlpath, path);
//				file.delete();
//			}
//			
//		}
		System.out.println("service: " + dto.getImg());
		userDao.update(dto);
	}

	// 회원탈퇴
	@Override
	public void quit(UserDTO dto) {
		userDao.quit(dto);
	}

}
