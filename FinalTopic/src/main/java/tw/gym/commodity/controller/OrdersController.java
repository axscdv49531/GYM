package tw.gym.commodity.controller;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ecpay.payment.integration.AllInOne;
import ecpay.payment.integration.domain.AioCheckOutOneTime;
import tw.gym.commodity.model.OrderDetailBean;
import tw.gym.commodity.model.OrdersBean;
import tw.gym.commodity.model.ShoppingCart;
import tw.gym.commodity.service.OrderDetailService;
import tw.gym.commodity.service.OrdersService;
import tw.gym.member.Model.MemberBean;
import tw.gym.member.Service.MemberService;

@Controller
@SessionAttributes("ShoppingCart")
public class OrdersController {
	
	@Autowired
	OrderDetailService odService;
	
	@Autowired
	OrdersService orderService;
	
	@Autowired
	MemberService mService;
	
	public static AllInOne all;	
	
	@PostMapping("/commodity/order/processOrder2")
	public String toECPayPage(Model m, @RequestParam("memberId") String memberId, 
			@RequestParam("pickUpDate") String date, Principal p) throws ParseException {
		
		ShoppingCart cart =  (ShoppingCart) m.getAttribute("ShoppingCart");
		
		System.out.println(date);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date pickUpDate = sdf.parse(date);
		
		Date today = new Date();
		Double total = cart.getTotal();
		//set訂單
		OrdersBean ob = new OrdersBean();
		ob.setMemberId(memberId);
		ob.setPickUpDate(pickUpDate);
		ob.setOrderDate(today);
		ob.setTotalAmt(total);
		ob.setPaymentStatus(false);
		ob.setPickUpStatus(false);
		
		//購物車的資料轉為orderDetail
		Map<Integer, OrderDetailBean> content = cart.getContent();
		Set<Integer> keyset = content.keySet();
		Set<OrderDetailBean> orderDetails = new LinkedHashSet<>();
		String context ="";
		for (int key :keyset) {
			OrderDetailBean odb = content.get(key);
			context += "#"+odb.getItemName()+"-"+odb.getOrderQty();
			odb.setOrder(ob);
			orderDetails.add(odb);
		}
		ob.setOrderDetails(orderDetails);
		
		//將訂單明細存入訂單
		if(orderService.insert(ob)== null){
			m.addAttribute("orderErrMsg", "訂單執行錯誤, 請再訂購一次");
			return "commodityshop/showCart";
		}
		initial();
		
		System.out.println(ob.getOrderId());
		int oid = ob.getOrderId();
		String amt = String.valueOf(ob.getTotalAmt().intValue());
		sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		String tDate = sdf.format(today);
		System.out.println("oid: " +oid +", amt: "+ amt +", tDate: "+ tDate);
		
		String form = genAioCheckOutOneTime(oid, amt, tDate, context);
		
		m.addAttribute("form", form);
		return "shop/ecpay";
	}
	
	@PostMapping("/commodity/receive")
	public String receiver(@RequestParam Map<String, String> params, Model m, SessionStatus status) {
		
		String tradeNum = params.get("MerchantTradeNo");
		String orderId = tradeNum.substring(8);
		System.out.println("orderId :"+ orderId);
		
		String rtnCode = params.get("RtnCode");
		System.out.println("rtnCode :"+rtnCode);
		if (rtnCode.equals("1")) {
			System.out.println("==============success paid!=====================");
			
			OrdersBean order = orderService.findByID(Integer.valueOf(orderId));
			order.setPaymentStatus(true);
			orderService.insert(order);
			status.setComplete();
			return "commodityshop/orderhistory";
		}
		return "commodityshop/showCart";
	}
	

	
	private static void initial(){
		all = new AllInOne("");
	}
	
	public static String genAioCheckOutOneTime(Integer oid, String amt, String tdate, String items){
		AioCheckOutOneTime obj = new AioCheckOutOneTime();
		obj.setMerchantTradeNo("sgcomm"+oid);
		obj.setMerchantTradeDate(tdate);
		obj.setTotalAmount(amt);
		obj.setTradeDesc(items);
		obj.setItemName("訂單號碼:"+oid);
		
		obj.setReturnURL("http://211.23.128.214:5000");
		obj.setOrderResultURL("http://localhost:8080/commodity/receive");
		obj.setNeedExtraPaidInfo("N");
		obj.setRedeem("Y");
		
		String form = all.aioCheckOut(obj, null);
		return form;
	}
	
	@GetMapping("/commodity/order/orderHistory")
	public String toOrderHistoryPage() {
		return "commodityshop/orderhistory";
	}
	
//	@GetMapping("/commodity/order/deleteorder")
//	public String deleteOrder(@RequestParam("id") Integer id) {
//		orderService.deleteById(id);
//		return "commodity/orderhistory";
//	}

}
