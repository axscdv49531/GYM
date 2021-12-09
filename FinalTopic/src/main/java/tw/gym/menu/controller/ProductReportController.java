package tw.gym.menu.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import tw.gym.menu.model.CalculateProduct;
import tw.gym.menu.model.Menu;
import tw.gym.menu.model.MenuService;
import tw.gym.menu.model.OrderMenu;
import tw.gym.menu.model.OrderMenuService;

@Controller
public class ProductReportController {

	OrderMenuService oService;
	CalculateProduct cMenu;
	MenuService Mservice;

	@Autowired
	public ProductReportController(OrderMenuService oService, CalculateProduct cMenu,MenuService Mservice) {
		super();
		this.oService = oService;
		this.cMenu = cMenu;
		this.Mservice=Mservice;
	}

	@GetMapping("/MainReport")
	public String MainReport(Model m) {
		List<Menu>menuList=Mservice.findAll();
		m.addAttribute("MenuList",menuList);
		return "menu/report";
	}

	@GetMapping("/querybyTime")
	@ResponseBody
	public List<Integer> queryOrderMenu(Model m, @RequestParam("date") String date,
			@RequestParam("date1") String date1) {
		System.out.println("進入" + date);
		List<OrderMenu> list = oService.findByTime(date, date1);
		System.out.println("完成找尋工作");
		System.out.println(list.size());
		List<Integer> list2 = cMenu.showReport(list);
		return list2;

	}
}

