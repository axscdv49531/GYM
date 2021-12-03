package tw.gym.member.Service.impl;

import java.util.Collections;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.coach.model.CoachBean;
import tw.gym.coach.service.CoachService;
import tw.gym.member.Model.MemberBean;
import tw.gym.member.Service.MemberService;
import tw.gym.member.validator.UserNotFoundException;

@Service
@Transactional
public class MemberUserDetailsService implements UserDetailsService {

	@Autowired
	private MemberService memberService;
//	
//	@Autowired
//	private CoachService coachService;
//
//	@Override
//	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
//
//		System.out.println(0);
//		Optional<MemberBean> member = memberService.findByEmail(email);
//		System.out.println(1);
//		
//		if (member.isEmpty()) {
//			System.out.println(2);
//			Optional<CoachBean> coach = coachService.findByEmail(email); 
//			System.out.println(6);
//			if (coach.isEmpty()) {
//				System.out.println(3);
//				throw new UserNotFoundException("Can't Find User");			
//			} else {
//				System.out.println(4);
//				return  new User(coach.get().getCoachEmail(), coach.get().getCoachPassword(), Collections.emptyList());
//			}			
//		} else {
//			System.out.println(5);
//			return new User(member.get().getEmail(), member.get().getPassword(), Collections.emptyList());
//		}
//	}
	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		MemberBean member = memberService.findByEmail(email);
		
		return new User(member.getEmail(), member.getPassword(), Collections.emptyList());
	}
}
