package tw.gym.menu.model;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface CostDao extends JpaRepository<Cost, Integer> {
	@Query(value="select * from Cost where costday < ?1 order by costday desc",nativeQuery=true)
	List<Cost> findByCostDay(Date day);

}
