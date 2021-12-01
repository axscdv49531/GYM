package tw.gym.commodity.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.commodity.model.OrderDetailBean;
import tw.gym.commodity.repository.OrderDetailRepository;

@Service
@Transactional
public class OrderDetailService {
	
	@Autowired
	OrderDetailRepository odReps;
	
	public List<OrderDetailBean> findAll(){
		return odReps.findAll();
	}
	
	public OrderDetailBean findByID(Integer id) {
		return odReps.getById(id);
	}
}
