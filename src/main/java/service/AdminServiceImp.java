package service;

import java.util.List;

import dao.Admin_MemberDao;
import dto.Admin_memberDTO;
import dto.PageDTO;

public class AdminServiceImp implements AdminService{
	private Admin_MemberDao Admin_MemberDao;
	
	public AdminServiceImp() {
	
	}
	
	
	public void setAdmin_MemberDao(Admin_MemberDao Admin_MemberDao) {
		this.Admin_MemberDao = Admin_MemberDao;
	}
	
	
	@Override
	public int countProcess() {
		return Admin_MemberDao.count();
	}

	@Override
	public List<Admin_memberDTO> listProcess(PageDTO pv) {
		
		return Admin_MemberDao.memberlist(pv);
	}
	

	
	
	
}//end class
