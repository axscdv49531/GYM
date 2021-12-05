package tw.gym.member.Controller;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import tw.gym.member.Model.PaymentBean;
import tw.gym.member.Service.PaymentService;

@Controller
public class PaymentController {
	
	private PaymentService paymentService;
	
	@Autowired
	public PaymentController(PaymentService paymentService) {
		this.paymentService = paymentService;
	}
	
	@GetMapping("/selectPayment/{number}")
	public String findAllByMember(Model model, @PathVariable("number") Integer number) {
		List<PaymentBean> paymentBean = paymentService.findAllByMember(number);
		model.addAttribute(paymentBean);		
		return "member/ShowPayment";		
	}
	
	@GetMapping(path = "/insertPayment/{number}")
	public String inbodyForm(Model m, @PathVariable("number") Integer number) {
		PaymentBean paymentBean = new PaymentBean();
		m.addAttribute("paymentBean", paymentBean);
		return "member/PaymentForm";
	}

	@PostMapping(path = "/insertPayment/{number}")
	public String save(PaymentBean paymentBean, @PathVariable("number") Integer number) {
		paymentService.insertByMember(paymentBean, number);
		return "redirect:/selectPayment/{number}";
	}

	@GetMapping("/selectPayment/deletePayment/{no}")
	public String deletePaymentData(@PathVariable("no") Integer no) throws SQLException {
		paymentService.deleteById(no);
		return "redirect:/selectPayment/{number}";
	}
	
}
