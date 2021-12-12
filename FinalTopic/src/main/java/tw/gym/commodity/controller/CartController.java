package tw.gym.commodity.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import tw.gym.commodity.model.CommodityBean;
import tw.gym.commodity.model.Discount;
import tw.gym.commodity.model.OrderDetailBean;
import tw.gym.commodity.model.RuleBase;
import tw.gym.commodity.model.ShoppingCart;
import tw.gym.commodity.service.CommodityService;
import tw.gym.commodity.service.RuleBaseService;
import tw.gym.member.Model.MemberBean;
import tw.gym.member.Service.MemberService;

@Controller
@SessionAttributes("ShoppingCart")
public class CartController {
	
	@Autowired
	CommodityService commService;
	
	@Autowired
	RuleBaseService ruleService;
	
	@Autowired
	MemberService mbService;
	
//	@GetMapping("commCart/cart")
	@GetMapping("/commcart")
	public String toCartPage(Principal p, Model m) {
//		MemberBean member = mbService.findByEmail(p.getName());
//		if (member == null) {
//			return "redirect:/";
//		}
//		m.addAttribute("MemberName", hideInfo(member.getName(), 0));
//		m.addAttribute("MemberEmail", hideInfo(member.getEmail(), 1));
//		m.addAttribute("MemberPhone", hideInfo(member.getPhone(), 2));
		
		m.addAttribute("MemberName", hideInfo("金秀賢", 0));
		m.addAttribute("MemberEmail", hideInfo("karischien@outlook.com", 1));
		m.addAttribute("MemberPhone", hideInfo("0911895789", 2));
		return "commodityshop/showCart";
	}
	
	/** Fei: access to everyone**/
	@PostMapping("addToCart")
	public @ResponseBody ShoppingCart addToCart(Model m, @RequestParam ("id") int id, @RequestParam ("qty") int qty) {		
		ShoppingCart cart = (ShoppingCart) m.getAttribute("ShoppingCart");
		if(cart == null) {
			cart = new ShoppingCart();
		}
		
		CommodityBean item = commService.findById(id);
		if (item.getItemStock() < qty) {
			return null;
		}
		OrderDetailBean odb = new OrderDetailBean(item, qty, item.getUnitPrice());
		cart.addToCart(id, odb);
		
		cart = checkOutProcess(cart, ruleService.findActiveRules());
		m.addAttribute("ShoppingCart", cart);
		return cart;
	}
	
	/** Fei: to collect applied discounts with active rules and get check out price**/
	private ShoppingCart checkOutProcess(ShoppingCart cart, List<RuleBase> activeRules) {
		cart.setTotalPrice(cart.processTotal());
		
		List<Discount> discounts = new ArrayList<>();
		for (RuleBase rule : activeRules) {
			List<Discount> disc = rule.process(cart);
			discounts.addAll(disc);
			int discount_sum = 0;
			for (Discount ele :disc) {
				discount_sum += ele.getAmount();
			}
			cart.setTotalPrice(cart.getTotalPrice()-discount_sum);
		}
		cart.setAppliedDiscount(discounts);
		return cart;
	}

	
	/** Fei: to hide buyer's info in cart page**/
	private String hideInfo (String info, int ctr) {
		StringBuffer sb = new StringBuffer();
		
		switch (ctr) {
			case 0 :
				for (int i=0; i< info.length(); i++) {
					sb = (i == 0 || i == info.length()-1)? sb.append(info.charAt(i)):sb.append("*"); 
				}
				break;
			case 1:
				int idx = info.indexOf("@");
				String subStr = info.substring(0, idx);
				for (int i=0; i< subStr.length(); i++) {
					sb.append("*");
				}
				sb.append(info.substring(idx));
				break;
			case 2:
				sb.append(info.substring(0, 3)+"-");
				String str = info.substring(4);
				for (int i=0; i< str.length(); i++) {
					sb.append("*");
				}
				break;
		}
		return sb.toString();
		
	}
	
	@GetMapping("commcart/showCart")
	public @ResponseBody ShoppingCart showCart(Model m) {
		ShoppingCart cart = (ShoppingCart) m.getAttribute("ShoppingCart");	
		if (cart == null) {
			return null;
		}
		return cart;
	}
	
	@PostMapping("commcart/removeItem")
	public @ResponseBody ShoppingCart removeItem(@RequestParam(required=false, value="ids[]") String[] ids, Model m) {
		ShoppingCart cart = (ShoppingCart) m.getAttribute("ShoppingCart");	
		System.out.println(ids.toString());
		if (ids.length == 0) {
			return null;
		}
		int id;
		for (String ele :ids) {
			try {
				 id = Integer.parseInt(ele);
			}catch(NumberFormatException e) {
				return null;
			}
			cart.deleteItem(id);
		}
		cart = checkOutProcess(cart, ruleService.findActiveRules());
		m.addAttribute("ShoppingCart", cart);
		return cart;
	}
	



}
