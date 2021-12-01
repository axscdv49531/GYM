package tw.gym.member.Dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tw.gym.member.Model.DepositeBean;

public interface DepositeRepository extends JpaRepository<DepositeBean, Integer>, DepositeRepositoryCustom {

	@Query(value="From DepositeBean db Where db.memberBean.number = :number")	
	public List<DepositeBean> findAllByMember(Integer number);
}
