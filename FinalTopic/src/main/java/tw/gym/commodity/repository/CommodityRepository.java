package tw.gym.commodity.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import tw.gym.commodity.model.CommodityBean;

@Repository
public interface CommodityRepository extends JpaRepository<CommodityBean, Integer> {
	
	@Query(value = "from CommodityBean where onSale =1 and itemName+itemDesc like concat('%',?1,'%')")
	public List<CommodityBean> findByOnSaleAndKeywords(String keyword);
	
	@Query(value = "select distinct vendorName from CommodityBean")
	public List<String> findAllVendors();
	
}
