package tw.gym.menu.controller;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itextpdf.text.log.SysoCounter;

import tw.gym.courses.utils.EmailSenderService;
import tw.gym.member.Model.MemberBean;
import tw.gym.menu.model.OrderMenu;
import tw.gym.menu.model.OrderMenuService;



@Controller
public class ShipmentController {
	private OrderMenuService Oservice;
	
	

	private EmailSenderService emailSerive;

	@Autowired
	public ShipmentController(OrderMenuService oservice, EmailSenderService emailSerive) {
		super();
		this.Oservice = oservice;
		this.emailSerive = emailSerive;

	}

	@GetMapping("/ToShipmentPage.controller")
	public String shipmentMainPage(Model m) {
		
		String ip="";
		try {
			ip=InetAddress.getLocalHost().getHostAddress();
			System.out.println(ip);
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			ip="127.0.0.1";
		}
		m.addAttribute("ip", ip);
		return "menu/shipment";
	}
	
	
	@GetMapping("/queryOrderId.controller")
	@ResponseBody
	//public List<OrderMenu> queryOrderId() {
	public List<Map> queryOrderId() {
		List<OrderMenu> list=Oservice.findAllByStatuse("已付款");
	
		List<Map> newList = new ArrayList<>(); 
		for(Integer i=0;i<list.size();i++){
			
			Map<String, String> order = new HashMap<String, String>();

			order.put("id", String.valueOf(list.get(i).getId()));
			order.put("qty", String.valueOf(list.get(i).getQty()));
			order.put("statuse", list.get(i).getStatuse());
			order.put("price", String.valueOf(list.get(i).getPrice()));
			order.put("orderId", String.valueOf(list.get(i).getOrderId()));
			order.put("food", list.get(i).getMenu().getMenuName());
			newList.add(order);
			
		}
		System.out.print("order = "+newList);
		//return Oservice.findAllByStatuse("已付款");
		return newList;
	}
	
	
	@GetMapping("/changeStatus.controller")
	//@ResponseBody
	public String changeStatus(@RequestParam("id")Integer id,Model m,HttpSession httpSession) {
		List<OrderMenu> orderMenu=Oservice.findAllByOrderId(id);
	
		Date day = new Date();
		String toEmail="";
		String userName="";
		Integer Orderid=0;
		
		for(int i=0;i<orderMenu.size();i++) {
			orderMenu.get(i).setStatuse("已出貨");
			orderMenu.get(i).setDeliveryTime(day);
			toEmail=orderMenu.get(i).getMemberBean().getEmail();
			userName=orderMenu.get(i).getMemberBean().getName();
			Orderid=orderMenu.get(i).getOrderId();
			Oservice.update(orderMenu.get(i));
		}
		
		System.out.println(toEmail+",toEmail");
		System.out.println(userName+",userName");
	
	
		String subject ="出貨通知";
		String body =userName+"先生/小姐您好,"+"編號"+Orderid+"已出貨,請於5分鐘後至大聽取餐,若您對餐點有任何想法,請到下列網址提供您寶貴的意見http://192.168.138.236:8080/ToEvaluationMainPage";
		emailSerive.sendEmail(toEmail, subject, body);
	
		return 	"redirect:ToShipmentPage.controller";
	}
	
	
	@GetMapping("/changeStatusQR.controller")
	@ResponseBody
	public String changeStatusQR(@RequestParam("id")Integer id,Model m,HttpSession httpSession) {
		List<OrderMenu> orderMenu=Oservice.findAllByOrderId(id);
	
		Date day = new Date();
		String toEmail="";
		String userName="";
		Integer Orderid=0;
		
		for(int i=0;i<orderMenu.size();i++) {
			orderMenu.get(i).setStatuse("已出貨");
			orderMenu.get(i).setDeliveryTime(day);
			toEmail=orderMenu.get(i).getMemberBean().getEmail();
			userName=orderMenu.get(i).getMemberBean().getName();
			Orderid=orderMenu.get(i).getOrderId();
			Oservice.update(orderMenu.get(i));
		}
		
		System.out.println(toEmail+",toEmail");
		System.out.println(userName+",userName");
	
	
		String subject ="出貨通知";
		String body =userName+"先生/小姐您好,"+"編號"+Orderid+"已出貨,請於5分鐘後至大聽取餐,若您對餐點有任何想法,請到下列網址提供您寶貴的意見http://192.168.21.21:8080/ToEvaluationMainPage";
		emailSerive.sendEmail(toEmail, subject, body);
	
		return 	"已出貨";
	}
	
	
	@GetMapping("/code.controller")
	public String code() {
		return "menu/code";
	}
}
