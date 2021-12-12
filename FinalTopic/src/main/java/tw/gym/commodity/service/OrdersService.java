package tw.gym.commodity.service;

import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.persistence.EntityNotFoundException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.commodity.model.CommodityBean;
import tw.gym.commodity.model.OrderDetailBean;
import tw.gym.commodity.model.OrdersBean;
import tw.gym.commodity.repository.OrdersRepository;

@Service
@Transactional
public class OrdersService {
	
	@Autowired
	OrdersRepository odRepo;
	
	@Autowired
	CommodityService commService;
	
	public OrdersBean insert(OrdersBean ob) {
		return odRepo.save(ob);
	}
	
	public void deleteById(Integer id) {
		odRepo.deleteById(id);
	}
	
	public List<OrdersBean> findAll(){
		return odRepo.findAll();
	}
	
	public OrdersBean findByID(Integer id) throws EntityNotFoundException{
		return odRepo.getById(id);
	}
	
	public List<OrdersBean> findAllByExample(Example<OrdersBean> example, Sort sort){
		return odRepo.findAll(example, sort);
	}
	
	public List<OrdersBean> findByMemberId(Integer id){
		return odRepo.findByMemberId(id);
	}

	public void closeOrder(OrdersBean bean) {
		Set<OrderDetailBean> set = bean.getOrderDetails();
		for(OrderDetailBean odb :set) {
			CommodityBean comm = odb.getCommodity();
			comm.setItemStock(comm.getItemStock() - odb.getOrderQty());		
			commService.insert(comm, false);
		}		
		bean.setPickUpDate(new Date());
		bean.setStatus(2);
		odRepo.save(bean);
	}
}
