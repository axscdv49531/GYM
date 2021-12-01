package tw.gym.member.Dao.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;

import tw.gym.member.Dao.MemberRepository;
import tw.gym.member.Dao.MemberRepositoryCustom;
import tw.gym.member.Model.MemberBean;

public class MemberRepositoryImpl implements MemberRepositoryCustom {

	private MemberRepository memberRepository;
		
	@Autowired
	public MemberRepositoryImpl(@Lazy MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}




//	@Override
//	public MemberBean checkById(MemberBean memberBean, String id) {
//		List<MemberBean> member = memberRepository.findAll();
//		try {
//			if(memberBean )
//			
//		}catch(Exception e){
//			
//		}
//		return null;
//	}

}
