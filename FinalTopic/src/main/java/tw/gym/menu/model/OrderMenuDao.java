package tw.gym.menu.model;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


public interface OrderMenuDao extends JpaRepository<OrderMenu, Integer> {
	
	@Query(value="Select * From OrderMenu where orderId = ?1",nativeQuery=true)
	public List<OrderMenu> findAllByOrderId(int orderId);
	@Query(value="Select * From OrderMenu where orderId = ?1 and fk_menu_id=?2",nativeQuery=true)
	public OrderMenu findOrderByOrderIdAndName(Integer orderId, Integer id);
	
	@Query(value="Select id From OrderMenu where orderId = ?1",nativeQuery=true)
	public OrderMenu findIdByOrderId(Integer orderId);
	
	@Query(value="Select * From OrderMenu where id = ?1",nativeQuery=true)
	public OrderMenu findAllById(Integer id);
	
	@Query(value="Select * from OrderMenu where ordertime >= ?1 and ordertime<?2",nativeQuery=true)
	public List<OrderMenu> findByTime(String date,String date1);
	
	@Query(value="Select * from OrderMenu where  statuse = ?1 ",nativeQuery=true)
	public List<OrderMenu> findAllByStatuse(String statuse);
	
	

	


}
