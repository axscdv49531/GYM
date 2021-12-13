//package tw.gym.member.Controller;
//
//import javax.servlet.http.HttpSession;
//
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//
//@Controller
//public class LoginController {
//    @GetMapping("/login/Member")
//    public String MemberLogin( HttpSession session){
//    	session.removeAttribute("errorMsg");
//    	return "LoginMember";
//    }
//	
//	@PostMapping("/login")
//	public String login(String username, String password, HttpServletRequest req) {
//		try {
//			req.login(username, password);
//			return "MemberIndex";
//		} catch (ServletException e) {
//			e.printStackTrace();
//		}
//		return "failed";
//	}
//}