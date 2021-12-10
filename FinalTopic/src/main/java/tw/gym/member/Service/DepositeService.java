package tw.gym.member.Service;

import java.util.List;
import java.util.Optional;

import tw.gym.member.Model.DepositeBean;

public interface DepositeService {
	
	public DepositeBean insertMemberNumber(DepositeBean depositeBean, Integer number);
	
	public DepositeBean update(DepositeBean depositeBean);
	
	public List<DepositeBean> findAll();
	
	public List<DepositeBean> findAllByMember(Integer number);

	public DepositeBean findByMemberNumeber(Integer number);

	public Optional<DepositeBean> findById(Integer id);
	
}
