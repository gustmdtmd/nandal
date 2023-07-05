package service;

import dao.DetailDAO;
import dto.DetailDTO;

//@Service
public class DetailServiceImp implements DetailService {

	private DetailDAO detailDao;

	public DetailServiceImp() {

	}

	public void setDetailDao(DetailDAO detailDao) {
		this.detailDao = detailDao;
	}

	@Override
	public int existProcess(DetailDTO dto) {
		return detailDao.exist(dto);
	}

	@Override
	public void insertProcess(DetailDTO dto) {
		detailDao.insertContentid(dto);		
	}

	@Override
	public void readCount(DetailDTO dto) {
		detailDao.readCount(dto);
	}

	@Override
	public void infoCount(DetailDTO dto) {
		detailDao.cat3Count(dto);
		detailDao.locCount(dto);
		detailDao.readCount(dto);
	}

	@Override
	public DetailDTO content(DetailDTO dto) {
		return detailDao.content(dto);
	}



}
