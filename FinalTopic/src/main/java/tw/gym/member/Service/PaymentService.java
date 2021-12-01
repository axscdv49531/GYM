package tw.gym.member.Service;

import java.util.List;

import tw.gym.member.Model.PaymentBean;

public interface PaymentService {
	
	public List<PaymentBean> findAllByMember(Integer number);

	public PaymentBean insertByMember(PaymentBean paymentBean, Integer number);

	public PaymentBean update(PaymentBean paymentBean);

	public void deleteById(Integer no);
}
