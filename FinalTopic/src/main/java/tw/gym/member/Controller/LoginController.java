//package tw.gym.member.Controller;
//
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServletRequest;
//
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RestController;
//
//@RestController
//public class LoginController {
//    @GetMapping(path ="/login")
//    public String MemberLogin(){
//    	return "/LoginMember.jsp";
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