package dto;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;


public class UserDTO {
	private int usercode;
	private String id;
	private String password;
	private String nickname;
	private String img ="img.png";
	private int birth;
	private String gender;
	private String loc;
	private String phone;
	private String email;
	private int usergrade;
	private Date joindate;
	
	//form페이지에서 파일첨부를 받아 처리해주는 멤버변수
	private MultipartFile filename;
	
	//form페이지에서 파일첨부를 받아 처리해주는 멤버변수
	public MultipartFile getFilename() {
		return filename;
	}
	
	public void setFilename(MultipartFile filename) {
		this.filename = filename;
	}
	
	public int getUsercode() {
		return usercode;
	}

	public void setUsercode(int usercode) {
		this.usercode = usercode;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public int getBirth() {
		return birth;
	}

	public void setBirth(int birth) {
		this.birth = birth;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getLoc() {
		return loc;
	}

	public void setLoc(String loc) {
		this.loc = loc;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getUsergrade() {
		return usergrade;
	}

	public void setUsergrade(int usergrade) {
		this.usergrade = usergrade;
	}
	
	public Date getJoindate() {
		return joindate;
	}
	
	public void setJoindate(Date joindate) {
		this.joindate = joindate;
	}

}
