package service;

import org.springframework.stereotype.Service;

import dto.DetailDTO;

@Service
public interface DetailService {

	public int existProcess(DetailDTO dto);
	public void insertProcess(DetailDTO dto); 	
	public void readCount(DetailDTO dto); 
	public void infoCount(DetailDTO dto); 
	public DetailDTO content(DetailDTO dto);
}
