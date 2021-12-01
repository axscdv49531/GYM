package tw.gym.member.Dao.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;

import tw.gym.member.Dao.DepositeRepository;
import tw.gym.member.Dao.DepositeRepositoryCustom;
import tw.gym.member.Dao.InbodyRepository;
import tw.gym.member.Dao.MemberRepository;
import tw.gym.member.Model.DepositeBean;
import tw.gym.member.Model.MemberBean;

public class DepositeRepositoryImpl implements DepositeRepositoryCustom{

	private DepositeRepository depositeRepository;
	
	private MemberRepository memberRepository;
	
	@Autowired
	public DepositeRepositoryImpl(@Lazy DepositeRepository depositeRepository,@Lazy MemberRepository memberRepository) {
        this.depositeRepository = depositeRepository;
        this.memberRepository = memberRepository;
    }
	
	@Override
	public DepositeBean insertMemberNumber(DepositeBean depositeBean, Integer number) {
		
		MemberBean member = memberRepository.findById(number).get();
		depositeBean.setMemberBean(member);
		return depositeRepository.save(depositeBean);
	}

}
