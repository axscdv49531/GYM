package tw.gym.member.Dao.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;

import tw.gym.member.Dao.MemberRepository;
import tw.gym.member.Dao.PaymentRepository;
import tw.gym.member.Dao.PaymentRepositoryCustom;
import tw.gym.member.Model.MemberBean;
import tw.gym.member.Model.PaymentBean;

public class PaymentRepositoryImpl implements PaymentRepositoryCustom {

	private PaymentRepository paymentRepository;

	private MemberRepository memberRepository;

	@Autowired
	public PaymentRepositoryImpl(@Lazy PaymentRepository paymentRepository, @Lazy MemberRepository memberRepository) {
		this.paymentRepository = paymentRepository;
		this.memberRepository = memberRepository;
	}

	@Override
	public PaymentBean insertByMember(PaymentBean paymentBean, Integer number) {
		MemberBean member = memberRepository.findById(number).get();
		paymentBean.setMemberBean(member);
		return paymentRepository.save(paymentBean);
	}

}
