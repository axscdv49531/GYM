package tw.gym.commodity.repository;


import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import tw.gym.commodity.model.ItemTypeBean;

@Repository
public interface ItemTypeRepository extends JpaRepository<ItemTypeBean, Integer> {
	
	List<ItemTypeBean> findAllByOrderByGroups();
	
	@Query(value = "select top(1) itemtypeId from commodity where itemtypeId = :id", nativeQuery = true)
	Integer isUsed (Integer id);
	
	@Query(value = "select t.groups, (sum(od.subTotal)/1000) as sale, sum(od.orderQty) as qty, round(sum(od.subTotal)/(select sum(subTotal)from OrderDetail as od "
			+ "left join Orders as o on o.orderId = od.fk_order_id where o.status =2 and year(o.pickUpDate) = :year and MONTH(o.pickUpDate) = :month)*100, 2) as pct "
			+ "from itemType as t left join Commodity as c on t.typeId = c.itemTypeId left join OrderDetail as od on c.itemId = od.itemId "
			+ "left join Orders as o on o.orderId = od.fk_order_id where o.status =2 and year(o.pickUpDate) = :year and MONTH(o.pickUpDate) = :month "
			+ "group by groups", nativeQuery = true)
	List<Map<String, Object>> getPctOfEachType(Integer year, Integer month);
	
	@Query(value="select DISTINCT concat(year(pickUpDate), '-',month(pickUpDate)) from Orders where status = 2", nativeQuery = true)
	List<String> getChartMonth();
	
}
