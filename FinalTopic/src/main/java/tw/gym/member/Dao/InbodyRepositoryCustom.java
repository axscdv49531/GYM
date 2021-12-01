package tw.gym.member.Dao;

import tw.gym.member.Model.InbodyBean;


public interface InbodyRepositoryCustom {
	
	public InbodyBean insertByMember(InbodyBean inbodyBean, Integer number);

}
