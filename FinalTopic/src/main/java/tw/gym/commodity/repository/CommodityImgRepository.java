package tw.gym.commodity.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import tw.gym.commodity.model.CommodityImgBean;

@Repository
public interface CommodityImgRepository extends JpaRepository<CommodityImgBean, Integer> {
	
	@Query(value = "from CommodityImgBean where fk_item_id = :cid")
	List<CommodityImgBean> findAllByItemId(Integer cid);
}
