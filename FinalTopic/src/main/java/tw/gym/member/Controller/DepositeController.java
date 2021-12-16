package tw.gym.member.Controller;


import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import tw.gym.member.Model.DepositeBean;
import tw.gym.member.Model.MemberBean;
import tw.gym.member.Service.DepositeService;
import tw.gym.member.Service.MemberService;

@Controller
public class DepositeController {

	private DepositeService depositeService;

	private MemberService memberService;

	@Autowired
	public DepositeController(DepositeService depositeService, MemberService memberService) {
		this.depositeService = depositeService;
		this.memberService = memberService;
	}

	@GetMapping("/findAllDeposite/{number}")
	public String selectAll(Model model, @PathVariable("number") Integer number) {
		List<DepositeBean> depositeBean = depositeService.findAllByMember(number);
		model.addAttribute(depositeBean);
		return "member/ShowDeposite";
	}

	@GetMapping(path = "/updateDeposite/{number}")
	public String insertDeposite(Model m, @PathVariable("number") Integer number) {
		DepositeBean depositeBean = new DepositeBean();
		m.addAttribute("depositeBean", depositeBean);
		return "member/DepositeForm";
	}

	
	@PostMapping("/updateDeposite/{number}")
	public String updateDeposite(Model m, @ModelAttribute("depositeBean")DepositeBean depositeBean, @PathVariable("number") Integer number) {
		depositeService.insertMemberNumber(depositeBean, number);
		System.out.println(number);
		System.out.println(depositeBean.getId());
		Date date=new Date();
		Timestamp timestamp = new Timestamp(date.getTime());
		String time=timestamp.toString();
		System.out.println("送出儲值訂單");
		depositeBean.setTimestamp(timestamp);
		depositeBean.setStatus("0");
		depositeService.update(depositeBean);
//		Integer oldValue = memberService.findByNumber(number).getDeposite();
//		Integer newValue = depositeBean.getValue() + oldValue;
//		depositeBean.setTotal(newValue);
//		MemberBean memberBean=memberService.findByNumber(number);
//		memberBean.setDeposite(newValue);
//		memberService.update(memberBean);		
		return "member/depositeConfirm";
	}
	
	@GetMapping(path = "/adminUpdateDeposite/{number}")
	public String adminInsertDeposite(Model m, @PathVariable("number") Integer number) {
		DepositeBean depositeBean = new DepositeBean();
		m.addAttribute("depositeBean", depositeBean);
		return "admin/DepositeForm";
	}
	@PostMapping("/adminUpdateDeposite/{number}")
	public String adminUpdateDeposite(Model m, @ModelAttribute("depositeBean")DepositeBean depositeBean, @PathVariable("number") Integer number) {
		depositeService.insertMemberNumber(depositeBean, number);
		System.out.println(number);
		System.out.println(depositeBean.getId());
		Date date=new Date();
		Timestamp timestamp = new Timestamp(date.getTime());
		System.out.println("送出儲值訂單");
		depositeBean.setTimestamp(timestamp);
		depositeBean.setStatus("1");
		depositeService.update(depositeBean);
		Integer oldValue = memberService.findByNumber(number).getDeposite();
		Integer newValue = depositeBean.getValue() + oldValue;
		depositeBean.setTotal(newValue);
		MemberBean memberBean=memberService.findByNumber(number);
		memberBean.setDeposite(newValue);
		memberService.update(memberBean);		
		return "redirect:/findDepositeMember";
	}
	@GetMapping("/adminAllDeposite/{number}")
	public String findAllDeposite(Model model, @PathVariable("number") Integer number) {
		List<DepositeBean> depositeBean = depositeService.findAllByMember(number);
		model.addAttribute(depositeBean);
		return "administrator/allDeposite";
	}
	
	@GetMapping("/findDepositeMember")
	public String depositeSelectAll(Model model) {
		List<MemberBean> memberBean = memberService.findAll();
		model.addAttribute(memberBean);
		return "administrator/ShowDepositeMember";
	}
	
}
