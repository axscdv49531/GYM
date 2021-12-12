package tw.gym.commodity.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import tw.gym.commodity.model.CommodityBean;

@Repository
public interface CommodityRepository extends JpaRepository<CommodityBean, Integer> {
	
	@Query(value = " select c.* from Commodity as c left join itemType as t on itemTypeId = typeId where onSale =1 and itemName+itemDesc+typeName+groups like concat('%',?1,'%')", nativeQuery = true)
	public List<CommodityBean> findByOnSaleAndKeywords(String keyword);
	
	@Query(value = "select distinct vendorName from CommodityBean")
	public List<String> findAllVendors();
	
	@Query(value = "select * from commodity where not exists(select * from RuleBase_Commodity)", nativeQuery = true)
	public List<CommodityBean> findAllWithoutDiscountRules();
	
	@Query(value = "select top(1) itemId from OrderDetail where itemId = :id", nativeQuery = true)
	Integer isComsumed (Integer id);
	
	
}
