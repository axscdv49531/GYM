package tw.gym.member.Controller;

import java.sql.Date;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.context.request.WebRequest;

import tw.gym.member.Model.MemberBean;
import tw.gym.member.Service.MemberService;
import tw.gym.member.validator.MemberValidator;

@Controller
//@RequestMapping(path = "/GymProject")
//@SessionAttributes(names = {"totalPages", "totalElements"})
public class MemberController {

	private MemberService memberService;

	@Autowired
	public MemberController(MemberService memberService) {
		this.memberService = memberService;
	}

	// 輸入會員資料
	@GetMapping(path = "/insertMember")
	public String insertMember(Model m) {
		MemberBean memberBean = new MemberBean();
		m.addAttribute("memberBean", memberBean);
		return "member/MemberForm";
	}

	@PostMapping(path = "/insertMember")
	public String insert(Model m, @ModelAttribute("memberBean") MemberBean memberBean, BindingResult bindingResult) {
		MemberValidator memberValidator = new MemberValidator();
		memberValidator.validate(memberBean, bindingResult);

		if (bindingResult.hasErrors()) {
			System.out.println(bindingResult.getAllErrors());
			return "member/MemberForm";
		}
//		if (memberBean != null) {
//			if(memberBean.getId().equals(memberService. == true);
//			bindingResult.rejectValue("memberId", "", "帳號已存在，請重新輸入");
//			return "MemberForm";
//		}
		String encodePwd = new BCryptPasswordEncoder().encode(memberBean.getPassword());
		memberBean.setPassword(encodePwd);
		memberService.insert(memberBean);
		return "redirect:/member/findAllMember";
	}
//	@PostMapping("/insertMember")
//	@ResponseBody
//	public MemberBean processInsertMember( @RequestBody MemberBean memberBean) { 
//		 return memberService.insert(memberBean);
//	}

	@GetMapping("/findAllMember")
	public String selectAll(Model model) {
		List<MemberBean> memberBean = memberService.findAll();
		model.addAttribute(memberBean);
		return "member/ShowMember";
	}

	@GetMapping("/selectMember/{number}")
	public String findById(Model model, @PathVariable Integer number) {
		MemberBean memberBean = memberService.findByNumber(number);
		model.addAttribute("memberBean", memberBean);
		return "member/ShowMemberDetail";
	}

	@GetMapping("/modifyMember/{number}")
	public String updateMember(Model model, @PathVariable Integer number) {
		MemberBean memberBean = memberService.findByNumber(number);
//		memberbean.setPassword(memberbean.getPassword());
		model.addAttribute("memberBean", memberBean);
		return "member/EditMemberForm";
	}

	@PostMapping("/modifyMember/{number}")
	public String updateMemberdata(@ModelAttribute("memberBean") MemberBean memberBean, BindingResult bindingResult) {
		new MemberValidator().validate(memberBean, bindingResult);

		if (bindingResult.hasErrors()) {
			return "member/EditMemberForm";
		}
		memberService.update(memberBean);
		return "redirect:/member/findAllMember";
	}

	@GetMapping("/deleteMember/{number}")
	public String deleteMemberData(@PathVariable("number") Integer number) throws SQLException {
		memberService.deleteById(number);
		return "redirect:/member/findAllMember";
	}

	@InitBinder
	public void initBinder(WebDataBinder binder, WebRequest request) {
		// java.util.Date
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		dateFormat.setLenient(false);
		CustomDateEditor ce = new CustomDateEditor(dateFormat, true);
		binder.registerCustomEditor(Date.class, ce);
		// java.sql.Date
		DateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat2.setLenient(false);
		CustomDateEditor ce2 = new CustomDateEditor(dateFormat2, true);
		binder.registerCustomEditor(java.sql.Date.class, ce2);
	}
}
