package tw.gym.commodity.repository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import tw.gym.commodity.model.RuleBase;

@Repository
public interface RuleBaseRepository extends JpaRepository<RuleBase, Integer> {
	
	@Query(value = "FROM RuleBase where startTime <= GETDATE() and endTime >= getdate()")
	List<RuleBase> findActiveRules();
	
	@Query(value = "select c.itemId from Commodity as c inner join RuleBase_Commodity as rc on c.itemId = rc.fk_commodityId inner join (select * from RuleBase where endTime>:time) as rb on rc.fk_ruleBaseId = rb.id", nativeQuery = true)
	List<String> findCommIdWithActiveRule(String time);
	
	@Query(value = "select top(1) ruleId from Discount where ruleId = :id", nativeQuery = true)
	Integer isRuleConsumed (Integer id);	
	
}
