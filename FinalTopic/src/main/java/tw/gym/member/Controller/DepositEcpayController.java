package tw.gym.member.Controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import tw.gym.member.Model.DepAllInOne;
import tw.gym.member.Model.DepositeBean;
import tw.gym.member.Model.MemberBean;
import tw.gym.member.Service.DepositeService;
import tw.gym.member.Service.MemberService;
import tw.gym.menu.model.Menu;
import tw.gym.menu.model.OrderMenu;

@Controller
public class DepositEcpayController {

	private MemberService mbService;
	private DepositeService dpService;
	private DepAllInOne allinone;
	
	
	@Autowired
	public DepositEcpayController(MemberService mbService, DepositeService dpService, DepAllInOne allinone) {
		super();
		this.mbService = mbService;
		this.dpService = dpService;
		this.allinone = allinone;
	}

	@GetMapping("dep.Controller")
	public String payController(@RequestParam("id") Integer id, Model m) {
		System.out.println(id);
		SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Date date = new Date();
		String strDate = sdFormat.format(date);
		Optional<DepositeBean> deposite = dpService.findById(id);		
		Integer value = deposite.get().getValue();
		String valueStr = value.toString();
		String name ="儲值金額:"+value;
		String form = allinone.genAioCheckOutOneTime(id ,strDate, valueStr,name);
		System.out.println(form);
		m.addAttribute("pay", form);
		return "member/paymentresult";
	}

	@GetMapping("dep.ControllerReturn") // 保留
	public String ControllerReturn(Model m, @RequestParam("RtnMsg") String mess) {
		System.out.println("mess=" + mess);
		return null;
	}

	@PostMapping("dep.ControllerReturn1")
	public String ControllerReturn1(Model m, @RequestParam("RtnMsg") String mess,
			@RequestParam("MerchantTradeNo") String id, SessionStatus status, HttpSession httpSession) {
		System.out.println("mess=" + mess);
		System.out.println("finishPayment");
		if (mess.equals("Succeeded")) {
			System.out.println("付款成功");
			Integer intid = Integer.valueOf(id.substring(5));
			System.out.println("intID=" + intid);
			Optional<DepositeBean> deposite = dpService.findById(intid);
			Integer oldValue = deposite.get().getMemberBean().getDeposite();
			Integer newValue = deposite.get().getValue() + oldValue;
			deposite.get().setTotal(newValue);
			MemberBean memberBean=mbService.findByNumber(deposite.get().getMemberBean().getNumber());
			memberBean.setDeposite(newValue);
			mbService.update(memberBean);
			m.addAttribute("DepositeBean", deposite);
			dpService.update(deposite.get());
			return "member/MemberProfile";
		}

		System.out.println("付款失敗");

		m.addAttribute("payError", "付款失敗");

		return "menu/result";
	}

}
