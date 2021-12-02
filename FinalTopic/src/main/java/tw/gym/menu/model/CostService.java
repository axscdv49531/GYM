package tw.gym.menu.model;

import java.util.Date;
import java.util.List;

public interface CostService {
	
	public	void insert(Cost cost);
	public void update(Cost cost);
	public List<Cost> findByCostDay(Date day);

}
