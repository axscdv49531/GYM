package tw.gym.member.Dao;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tw.gym.member.Model.InbodyBean;
import tw.gym.member.Model.MemberBean;


public interface InbodyRepository extends JpaRepository<InbodyBean, Integer>, InbodyRepositoryCustom {
	
	@Query(value="From InbodyBean ib Where ib.memberBean.number = :number")	
	public List<InbodyBean> findAllByMember(Integer number);
	
}
