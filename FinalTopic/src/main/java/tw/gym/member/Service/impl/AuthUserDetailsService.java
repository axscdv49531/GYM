package tw.gym.member.Service.impl;

import java.util.Collections;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.member.Model.MemberBean;
import tw.gym.member.Service.MemberService;

@Service
@Transactional
public class AuthUserDetailsService implements UserDetailsService {
	
	@Autowired
	private MemberService memberService;

	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        // System.out.println(email);
		MemberBean member = memberService.findByEmail(email);
		return new User(member.getEmail(), member.getPassword(), Collections.emptyList());
	}
}
