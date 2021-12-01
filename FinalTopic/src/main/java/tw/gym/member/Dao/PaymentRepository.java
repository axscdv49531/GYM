package tw.gym.member.Dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tw.gym.member.Model.PaymentBean;

public interface PaymentRepository extends JpaRepository<PaymentBean, Integer>, PaymentRepositoryCustom {
	
	@Query(value="From PaymentBean pb Where pb.memberBean.number = :number")	
	public List<PaymentBean> findAllByMember(Integer number);
}
