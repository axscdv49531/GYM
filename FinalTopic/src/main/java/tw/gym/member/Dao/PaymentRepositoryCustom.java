package tw.gym.member.Dao;

import tw.gym.member.Model.PaymentBean;

public interface PaymentRepositoryCustom {
	
	public PaymentBean insertByMember(PaymentBean paymentBean, Integer number);
}
