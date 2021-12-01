package tw.gym.member.Service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.member.Dao.PaymentRepository;
import tw.gym.member.Model.PaymentBean;


@Service
@Transactional
public class PaymentServiceImpl implements tw.gym.member.Service.PaymentService {

	private PaymentRepository paymentReposiyory;

	@Autowired
	public PaymentServiceImpl(PaymentRepository paymentReposiyory) {
		this.paymentReposiyory = paymentReposiyory;
	}

	@Override
	public List<PaymentBean> findAllByMember(Integer number) {
		return paymentReposiyory.findAllByMember(number);
	}

	@Override
	public PaymentBean insertByMember(PaymentBean paymentBean, Integer number) {
		return paymentReposiyory.insertByMember(paymentBean, number);
	}

	@Override
	public PaymentBean update(PaymentBean paymentBean) {
		return paymentReposiyory.save(paymentBean);
	}

	@Override
	public void deleteById(Integer no) {
		paymentReposiyory.deleteById(no);
	}

}
