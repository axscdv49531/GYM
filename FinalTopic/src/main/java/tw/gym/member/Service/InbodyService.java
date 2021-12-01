package tw.gym.member.Service;

import java.util.List;

import tw.gym.member.Model.InbodyBean;

public interface InbodyService {
	
	public List<InbodyBean> findAllByMember(Integer number);
	
	public InbodyBean insertByMember(InbodyBean inbodyBean, Integer number);
	
	public InbodyBean update(InbodyBean inbodyBean);
	
	public void deleteById(Integer no);
}
