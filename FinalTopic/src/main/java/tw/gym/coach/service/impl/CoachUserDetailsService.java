package tw.gym.coach.service.impl;

import java.util.Collections;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.coach.model.CoachBean;
import tw.gym.coach.service.CoachService;

@Service
@Transactional
public class CoachUserDetailsService implements UserDetailsService {

	@Autowired
	private CoachService coachService;

	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {

		CoachBean coach = coachService.findByEmail(email);

			return new User(coach.getCoachEmail(), coach.getCoachPassword(), Collections.emptyList());
		
	}
}
