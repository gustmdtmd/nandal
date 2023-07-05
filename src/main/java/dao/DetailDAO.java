package dao;

import java.util.List;

import dto.PageDTO;
import dto.UserDTO;
import dto.BoardDTO;
import dto.DetailDTO;
import dto.cardPageDTO;

public interface DetailDAO {

	//확인용
	public int exist(DetailDTO dto);
	
	//contentid 추가
	public void insertContentid(DetailDTO dto);
	
	//조회수 추가
	public void readCount(DetailDTO dto);
	
	//지역 선호 저장
	public void locCount(DetailDTO dto);
	
	//관광타입 선호 저장
	public void cat3Count(DetailDTO dto);

	//관광정보 (조회수, 타이틀, 첫번째 이미지)
	public DetailDTO content(DetailDTO dto);
}
