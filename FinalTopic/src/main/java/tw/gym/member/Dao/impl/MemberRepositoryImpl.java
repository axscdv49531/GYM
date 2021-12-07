package tw.gym.member.Dao.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import tw.gym.member.Dao.MemberRepository;
import tw.gym.member.Dao.MemberRepositoryCustom;
import tw.gym.member.Model.MemberBean;

public class MemberRepositoryImpl implements MemberRepositoryCustom {

	private MemberRepository memberRepository;
	
	@PersistenceContext
	private EntityManager entityManager;
		
	@Autowired
	public MemberRepositoryImpl(@Lazy MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}
	@Override
	public void updatePwd(MemberBean memberBean) {
		// TODO Auto-generated method stub
		PasswordEncoder passwordEncoder= new BCryptPasswordEncoder(); //密碼加密 
		memberBean.setPassword(passwordEncoder.encode(memberBean.getPassword())); //以加密後的密碼覆蓋原輸入的密碼
		entityManager.persist(memberBean); 
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
