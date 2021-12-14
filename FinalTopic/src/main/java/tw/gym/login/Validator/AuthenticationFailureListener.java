package tw.gym.login.Validator;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import tw.gym.member.Service.MemberService;

@Component
public class AuthenticationFailureListener implements AuthenticationFailureHandler {

	@Autowired
	private MemberService memberService;
	
	
//	@Override
//	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
//			AuthenticationException exception) throws IOException, ServletException {
//		System.out.println(exception);
//		System.out.println(exception.getMessage());
//		  String email = request.getParameter("username");
//		  System.out.println(email+"1234");
//		  MemberBean memberBean=memberService.findByEmail(email);
//		  Integer number = memberBean.getNumber();
//		  System.out.println(number);
//		  
//		exception.getMessage();
////		Integer number = Integer.valueOf(exception.getMessage().substring(0,4));
////			System.out.print(number);
//			response.sendRedirect("/updatePassword/"+number);
//	}
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
//		HttpSession session=request.getSession();
		if (exception instanceof BadCredentialsException) {
//		     session.setAttribute("errorMsg", "帳號密碼錯誤");
		     response.sendRedirect("/login/Membererror");
		   }else if(exception.getCause() instanceof DisabledException) {	
			String email = request.getParameter("username");
			System.out.println("failure handler: "+ email+"1234");
//			exception.getMessage();
			Integer number = Integer.valueOf(exception.getMessage().substring(0,4));
				System.out.print(number);
				response.sendRedirect("/updatePassword/"+number);
		}
		
		System.out.println(exception);
		System.out.println(exception.getMessage());
		
	}

}
