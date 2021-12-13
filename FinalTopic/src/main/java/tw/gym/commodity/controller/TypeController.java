package tw.gym.commodity.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import tw.gym.commodity.model.ItemTypeBean;
import tw.gym.commodity.service.ItemTypeService;

@Controller
public class TypeController {
	
	@Autowired
	ItemTypeService tService;
	
	@GetMapping("/admin/itemType")
	public String toItemTypePage(Model m){
		m.addAttribute("charMonth", tService.getChartMonth());
		return "commodity/itemType";
	}
	
	@GetMapping("/admin/querySalePct/{time}")
	@ResponseBody
	public List<Map<String, Object>> getSalePctEachType(@PathVariable String time){
		String[] tokens=  time.split("-");
		return tService.getPctOfEachType(Integer.parseInt(tokens[0]), Integer.parseInt(tokens[1]));
	}
	
	@GetMapping("/admin/queryTypes")
	@ResponseBody
	public List<ItemTypeBean> getItemTypes(){
		return tService.findAll();
	}
	
	@DeleteMapping("/admin/deleteType/{id}")
	@ResponseBody
	public List<ItemTypeBean> delete(@PathVariable Integer id) {
		if (tService.deleteById(id)) {
			return tService.findAll();
		}
		return null;
	}
	
	@PostMapping("/admin/saveTypes")
	@ResponseBody
	public List<ItemTypeBean> saveTypes(@RequestBody ItemTypeBean bean) {
		System.out.println(bean.getTypeId()+", "+ bean.getTypeName()+", "+ bean.getGroups());
		if (tService.save(bean)!= null) {
			return tService.findAll();
		}
		return null;
	}
	
	
}
