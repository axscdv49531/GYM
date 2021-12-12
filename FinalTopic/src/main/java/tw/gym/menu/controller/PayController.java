package tw.gym.menu.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import tw.gym.menu.model.ExampleAllInOne;
import tw.gym.menu.model.Menu;
import tw.gym.menu.model.MenuService;
import tw.gym.menu.model.OrderMenu;
import tw.gym.menu.model.OrderMenuService;



@Controller
public class PayController {

	public OrderMenuService oService;
	public MenuService mService;
	public ExampleAllInOne pay;


	@Autowired
	public PayController(OrderMenuService oService, MenuService mService,ExampleAllInOne pay) {
		super();
		this.oService = oService;
		this.mService = mService;
		this.pay=pay;
	
	}
	
	@GetMapping("pay.Controller")
	public String payController(@RequestParam("orderId") Integer orderId, Model m) {
		Map<String, Integer> quanty = new HashMap<String, Integer>();
		String  ItemName ="";
		Integer totalMony=0;
		List<OrderMenu> list = oService.findAllByOrderId(orderId);
		for(Integer i=0;i<list.size();i++){
			
			totalMony+=list.get(i).getPrice()*list.get(i).getQty();
			ItemName+=list.get(i).getMenu().getMenuName()+list.get(i).getPrice()+"元"+"x"+list.get(i).getQty()+"#";	
		}
	     SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	    Date date = new Date();
		String strDate = sdFormat.format(date); 
		String orderid="test"+orderId;
		String totalMonyStr=totalMony.toString();
		String form=pay.genAioCheckOutOneTime(ItemName,orderid,strDate,totalMonyStr);
		System.out.println(form+"=form");
		m.addAttribute("pay",form);
		
		return "menu/paymentresultTest";
	}
	
	@GetMapping("pay.ControllerTest")
	public String payControllerTest(@RequestParam("orderId") Integer orderId, Model m) {
		List<OrderMenu> list = oService.findAllByOrderId(orderId);
		//System.out.print("pay.ControllerTest-->"+list);
		m.addAttribute("MenuList", list);
		Map<String, Integer> quanty = new HashMap<String, Integer>();
		for (int i = 0; i < list.size(); i++) {
			quanty.put(list.get(i).getMenu().getMenuName(), list.get(i).getQty());
			list.get(i).setStatuse("已付款");
			oService.update(list.get(i));
		}
		for (String key : quanty.keySet()) {// mene 數量 -order 數量
			Menu menu = mService.findMenu(key);
			Integer total = menu.getMenuQty() - quanty.get(key);
			menu.setMenuQty(total);
			mService.update(menu);
		}
		

		
		return "menu/result";
	}
	
	
	@GetMapping("pay.ControllerReturn")//保留
	public String ControllerReturn(Model m,@RequestParam("RtnMsg")String mess) {
		System.out.println("mess="+mess);
		return null;
	}
	
	
	@PostMapping("pay.ControllerReturn1")
	public String ControllerReturn1(Model m, @RequestParam("RtnMsg") String mess,
			@RequestParam("MerchantTradeNo") String id, SessionStatus status, HttpSession httpSession) {
		System.out.println("mess=" + mess);
		System.out.println("finishPayment");
		if (mess.equals("Succeeded")) {
			System.out.println("付款成功");
			Integer intid = Integer.valueOf(id.substring(4,10));
			System.out.println("intID=" + intid);
			List<OrderMenu> list = oService.findAllByOrderId(intid);
			m.addAttribute("MenuList", list);
			Map<String, Integer> quanty = new HashMap<String, Integer>();
			for (int i = 0; i < list.size(); i++) {
				quanty.put(list.get(i).getMenu().getMenuName(), list.get(i).getQty());
				list.get(i).setStatuse("已付款");
				oService.update(list.get(i));
			}
			for (String key : quanty.keySet()) {// mene 數量 -order 數量
				Menu menu = mService.findMenu(key);
				Integer total = menu.getMenuQty() - quanty.get(key);
				menu.setMenuQty(total);
				mService.update(menu);
			}
			httpSession.removeAttribute("orderId");
			httpSession.removeAttribute("OrderMenuList");
			status.setComplete();// 清除session
			status.isComplete();
			System.out.println(status.isComplete());
			System.out.println("Session Clean");

			return "menu/result";
		}
		
		System.out.println("付款失敗");

		m.addAttribute("payError", "付款失敗");

		return "menu/result";
	}
	
	

	
	
	
}
