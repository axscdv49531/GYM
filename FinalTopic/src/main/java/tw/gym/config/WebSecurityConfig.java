package tw.gym.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import tw.gym.login.Service.MemberUserDetailsService;
import tw.gym.login.Validator.CustomAuthenticationSuccessHandler;

@EnableWebSecurity
public class WebSecurityConfig {

	
	@Configuration
	@Order(1)
	public static class MemberLoginSecurity extends WebSecurityConfigurerAdapter {

		@Autowired
		private MemberUserDetailsService memberUserDetailsService;

		@Autowired
		private CustomAuthenticationSuccessHandler memberCustomAuthenticationSuccessHandler;



		@Override
		protected void configure(AuthenticationManagerBuilder auth) throws Exception {
			auth.userDetailsService(memberUserDetailsService).passwordEncoder(new BCryptPasswordEncoder());
		}

		@Override
		protected void configure(HttpSecurity http) throws Exception {
			http
			//.antMatcher("/member/**")
				.authorizeRequests()
				.antMatchers(HttpMethod.GET, "/insertMember/**").authenticated()
				.antMatchers(HttpMethod.GET, "/findAllMember/**").authenticated()
				.antMatchers(HttpMethod.GET).permitAll()
				.antMatchers(HttpMethod.POST, "/insertMember/**").authenticated()
				.antMatchers(HttpMethod.POST, "/findAllMember/**").authenticated()
				.antMatchers(HttpMethod.POST).permitAll()
				.anyRequest()
				.authenticated()
				.and()
				.rememberMe()
				.tokenValiditySeconds(86400)
				.key("rememberMe-key")
				.and()
				.csrf().disable()
				.formLogin().loginPage("/login/Member")
				.defaultSuccessUrl("/login/MemberSuccess")			
				.successHandler(memberCustomAuthenticationSuccessHandler);

		}
	}

//	@Configuration
//	@Order(2)
//	public static class CoachLoginSecurity extends WebSecurityConfigurerAdapter {
//		
//		@Autowired
//		private CoachUserDetailsService coachUserDetailsService;
//		
//		@Autowired
//		private CoachCustomAuthenticationSuccessHandler coachCustomAuthenticationSuccessHandler;
//
//		@Override
//		protected void configure(AuthenticationManagerBuilder auth) throws Exception {
//			auth.userDetailsService(coachUserDetailsService).passwordEncoder(new BCryptPasswordEncoder());
//		}
//
//		@Override
//		protected void configure(HttpSecurity http) throws Exception {
//			http.authorizeRequests()
//			.antMatchers(HttpMethod.GET, "/login/Coach").authenticated()
//			.antMatchers(HttpMethod.GET).permitAll()
//			.antMatchers(HttpMethod.POST, "/login/Coach").authenticated()
//			.antMatchers(HttpMethod.POST).permitAll()
//			.anyRequest()
//			.authenticated().and().rememberMe().tokenValiditySeconds(86400).key("rememberMe-key")
//			.and()
//			.formLogin()
//	        .loginProcessingUrl("/login/Coach")
//			.defaultSuccessUrl("/login/CoachSuccess")
//			.successHandler(coachCustomAuthenticationSuccessHandler)
//			.and().csrf().disable();
//		}
//
//		@Override
//		public void configure(WebSecurity web) throws Exception {
//			// TODO Auto-generated method stub
//			super.configure(web);
//		}
//	}

}