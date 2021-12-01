package tw.gym.commodity.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import tw.gym.commodity.model.OrderDetailBean;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetailBean, Integer> {
	
	public boolean existsOrderDetailByItemId(Integer itemId);

}
