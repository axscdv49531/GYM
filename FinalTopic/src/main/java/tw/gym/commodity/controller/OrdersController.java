package tw.gym.commodity.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.mail.MessagingException;
import javax.persistence.EntityNotFoundException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.request.WebRequest;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

import ecpay.payment.integration.AllInOne;
import ecpay.payment.integration.domain.AioCheckOutOneTime;
import tw.gym.commodity.model.Discount;
import tw.gym.commodity.model.OrderDetailBean;
import tw.gym.commodity.model.OrdersBean;
import tw.gym.commodity.model.ShoppingCart;
import tw.gym.commodity.service.MailService;
import tw.gym.commodity.service.OrdersService;
import tw.gym.member.Model.MemberBean;
import tw.gym.member.Service.MemberService;

@Controller
@SessionAttributes("ShoppingCart")
public class OrdersController {
	
	@Autowired
	OrdersService orderService;
	
	@Autowired
	MemberService mbService;
	
	@Autowired
	MailService mailService;
	
	public static AllInOne all;	
	
	
	@GetMapping("/commorder/orderlog")
	public String toOrderHistoryPage(Principal p) {
//		MemberBean member = mbService.findByEmail(p.getName());
//		if (member == null) {
//			return "redirect:/";
//		}
		return "commodityshop/orderLog";
	}	
	
	@GetMapping("/commorder/queryAllLog")
	@ResponseBody
	public List<OrdersBean> getAllOrdersWithMember(Principal p) {
//		return orderService.findByMemberId(mbService.findByEmail(p.getName()).getNumber());
		return orderService.findByMemberId(mbService.findByEmail("eeit134019@outlook.com").getNumber());
	}
	
	@DeleteMapping("commorder/cancel/{id}")
	@ResponseBody
	public ResponseEntity<String> cancel(@PathVariable Integer id){
		orderService.deleteById(id);
		return new ResponseEntity<>("訂單 #"+ id +"已取消", HttpStatus.OK);
	}
	
	@PostMapping("/commorder/querylog")
	@ResponseBody
	public List<OrdersBean> getOrderLog(@RequestBody OrdersBean querybean, Principal p) {
		System.out.println(querybean.getOrderId()+", "+ querybean.getOrderDate()+" ,"+ querybean.getPickUpDate()+" ,"+querybean.getMemberId()+", "+querybean.getStatus());
//		querybean.setMemberId(mbService.findByEmail(p.getName()).getNumber());
		querybean.setMemberId(mbService.findByEmail("eeit134019@outlook.com").getNumber());
		ExampleMatcher matcher = ExampleMatcher.matching();
		Example<OrdersBean> example = Example.of(querybean, matcher);
		return orderService.findAllByExample(example, Sort.by("orderDate").descending().and(Sort.by("totalAmt").descending()));
	}
	
	/** if date error, pickupdate will be the day after tomorrow **/
	@PostMapping("/commorder/processOrder")
	public String toProcessOrder(@RequestParam("pickUpDate") String date, @RequestParam int payTerm, 
			Principal p, Model m, WebRequest webRequest, SessionStatus status) {
//		MemberBean member = mbService.findByEmail(p.getName());
		System.out.println(date);
		MemberBean member = mbService.findByEmail("eeit134019@outlook.com");
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date pickUpDate = new Date();
		try {
			pickUpDate = sdf.parse(date+" 08:00");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if (pickUpDate.before(today)) {
			pickUpDate = new Date(today.getTime() + (1000 * 60 * 60 * 24 * 2));
		}
		
//		initial訂單
		ShoppingCart cart = (ShoppingCart) m.getAttribute("ShoppingCart");
		OrdersBean order = new OrdersBean();
		order.setMemberId(member.getNumber());
		order.setPickUpDate(pickUpDate);
		order.setOrderDate(today);
		order.setTotalAmt(cart.getTotalPrice());
		order.setStatus(0);
		
		//購物車的資料轉為orderDetail				
		Set<Discount> discounts = new LinkedHashSet<Discount>(cart.getAppliedDiscount());
		for (Discount ele : discounts) {
			ele.setOrder(order);
		}
		order.setDiscount(discounts);
		
		
		Map<Integer, OrderDetailBean> content = cart.getContent();
		Set<Integer> keyset = content.keySet();
		Set<OrderDetailBean> orderDetails = new LinkedHashSet<>();
		StringBuffer desc = new StringBuffer();
		for (int key :keyset) {
			OrderDetailBean odb = content.get(key);
			desc.append("[#"+odb.getCommodity().getItemId()+", Qty:"+odb.getOrderQty()+"]");
			odb.setOrder(order);
			orderDetails.add(odb);
		}
		order.setOrderDetails(orderDetails);
		
		//產生訂單
		order = orderService.insert(order);
		if(order == null){
			m.addAttribute("errMsg", "訂單執行錯誤, 請再訂購一次");
			return "error";
		}
		
		status.setComplete();
		webRequest.removeAttribute("ShoppingCart", WebRequest.SCOPE_SESSION);
		
		if (payTerm == 1) {
			try {
				String body = generateMailBody(order, member.getName());
				mailService.sendEmail(member.getEmail(), "[Spring Fitness]購物明細通知信 訂單號碼:"+order.getOrderId(), body, generateQRByte(order.getOrderId().toString()));
			} catch (WriterException | IOException | MessagingException e) {
				e.printStackTrace();
			}
			return "redirect:/commorder/orderlog";
		}
		
		initial();
		int oid = order.getOrderId();
		String amt = String.valueOf(order.getTotalAmt().intValue());
		sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		String tDate = sdf.format(today);
		String form = genAioCheckOutOneTime(oid, amt, tDate, desc.toString());
		m.addAttribute("form", form);
		
		System.out.println("oid: " +oid +", amt: "+ amt +", tDate: "+ tDate);
		return "commodityshop/ecpay";
	}
	
	@PostMapping("/ecpayreceiver")
	public String receiver(@RequestParam Map<String, String> params, Model m) {
		String orderId = params.get("MerchantTradeNo").substring(8);
		String rtnCode = params.get("RtnCode");
		
		System.out.println("rtnCode :"+rtnCode);
		if (rtnCode.equals("1")) {
			System.out.println("==============success paid!=====================");
			
			OrdersBean order = orderService.findByID(Integer.valueOf(orderId));
			order.setStatus(1);
			order = orderService.insert(order);
			MemberBean member = mbService.findBymNum(order.getMemberId());
			order.getMemberId();
			
			try {
				String body = generateMailBody(order, member.getName());
				mailService.sendEmail(member.getEmail(), "[Spring Fitness]購物明細通知信 訂單號碼:"+order.getOrderId(), body, generateQRByte(order.getOrderId().toString()));
			} catch (WriterException | IOException | MessagingException e) {
				e.printStackTrace();
			}
			return "redirect:/commorder/orderlog";
		}
		orderService.deleteById(Integer.parseInt(orderId));
		return "redirect:/commorder/orderlog";
	}
	
	private static void initial(){
		all = new AllInOne("");
	}
	
	private static String genAioCheckOutOneTime(Integer oid, String amt, String tdate, String desc){
		AioCheckOutOneTime obj = new AioCheckOutOneTime();
		obj.setMerchantTradeNo("gymworks"+oid);
		obj.setMerchantTradeDate(tdate);
		obj.setTotalAmount(amt);
		obj.setTradeDesc(desc);
		obj.setItemName("#"+ oid);
		
		obj.setReturnURL("http://211.23.128.214:5000");
		obj.setOrderResultURL("http://localhost:8080/ecpayreceiver");
		obj.setNeedExtraPaidInfo("N");
		obj.setRedeem("Y");
		
		String form = all.aioCheckOut(obj, null);
		return form;
	}
	
	private byte[] generateQRByte(String info) throws WriterException, IOException {		
		QRCodeWriter writer = new QRCodeWriter();
		BitMatrix bm = writer.encode(info, BarcodeFormat.QR_CODE, 200, 200);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		
		MatrixToImageWriter.writeToStream(bm, "jpeg", baos);
		return baos.toByteArray();
	}
	
	private String generateMailBody(OrdersBean order, String username) {
		StringBuilder builder = new StringBuilder("<html>");
		builder.append("<p>"+username+" 先生/小姐您好, 以下是您的訂購明細</p>");
		builder.append("<p>訂單號碼: "+order.getOrderId()+"</p>");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		builder.append("<p>提貨日期: "+sdf.format(order.getPickUpDate())+"</p>");
		
		
		builder.append("<table border='1' style='border-collapse:collapse'><caption>訂單/折扣明細</caption><thead>><tr><th>品名</th><th>數量</th><th>小計</th></tr></thead>");
		Set<OrderDetailBean> detailSet = order.getOrderDetails();
		for (OrderDetailBean odb : detailSet) {
			builder.append("<tr><td>"+odb.getCommodity().getItemName()+"</td>");
			builder.append("<td align='right'>"+odb.getOrderQty()+"</td>");
			builder.append("<td align='right'>"+odb.getSubTotal().intValue()+"</td></tr>");
		}
		
		Set<Discount> discSet = order.getDiscount();
		for (Discount disc : discSet) {
			builder.append("<tr><td>"+disc.getRule().getName()+"</td>");
			builder.append("<td></td>");
			builder.append("<td align='right'>-"+disc.getAmount()+"</td></tr>");
		}
		builder.append("<tr><td colspan='2' align='right'>總金額</td><td>"+ order.getTotalAmt().intValue()+"</td></tr></table>");
		builder.append("<p>取貨時, 請您出示此QR Code:</p><img src='cid:img'/></html>");
		return builder.toString();
	}
	
	
	@GetMapping("/admin/ordersys")
	public String toOrderSys() {
		return "commodity/commodityOrders";
	}	
	
	@GetMapping("/admin/queryAllLog")
	@ResponseBody
	public List<OrdersBean> getAllOrderLog() {
		return orderService.findAll();
	}
	
	
	@PostMapping("/admin/querylog")
	@ResponseBody
	public List<OrdersBean> queryOrders(@RequestBody OrdersBean querybean) {
		System.out.println(querybean.getOrderId()+", "+ querybean.getOrderDate()+" ,"+ querybean.getPickUpDate()+" ,"+querybean.getMemberId()+", "+querybean.getStatus());
		ExampleMatcher matcher = ExampleMatcher.matchingAny();
		Example<OrdersBean> example = Example.of(querybean, matcher);
		return orderService.findAllByExample(example, Sort.by("orderDate").descending().and(Sort.by("totalAmt").descending()));
	}
	
	@DeleteMapping("admin/ordersys/{id}")
	@ResponseBody
	public ResponseEntity<String> delete(@PathVariable Integer id){
		orderService.deleteById(id);
		return new ResponseEntity<>("訂單 #"+ id +"已刪除", HttpStatus.OK);
	}
	
	@PutMapping("admin/ordersys/{id}")
	@ResponseBody
	public ResponseEntity<String> update(@PathVariable Integer id){
		OrdersBean bean;
		try {
			bean = orderService.findByID(id);
		}catch(EntityNotFoundException e) {
			e.printStackTrace();
			return new ResponseEntity<>("查無訂單 #"+ id , HttpStatus.INTERNAL_SERVER_ERROR);
		}
		if (bean.getStatus() == 2) {
			return new ResponseEntity<>("不可重複領貨, 訂單 #"+ id +"已結案!", HttpStatus.OK);
		}
		orderService.closeOrder(bean);
		return new ResponseEntity<>("訂單 #"+ id +"已更新", HttpStatus.OK);
	}
	
}
