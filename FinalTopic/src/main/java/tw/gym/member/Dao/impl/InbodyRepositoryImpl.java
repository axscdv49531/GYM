package tw.gym.member.Dao.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;

import tw.gym.member.Dao.InbodyRepository;
import tw.gym.member.Dao.InbodyRepositoryCustom;
import tw.gym.member.Dao.MemberRepository;
import tw.gym.member.Model.InbodyBean;
import tw.gym.member.Model.MemberBean;


public class InbodyRepositoryImpl implements InbodyRepositoryCustom {
		
	private InbodyRepository inbodyRepository;
	
	private MemberRepository memberRepository;
	
	@Autowired
	public InbodyRepositoryImpl(@Lazy InbodyRepository inbodyRepository,@Lazy MemberRepository memberRepository) {
        this.inbodyRepository = inbodyRepository;
        this.memberRepository = memberRepository;
    }
	@Override
	public InbodyBean insertByMember(@Lazy InbodyBean inbodyBean, Integer number) {
//		MemberBean memberBean = new MemberBean();
//		memberBean = memberRepository.findById(memberBean.getNumber()).get();
//		memberBean.getInbody().add(inbodyBean);
//		inbodyBean.setMemberBean(memberBean);
//		return inbodyRepository.save(inbodyBean);
		MemberBean member = memberRepository.findById(number).get();
		inbodyBean.setMemberBean(member);
		return inbodyRepository.save(inbodyBean);
	}

}
