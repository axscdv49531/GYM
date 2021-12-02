package tw.gym.menu.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import tw.gym.menu.model.Cost;
import tw.gym.menu.model.CostService;
import tw.gym.menu.model.Menu;
import tw.gym.menu.model.MenuService;


@Controller

public class CostController {
	private CostService Cservice;
	private MenuService mservice;

	@Autowired
	public CostController(CostService cservice, MenuService mservice) {
		super();
		this.Cservice = cservice;
		this.mservice = mservice;
	}

	@GetMapping("/InputCostManinPage.controller")
	public String InputCostManinPage(Model m) {
		Cost c = new Cost();
		m.addAttribute("cost", c);
		return "menu/CostInputPage";
	}

	@PostMapping("/saveCost.controller")
	public String save(@ModelAttribute("cost") Cost cost, Model m) {
		String name = cost.getCostitem();
		System.out.println("1");
		Menu menu = mservice.findMenu(name);
		System.out.println("2");
		cost.setMenu(menu);
		System.out.println("3");
		Cservice.insert(cost);
		System.out.println("4");

		m.addAttribute("ok", "資料新增成功");
		return "menu/CostInputPage";

	}

	@GetMapping("/queryCost.controller")
	@ResponseBody
	public List<Cost> queryCost(@RequestParam("date1") Date date) {// @RequestParam("date1") Date date
		List<String> nameList = new ArrayList<String>();
		List<Cost> list = Cservice.findByCostDay(date);
		List<Cost> list1 = new ArrayList<Cost>();
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("蜜香排骨", 0);
		map.put("舒肥雞胸", 0);
		map.put("舒肥牛排", 0);
		map.put("椒麻雞胸", 0);
		map.put("香草豬排", 0);
		map.put("炙烤雞腿", 0);
		map.put("房租", 0);
		map.put("人事成本", 0);
		map.put("其他", 0);
		for (int i = 0; i < list.size(); i++) {
			System.out.println(
					list.get(i).getCostitem() + "," + list.get(i).getCostprice() + "," + list.get(i).getCostday());
			String name = list.get(i).getCostitem();
			Integer cost = Integer.valueOf(list.get(i).getCostprice());

			if (map.get(name) == 0) {
				nameList.add(name);
				map.put(name, cost);
				System.out.println("ok");
			}
		}

		for (int i = 0; i < map.size(); i++) {
			Cost cost = new Cost();
			cost.setCostitem(nameList.get(i));
			cost.setCostprice(String.valueOf(map.get(nameList.get(i))));
			list1.add(cost);
		}

		return list1;
	}
}
