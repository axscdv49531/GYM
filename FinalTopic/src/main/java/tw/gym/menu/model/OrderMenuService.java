package tw.gym.menu.model;

import java.util.Date;
import java.util.List;

public interface OrderMenuService {
	public List<OrderMenu> findAllByOrderId(int OrderId);
	public OrderMenu insert(OrderMenu OrderMenu);
	public void update(OrderMenu orderMenu);
	public void deleteById(Integer id);
	public void deleteAllInBatch();
	public OrderMenu findOrderByOrderIdAndName(Integer orderId,Integer id);
	public OrderMenu findIdByOrderId(Integer orderId);
	public OrderMenu findAllById(Integer id) ;
	public List<OrderMenu> findByTime(String date,String date1);
	public List<OrderMenu>findAllByStatuseAndOrderId(Integer id,String statuse);
	public OrderMenu findById(Integer id);

	

}
