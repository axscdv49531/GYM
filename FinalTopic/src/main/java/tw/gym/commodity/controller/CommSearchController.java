package tw.gym.commodity.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import tw.gym.commodity.model.CommodityBean;
import tw.gym.commodity.model.ItemTypeBean;
import tw.gym.commodity.model.OrderDetailBean;
import tw.gym.commodity.service.CommodityService;

@Controller
public class CommSearchController {
	
	@Autowired
	CommodityService commService;
	
	List<CommodityBean> sResult;
	
	String query;
	
	@GetMapping("/commsearch")
	public String toSearchPage(@RequestParam("q") String q) {
		query = q;
		return "commodityshop/search";
	}
	
	@GetMapping("/searchresult")
	@ResponseBody
	public Map<String, Object> getSResult(){
		
		CommodityBean bean = null;
		if (query.matches("[0-9]{6}")) {
			bean = commService.findById(Integer.valueOf(query));
		}
		
		if (bean != null) {
			sResult = new ArrayList<CommodityBean>();
			sResult.add(bean);
		}else {
			String[] queryStr = query.split(" ");
			for (int j=0; j < queryStr.length; j++) {
				List<CommodityBean> list = commService.findByOnSaleAndKeywords(queryStr[j]);
				if (j != 0) {
					for (int i = 0; i < sResult.size(); i++) {
						if (!list.contains(sResult.get(i))) {
							sResult.remove(i);
							i--;
						}
					}
				}else {
					sResult = list;
				}
			}
		}
		
		Set<ItemTypeBean> types = new HashSet<ItemTypeBean>();
		for (CommodityBean item: sResult) {
			types.add(item.getItemType());
		}
		
		Set<String> vendors = new HashSet<String>();
		for (CommodityBean item: sResult) {
			vendors.add(item.getVendorName());
		}
		
		Map<String, Object> result = new LinkedHashMap<>();
		result.put("types", types);
		result.put("vendors", vendors);
		result.put("result", sResult);
		return result;
	}
	
	@GetMapping("/sorter")
	@ResponseBody
	public List<CommodityBean> filterCommodity(@RequestParam("ft") String ft, @RequestParam("st") int st){
		System.out.println(ft+", "+st);
		
		List<CommodityBean> list = sResult;
		
		if (ft.length()> 23) {
			String[] qArray = ft.split(";");
			Map<String,String> map = new HashMap<String, String>();
			for(String str:qArray) {
				if (str.length()>5) {
					System.out.println(str);
					map.put(str.substring(0, 4), str.substring(5));
				}
			}
			
			Stream<CommodityBean> stream;
			if (map.get("pmin") != null) {
				try {
					Double pmin = Double.parseDouble(map.get("pmin"));
					stream = list.stream();
					list = stream.filter(c -> c.getUnitPrice() >= pmin).collect(Collectors.toList());
				}catch(NumberFormatException e) {
					e.printStackTrace();
					return null;
				}
			}
			
			if (map.get("pmax")!= null) {
				try {
					Double pmax = Double.parseDouble(map.get("pmax"));
					stream = list.stream();
					list = stream.filter(c -> c.getUnitPrice() <= pmax).collect(Collectors.toList());
				}catch(NumberFormatException e) {
					e.printStackTrace();
					return null;
				}
			}
			
			if (map.get("ctgy")!= null) {
				String[] tokens =  map.get("ctgy").split(",");
				List<CommodityBean> temp = new ArrayList<CommodityBean>();
				for (String ele : tokens) {
					stream = list.stream();
					temp.addAll(stream.filter(c -> c.getItemType().getTypeId() == Integer.parseInt(ele)).collect(Collectors.toList()));
				}
				list = temp;
			}
			
			if (map.get("vndr")!= null) {
				String[] tokens =  map.get("vndr").split(",");
				List<CommodityBean> temp = new ArrayList<CommodityBean>();
				for (String ele : tokens) {
					stream = list.stream();
					temp.addAll(stream.filter(c -> c.getVendorName().equals(ele)).collect(Collectors.toList()));
				}
				list = temp;
			}
		}
		
		switch(st) {
			case 1:
				list.sort(Comparator.<CommodityBean, Date>comparing(c -> c.getLastUpdated()));
				break;
			case 2:
				list.sort(Comparator.comparing(CommodityBean::getLastUpdated).reversed());
				break;
			case 3:
				list.sort(Comparator.comparing(CommodityBean::getUnitPrice));
				break;
			case 4:
				list.sort(Comparator.comparing(CommodityBean::getUnitPrice).reversed());
				break;
				
			case 5:				
				List<CommodityBean> temp=new ArrayList<CommodityBean>();
				List<Integer> sales = new ArrayList<Integer>();
				for (int i =0; i< list.size(); i++) {
					int sum = 0;
					for (OrderDetailBean odb:list.get(i).getOrderDetailBean()) {
						sum += odb.getOrderQty();
					}
					sales.add(0, sum);
					temp.add(0, list.get(i));
					int j=1;
					while(j<sales.size() && sales.get(j)>sales.get(j-1)) {
						int x = sales.get(j);
						sales.set(j, sales.get(j-1));
						sales.set(j-1, x);
						CommodityBean bean = temp.get(j);
						temp.set(j, temp.get(j-1));
						temp.set(j-1, bean);						
						j++;
					}
				}
				list = temp;
		}
		return list;
	}
}
