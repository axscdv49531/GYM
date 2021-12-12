package tw.gym.commodity.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import tw.gym.commodity.model.OrdersBean;

@Repository
public interface OrdersRepository extends JpaRepository<OrdersBean, Integer> {
	
	@Query(value ="from OrdersBean where memberId = :mid order by orderDate desc, totalAmt desc")
	List<OrdersBean> findByMemberId(Integer mid);
		
}
