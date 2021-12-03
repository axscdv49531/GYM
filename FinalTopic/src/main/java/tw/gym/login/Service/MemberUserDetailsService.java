package tw.gym.login.Service;

import java.util.Collection;
import java.util.Collections;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.coach.model.CoachBean;
import tw.gym.coach.service.CoachService;
import tw.gym.login.Validator.UserNotFoundException;
import tw.gym.login.util.UserAuthorityUtils;
import tw.gym.member.Model.MemberBean;
import tw.gym.member.Service.MemberService;

@Service
@Transactional
public class MemberUserDetailsService implements UserDetailsService {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CoachService coachService;

	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {

		Optional<MemberBean> member = memberService.findEmail(email);
		
		if (member.isEmpty()) {
			Optional<CoachBean> coach = coachService.findByEmail(email); 
			if (coach.isEmpty()) {
				throw new UserNotFoundException("Can't Find User");			
			} else {
//				Collection<? extends GrantedAuthority> authorities= 
//		                UserAuthorityUtils.createAuthorities(coach.get());
				System.out.println(3);
				return  new User(coach.get().getCoachEmail(), coach.get().getCoachPassword(), Collections.emptyList());
			}			
		} else {
//			Collection<? extends GrantedAuthority> authorities= 
//	                UserAuthorityUtils.createAuthorities(member.get());
			System.out.println(4);
			return new User(member.get().getEmail(), member.get().getPassword(), Collections.emptyList());
		}
	}
//	@Override
//	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
//		MemberBean member = memberService.findByEmail(email);
//		if (member == null) {
//			CoachBean coach = coachService.findByEmail(email);
//			Collection<? extends GrantedAuthority> authorities= 
//	                UserAuthorityUtils.createAuthorities(coach);
//			return new User(coach.getCoachEmail(), coach.getCoachPassword(), authorities);
//		}
//		Collection<? extends GrantedAuthority> authorities= 
//                UserAuthorityUtils.createAuthorities(member);
//                //UserAuthorityUtils是helper class
//		return new User(member.getEmail(), member.getPassword(), authorities);
//	}
	
}
