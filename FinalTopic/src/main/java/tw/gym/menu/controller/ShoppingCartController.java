package tw.gym.menu.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import tw.gym.menu.model.CreatOrderId;
import tw.gym.menu.model.MenuService;
import tw.gym.menu.model.OrderMenu;
import tw.gym.menu.model.OrderMenuService;

@Controller
@SessionAttributes(names = {"OrderMenuList" }) // session
public class ShoppingCartController {

	private OrderMenuService oService;
	private MenuService menuService;
	private CreatOrderId creatOrderId;
	private OrderMenu orderMenu;

	@Autowired
	public ShoppingCartController(OrderMenuService oService, MenuService menuService,
			CreatOrderId creatOrderId, OrderMenu orderMenu) {
		super();
		this.oService = oService;
		this.menuService = menuService;
		this.creatOrderId = creatOrderId;
		this.orderMenu = orderMenu;
	}

	@GetMapping("/shoppingCart.controller")
	public String ShoppingCart(Model model, HttpSession httpSession, SessionStatus status) {
		System.out.println("EnterShopping Cart");
		Integer orderId = (Integer) httpSession.getAttribute("orderId");
		if (orderId == null || orderId == 0) {
			System.out.println("EnterShopping Cart == null");
			orderId = 0;
			model.addAttribute("orderId", orderId);
			return "menu/ShoppingCart";
		}
		
		List<OrderMenu> orderMenu = oService.findAllByOrderId(orderId);
		if (orderMenu.size() == 0 || orderMenu == null) {
			httpSession.removeAttribute("orderId");
			httpSession.removeAttribute("OrderMenuList");
			status.setComplete();// 清除session
			status.isComplete();
			System.out.println(status.isComplete());
			System.out.println("Session Clean");

			return "redirect:Menumain.controller";
		}

		model.addAttribute("OrderMenuList", orderMenu);
		return "menu/ShoppingCart";
	}

	@GetMapping(value = "/ModifyShoppingcart.controller") // 更新表單兩個mapping要一樣
	public String modifyShoppingcart(Model model, @RequestParam("id") Integer id) {
		OrderMenu o = new OrderMenu();
		o = oService.findAllById(id);
		model.addAttribute("updateOrderMenu", o);

		return "menu/editMenu";
	}

	@PostMapping(value = "/ModifyShoppingcart.controller") // 更新兩個mapping要一樣
	public String saveModifyShoppingcart(Model model, @ModelAttribute("updateOrderMenu") OrderMenu updateOrderMenu) {

		Integer id = updateOrderMenu.getId();
		OrderMenu orderMenu = oService.findAllById(id);
		orderMenu.setQty(updateOrderMenu.getQty());

		oService.update(orderMenu);

		return "redirect:shoppingCart.controller";
	}

	@GetMapping("/DeleteShoppingcart.controller")
	public String DeleteShoppingcart(Model model, @RequestParam("id") Integer id) {
		OrderMenu orderMenu = oService.findAllById(id);
		orderMenu.setMenu(null);
		oService.insert(orderMenu);
		oService.deleteById(id);

		return "redirect:shoppingCart.controller";
	}

}
