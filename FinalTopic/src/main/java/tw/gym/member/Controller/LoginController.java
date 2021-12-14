package tw.gym.member.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {
	@GetMapping("/login/Membererror")
	public String MemberLogin(Model m) {
		String errorMsg = "帳號或密碼錯誤!";
		m.addAttribute("errorMsg", errorMsg);
		return "LoginMember";
	}
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
}