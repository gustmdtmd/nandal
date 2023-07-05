package dao;

import java.util.List;

import dto.Admin_memberDTO;
import dto.PageDTO;
import dto.BoardDTO;

public interface Admin_MemberDao {
	
	public int count();
	public List<Admin_memberDTO> memberlist(PageDTO pv);
	public void update(BoardDTO dto);
	public void delete(int num);
	public String getFile(int num);
}
