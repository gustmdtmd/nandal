package service;

import java.util.List;

import dto.Admin_memberDTO;
import dto.PageDTO;

public interface AdminService {
	public int countProcess();
	public List<Admin_memberDTO> listProcess(PageDTO pv);

}
