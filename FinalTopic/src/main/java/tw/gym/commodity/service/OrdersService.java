package tw.gym.commodity.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.commodity.model.OrdersBean;
import tw.gym.commodity.repository.OrdersRepository;

@Service
@Transactional
public class OrdersService {
	
	@Autowired
	OrdersRepository oReps;
	
	public OrdersBean insert(OrdersBean ob) {
		return oReps.save(ob);
	}
	
	public void deleteById(Integer id) {
		oReps.deleteById(id);
	}
	
	public List<OrdersBean> findAll(){
		return oReps.findAll();
	}
	
	public OrdersBean findByID(Integer id) {
		return oReps.getById(id);
	}
	
	public List<OrdersBean> findOrderHistory(String mid) {
		return oReps.findByMemberId(mid);
	}
	
}
