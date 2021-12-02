//package tw.gym.member.Service.impl;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.context.SecurityContext;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.security.core.userdetails.UserDetails;
//
//import tw.gym.member.Dao.MemberRepository;
//import tw.gym.member.Model.MemberBean;
//import tw.gym.member.Service.UserContext;
//
//public class SpringSecurityUserContext implements UserContext {
//	
//	@Autowired
//	private MemberRepository memberRepository;
//	
//	@Autowired
//	private AuthUserDetailsService userDetailService;
//	@Override
//	public MemberBean getCurrentUser() {
//		SecurityContext context=SecurityContextHolder.getContext(); //從ContextHolder中取得SecurityContext物件
//		Authentication auth=context.getAuthentication(); //從SecurityContext物件取得Authentication物件
//		//檢查是否有使用者登入
//		if(auth== null){
//			return null;
//		}
//		//取得通過驗證的使用者名稱
//		String userEmail=auth.getName(); 
//		return memberRepository.findByEmail(userEmail);
//	}
//
//	@Override
//	public void setCurrentUser(MemberBean user) {
//		//透過Service取得UserDetails
//		UserDetails userDetails=userDetailService.loadUserByUsername(user.getEmail());
//		//將使用者放入Authentication物件，代表已通過驗證
//		Authentication auth=new UsernamePasswordAuthenticationToken(userDetails, 
//				user.getPassword(), userDetails.getAuthorities());
//		//將Authentication物件放入SecurityContext存放
//		SecurityContextHolder.getContext().setAuthentication(auth); 
//
//	}
//
//}
