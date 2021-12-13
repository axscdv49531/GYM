package tw.gym.menu.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import tw.gym.courses.utils.EmailSenderService;
import tw.gym.member.Model.MemberBean;
import tw.gym.menu.model.OrderMenu;
import tw.gym.menu.model.OrderMenuService;



@Controller
public class ShipmentController {
	private OrderMenuService Oservice;
	
	
	private EmailSenderService emailSerive;
	
	
	@Autowired
	public ShipmentController(OrderMenuService oservice,EmailSenderService emailSerive) {
		super();
		this.Oservice = oservice;
		this.emailSerive=emailSerive;
		
	}


	@GetMapping("/ToShipmentPage.controller")
	public String shipmentMainPage() {
		
		return "menu/shipment";
	}
	
	
	@GetMapping("/queryOrderId.controller")
	@ResponseBody
	public List<OrderMenu> queryOrderId() {
		
		return Oservice.findAllByStatuse("已付款");
	}
	
	
	@GetMapping("/changeStatus.controller")
	//@ResponseBody
	public String changeStatus(@RequestParam("id")Integer id,Model m,HttpSession httpSession) {
		List<OrderMenu> orderMenu=Oservice.findAllByOrderId(id);
		 Date day = new Date();
		for(int i=0;i<orderMenu.size();i++) {
			orderMenu.get(i).setStatuse("已出貨");
			orderMenu.get(i).setDeliveryTime(day);
			Oservice.update(orderMenu.get(i));
		}
		
		MemberBean member =(MemberBean)httpSession.getAttribute("loginUser");
		String toEmail = member.getEmail();
		String subject ="出貨通知";
		String body =member.getName()+"先生/小姐您好,您所訂購的餐點已出貨,請於30分鐘後至大聽取餐";
		
		
		emailSerive.sendEmail(toEmail, subject, body);
		
		return "redirect:ToShipmentPage.controller";
		//return 	"已出貨";
	}
	
	
	@GetMapping("/code.controller")
	public String code() {
		return "menu/code";
	}
}
