package tw.gym.menu.model;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
@Service
@Transactional
public class CostServiceImp implements CostService {

	private CostDao cDao;
	
	
	@Autowired
	public CostServiceImp(CostDao cDao) {
		super();
		this.cDao = cDao;
	}

	@Override
	public void insert(Cost cost) {
		cDao.save(cost);
	}

	@Override
	public void update(Cost cost) {
		cDao.save(cost);

	}

	@Override
	public List<Cost> findByCostDay(Date day) {
		
		return cDao.findByCostDay(day);
	}

}
