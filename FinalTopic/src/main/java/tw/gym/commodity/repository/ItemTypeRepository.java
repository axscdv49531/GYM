package tw.gym.commodity.repository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import tw.gym.commodity.model.ItemTypeBean;

@Repository
public interface ItemTypeRepository extends JpaRepository<ItemTypeBean, Integer> {
	
	List<ItemTypeBean> findAllByOrderByGroups();
}
