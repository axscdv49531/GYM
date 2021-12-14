package tw.gym.member.Controller;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import tw.gym.member.Model.InbodyBean;
import tw.gym.member.Model.MemberBean;
import tw.gym.member.Service.InbodyService;
import tw.gym.member.Service.MemberService;

@Controller
public class InbodyController {

	private InbodyService inbodyService;
	
	private MemberService memberService;

	@Autowired
	public InbodyController(InbodyService inbodyService , MemberService memberService ) {
		this.inbodyService = inbodyService;
		this.memberService = memberService;
	}

	@GetMapping("/selectInbody/{number}")
	public String findAllByMember(Model model, @PathVariable("number") Integer number) {

		List<InbodyBean> inbodyBean = inbodyService.findAllByMember(number);

		model.addAttribute(inbodyBean);
//		MemberBean[] beanArray = memberBean.toArray(new MemberBean[0]);
//		model.addAttribute(beanArray);
		return "member/ShowInbody";
	}

	@GetMapping(path = "/insertInbody/{number}")
	public String inbodyForm(Model m, @PathVariable("number") Integer number) {
//		MemberBean memberBean= memberService.findById(number);
//		m.addAttribute("memberBean",memberBean);
//		System.out.println(memberBean.getName());
		InbodyBean inbodyBean = new InbodyBean();
//		inbodyBean.setNumber(number);
		m.addAttribute("inbodyBean", inbodyBean);
		return "member/InbodyForm";
	}

	@PostMapping(path = "/insertInbody/{number}")
	public String save(InbodyBean inbodyBean, @PathVariable("number") Integer number) {
		inbodyService.insertByMember(inbodyBean, number);
		return "redirect:/findAllMember";
	}


	@GetMapping("/selectInbody/deleteInbody/{no}")
	public String deleteMemberData(@PathVariable("no") Integer no ) throws SQLException {
		inbodyService.deleteById(no);
		return "redirect:/member/selectInbody/{number}";
	}
	
	
	@GetMapping("/adminFindInbody/{number}")
	public String findAllInbody(Model model, @PathVariable("number") Integer number) {

		List<InbodyBean> inbodyBean = inbodyService.findAllByMember(number);

		model.addAttribute(inbodyBean);
//		MemberBean[] beanArray = memberBean.toArray(new MemberBean[0]);
//		model.addAttribute(beanArray);
		return "administrator/allInbody";
	}
	
	
	@GetMapping("/findInbodyMember")
	public String inbodySelectAll(Model model) {
		List<MemberBean> memberBean = memberService.findAll();
		model.addAttribute(memberBean);
		return "administrator/ShowInbodyMember";
	}
}
