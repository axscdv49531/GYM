package tw.gym.menu.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface EvaluationDao extends JpaRepository<Evaluation, Integer> {
	@Query(value="select * from Evaluation where menuname =?1",nativeQuery=true)
	List<Evaluation> findByMenuName(String menuName);
	
	@Query(value="select * from Evaluation where fk_member_id =?1 ",nativeQuery=true)
	List<Evaluation> findAllByMemberId(Integer id);

}
