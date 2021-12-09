package tw.gym.menu.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import tw.gym.member.Model.MemberBean;
import tw.gym.menu.model.CreatOrderId;
import tw.gym.menu.model.Menu;
import tw.gym.menu.model.MenuService;
import tw.gym.menu.model.OrderMenu;
import tw.gym.menu.model.OrderMenuService;


@Controller
@SessionAttributes(names = { "orderId" }) // session
public class ShowMenuController {

	private OrderMenuService oService;
	private MenuService menuService;
	private CreatOrderId creatOrderId;
	private OrderMenu orderMenu;


	@Autowired
	public ShowMenuController(OrderMenuService oService, MenuService menuService,
			CreatOrderId creatOrderId, OrderMenu orderMenu) {
		super();
		this.oService = oService;
		this.menuService = menuService;
		this.creatOrderId = creatOrderId;
		this.orderMenu = orderMenu;
	
	}
	
	

	

	@GetMapping(path = "/Menumain.controller") // 到form 的網址
	public String processMainPageAction(Model m, HttpServletRequest request,HttpSession httpSession) {
		OrderMenu orderMenu = new OrderMenu();
		m.addAttribute("orderMenu", orderMenu);
		List<Menu> list = menuService.findAll();
		m.addAttribute("MenuList", list);
		
		
		return "menu/ShowMenu";
	}


	@PostMapping(path = "/OrderMenu.controller")
	public String OrderMenuDetail(Model m, @ModelAttribute("orderMenu") OrderMenu orderMenu, HttpSession httpSession) {

		String menuName = orderMenu.getMenu().getMenuName();
		Menu menu = menuService.findMenu(menuName);


		int orderId = 0;
		if (httpSession.getAttribute("orderId") == null || (Integer) httpSession.getAttribute("orderId") == 0) {
			orderId = creatOrderId.orderid();
			m.addAttribute("orderId", orderId);
			System.out.println("creat Orderid=" + orderId);
		} else {
			orderId = (Integer) httpSession.getAttribute("orderId");
		}

		int id = menu.getId();
		OrderMenu chekOrder = oService.findOrderByOrderIdAndName(orderId, id);
		if (chekOrder != null) {
			int total = orderMenu.getQty() + chekOrder.getQty();
			chekOrder.setQty(total);
			oService.insert(chekOrder);
			return "redirect:shoppingCart.controller";
		}
		
		MemberBean member =(MemberBean)httpSession.getAttribute("loginUser");
		Integer memberNumber= member.getNumber();
		System.out.println(memberNumber+"memberNumber");

		Date date = new Date();
		orderMenu.setOrderTime(date);
		orderMenu.setOrderId(orderId);
		orderMenu.setStatuse("未付款");
		orderMenu.setMemberBean(member);
		orderMenu.setMenu(menu);

		System.out.println("setDetail");

		List<OrderMenu> orderMenuList = menu.getOrderMenus();
		orderMenuList.add(orderMenu);
		menu.setOrderMenus(orderMenuList);

		oService.insert(orderMenu);
		System.out.println("outMenu");
		return "redirect:shoppingCart.controller";
	}
	
	
	@GetMapping("/nologinMenumain.controller")
	public String processnologinMainPageAction(Model m, HttpServletRequest request,HttpSession httpSession) {
		OrderMenu orderMenu = new OrderMenu();
		m.addAttribute("orderMenu", orderMenu);
		List<Menu> list = menuService.findAll();
		m.addAttribute("MenuList", list);
		
		
		return "menu/NologinShowMenu";
	}

}
