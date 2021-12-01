package tw.gym.member.Dao;

import tw.gym.member.Model.DepositeBean;

public interface DepositeRepositoryCustom {
	
	public DepositeBean insertMemberNumber(DepositeBean depositeBean, Integer number);
}
