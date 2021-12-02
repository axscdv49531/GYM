//package tw.gym.member.Controller;
//
//import org.springframework.security.access.prepost.PreAuthorize;
//import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RestController;
//
//import tw.gym.member.Model.MemberBean;
//
//@RestController
////開啟驗證
//@EnableGlobalMethodSecurity(prePostEnabled = true)
//public class DemoController {
//
//	// 指定該接口只能被ADMIN角色的用戶訪問，ROLE_這個前綴是固定要寫的
//	@PreAuthorize("hasRole(‘ROLE_ADMIN‘)")
//	@GetMapping("/insertMember")
//	public String insertMember(Model m) {
//		MemberBean memberBean = new MemberBean();
//		m.addAttribute("memberBean", memberBean);
//		return "member/MemberForm";
//	}
//	
//}