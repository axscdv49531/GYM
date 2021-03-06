package tw.gym.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import tw.gym.login.Service.LoginUserDetailsService;
import tw.gym.login.Validator.AuthenticationFailureListener;
import tw.gym.login.Validator.CustomAuthenticationSuccessHandler;

@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	private LoginUserDetailsService memberUserDetailsService;

	@Autowired
	private CustomAuthenticationSuccessHandler customAuthenticationSuccessHandler;
	
	@Autowired
	private AuthenticationFailureListener authenticationFailureListener;

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(memberUserDetailsService).passwordEncoder(new BCryptPasswordEncoder());
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
			.antMatchers(HttpMethod.GET, "/insertMember/**").authenticated()
			.antMatchers(HttpMethod.GET, "/findAllMember/**").authenticated()
			.antMatchers(HttpMethod.GET).permitAll()
			.antMatchers(HttpMethod.POST, "/insertMember/**").authenticated()
			.antMatchers(HttpMethod.POST, "/findAllMember/**").authenticated()
			.antMatchers(HttpMethod.POST).permitAll()
			.antMatchers(HttpMethod.DELETE).permitAll()
			.antMatchers(HttpMethod.PUT).permitAll()
			.anyRequest().authenticated()
			.and()
			.rememberMe()
			.tokenValiditySeconds(86400)
			.key("rememberMe-key")
			.and().csrf().disable()
			.formLogin().loginPage("/login/Member")
			.successHandler(customAuthenticationSuccessHandler)
			.failureHandler(authenticationFailureListener);
		
	}

	@Override
	public void configure(WebSecurity web) throws Exception {
		// TODO Auto-generated method stub
		super.configure(web);
	}
}
