package tw.gym.commodity.controller;

import java.security.Principal;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import tw.gym.commodity.model.CommodityBean;
import tw.gym.commodity.model.OrderDetailBean;
import tw.gym.commodity.model.ShoppingCart;
import tw.gym.commodity.service.CommodityService;
import tw.gym.member.Model.MemberBean;
import tw.gym.member.Service.MemberService;

@Controller
@SessionAttributes("ShoppingCart")
public class CartController {
	
	@Autowired
	CommodityService commService;
	
	@Autowired
	MemberService mbService;
	
	@GetMapping("commodity/cart")
	public String getCartPage(Model m, Principal p) {
		MemberBean mb = mbService.findByEmail(p.getName());
		m.addAttribute("member", mb);
		return "commodityshop/showCart";
	}
	
	@GetMapping("commodity/showCart")
	public @ResponseBody Map<Integer, OrderDetailBean> showCart(Model m) {
		ShoppingCart cart = (ShoppingCart) m.getAttribute("ShoppingCart");	
		if (cart == null) {
			return null;
		}
		return cart.getContent();
	}
	
	@PostMapping("commodity/removeItem")
	public @ResponseBody Map<Integer, OrderDetailBean> removeItem(@RequestParam(required=false, value="ids[]") String[] ids, Model m) {
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
		m.addAttribute(cart);
		return cart.getContent();
	}
	
	@PostMapping("commodity/addToCart")
	public @ResponseBody Map<Integer, OrderDetailBean> AddToCart(Model m, @RequestParam ("id") int id, @RequestParam ("qty") int qty) {
		
		ShoppingCart cart = (ShoppingCart) m.getAttribute("ShoppingCart");
		if(cart == null) {
			cart = new ShoppingCart();
		}
		
		CommodityBean item = commService.findById(id);
		if (item.getItemStock() < qty) {
			return null;
		}
		OrderDetailBean odb = new OrderDetailBean(id, item.getItemName(), qty, item.getUnitPrice());
		cart.addToCart(id, odb);
		m.addAttribute("ShoppingCart", cart);
		
		System.out.println("----------------[AddToCart Controller]: " + cart.toString());

		return cart.getContent();
	}


}
