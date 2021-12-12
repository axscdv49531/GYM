package tw.gym.commodity.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import tw.gym.commodity.model.CommodityBean;
import tw.gym.commodity.model.CommodityValidator;
import tw.gym.commodity.model.ItemTypeBean;
import tw.gym.commodity.service.CommodityImgService;
import tw.gym.commodity.service.CommodityService;
import tw.gym.commodity.service.ItemTypeService;

@SuppressWarnings("rawtypes")
@Controller
public class CommodityController {
	
	@Autowired
	CommodityService commodityService;
	
	@Autowired
	CommodityImgService commodityImgService;
	
	@Autowired
	ItemTypeService typeService;
	
	@Autowired
	ServletContext context;
	
	@GetMapping("/commodity")
	public String shop(Model m) {
		return "commodityshop/commoditymain";
	}
	
	@GetMapping("/shop/commodity")
	@ResponseBody
	public List<CommodityBean> shopCommodity() {
		return commodityService.findAll();
	}
	
	@GetMapping("/admin/commodity")
	public String toCommodityPage() {
		return "commodity/commodityList";
	}
	
	@GetMapping("/admin/commodityForm")
	public String updateCommodity(@RequestParam("id") Integer id, Model m) {
		CommodityBean item = commodityService.findById(id);
		if (item == null) {
			item = new CommodityBean();
		}
		m.addAttribute("commodityBean", item);
		m.addAttribute("itemTypeBean", typeService.findAllByGroups());
		return "commodity/updateCommodity";
	}
	
	@GetMapping("/admin/commodity/queryAllTypesAndVendors")
	@ResponseBody
	public List<List> getAllTypesAndVendors() {
		List<ItemTypeBean> types = typeService.findAllByOrderingCategory();
		List<String> vendors = commodityService.findAllVendors();
		List<List> result = new ArrayList<List>();
		result.add(types);
		result.add(vendors);
		return result;
	}
	
	@PostMapping("/admin/commodity/{pageNo}")
	@ResponseBody
	public Map<String, Collection> getTest(@PathVariable("pageNo") int pageNo, @RequestBody CommodityBean querybean) {		
		int pageSize = 10;
		ExampleMatcher matcher = ExampleMatcher.matching()
				.withMatcher("itemName", ExampleMatcher.GenericPropertyMatchers.contains());
		Example<CommodityBean> example = Example.of(querybean, matcher);
		Pageable pageable = PageRequest.of(pageNo-1, pageSize, Sort.by("lastUpdated").descending());
		Page<CommodityBean> page = commodityService.findAllByPages(example, pageable);

		Map<String, Collection> result = new LinkedHashMap<String, Collection>();
		List<Number> pageInfo = Arrays.asList(page.getTotalPages(), page.getTotalElements());
		
		result.put("pageInfo", pageInfo);
		result.put("list", page.getContent());
		return result;
	}

	@DeleteMapping("/admin/commodity/{id}")
	@ResponseBody
	public ResponseEntity<String> deleteCommodity(@PathVariable("id") Integer id) {
		if (!commodityService.deleteById(id)) {
			return new ResponseEntity<>("Not allowed. Orders contains this item.", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>("Deletion successed.", HttpStatus.OK);
	}
	

	
	@PostMapping("/admin/updateCommodity")
	public String updateComm(@ModelAttribute("commodityBean") CommodityBean item, BindingResult result, Model m, 
			RedirectAttributes redirectAttributes) throws IOException {
		
		boolean flag = (item.getItemId() != null && commodityService.findById(item.getItemId()) != null)? false : true;
		CommodityValidator validator = new CommodityValidator(flag);
		validator.validate(item, result);
		
		if(result.hasErrors()) {
			m.addAttribute("itemTypeBean", typeService.findAll());
			m.addAttribute("itemTypeBean", typeService.findAllByGroups());
			return "commodity/updateCommodity";
		}
		
		System.out.println("-----------[CommodityController] update a Comm: "+ item.getItemId());
		
		//To update CommodityBean
		commodityService.insert(item, flag);
		
		//To save commodityImgBean
		String dirPath = context.getRealPath("/")+ "uploadFile\\" + item.getItemId()+ "\\";
		try {
			commodityImgService.insert(item.getFile(), dirPath, getDate(), item);
		} catch (IOException e) {
			e.printStackTrace();
			m.addAttribute("errMsg", "上傳圖片發生錯誤, 請聯繫人員處理: "+ e.getMessage());
			return "error";
		}
		redirectAttributes.addFlashAttribute("successMsg", "新增或修改成功!");
		return "redirect:/admin/commodity";
	}
		
	private String getDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		return sdf.format(new Date());
	}
	
}
