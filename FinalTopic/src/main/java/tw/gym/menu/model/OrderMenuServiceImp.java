


package tw.gym.menu.model;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;







@Service
@Transactional
public class OrderMenuServiceImp implements OrderMenuService {
		
	private OrderMenuDao orderMenuDao;
	
	
	
	
	@Autowired
	public OrderMenuServiceImp(OrderMenuDao orderMenuDao) {

		this.orderMenuDao = orderMenuDao;
	}





	@Override
	public List<OrderMenu> findAllByOrderId(int OrderId) {
		// TODO Auto-generated method stub
		return orderMenuDao.findAllByOrderId(OrderId);
	}
	
	
	public OrderMenu insert(OrderMenu orderMenu) {
		return orderMenuDao.save(orderMenu);
	}
	
	public void update(OrderMenu orderMenu) {
		orderMenuDao.save(orderMenu);
	}





	public void deleteById(Integer id) {
		orderMenuDao.deleteById(id);
	}





	@Override
	public void deleteAllInBatch() {
		orderMenuDao.deleteAllInBatch();
		
	}





	@Override
	public OrderMenu findOrderByOrderIdAndName(Integer orderId, Integer id) {
		// TODO Auto-generated method stub
		return orderMenuDao.findOrderByOrderIdAndName(orderId,id);
	}





	@Override
	public OrderMenu findIdByOrderId(Integer orderId) {
		// TODO Auto-generated method stub
		return  orderMenuDao.findIdByOrderId(orderId);
	}





	@Override
	public OrderMenu findAllById(Integer id) {
		// TODO Auto-generated method stub
		return orderMenuDao.findAllById(id);
	}





	@Override
	public List<OrderMenu> findByTime(String date,String date1) {
		// TODO Auto-generated method stub
		return orderMenuDao.findByTime(date,date1);
	}





	@Override
	public List<OrderMenu> findAllByStatuse(String statuse ) {
		// TODO Auto-generated method stub
		return orderMenuDao.findAllByStatuse(statuse);
	}





	@Override
	public OrderMenu findById(Integer id) {
		Optional<OrderMenu>op1 = orderMenuDao.findById(id);
		if(op1.isPresent()) {
			return op1.get();
		}
		return null;
	}







}
