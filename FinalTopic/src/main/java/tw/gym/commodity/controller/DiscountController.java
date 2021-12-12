package tw.gym.commodity.controller;

import java.sql.Blob;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.sql.rowset.serial.SerialBlob;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


import tw.gym.commodity.model.BuyMoreDiscount;
import tw.gym.commodity.model.CommodityBean;
import tw.gym.commodity.model.RuleBase;
import tw.gym.commodity.model.TotalPriceDiscountRule;
import tw.gym.commodity.service.CommodityService;
import tw.gym.commodity.service.RuleBaseService;

@Controller
public class DiscountController {
	
	@Autowired
	CommodityService commService;
	
	@Autowired
	RuleBaseService ruleService;
	
	/** Fei: active rules show in index page**/
	@GetMapping("/activediscount")
	@ResponseBody
	public List<RuleBase> queryActiveRules(){
		return ruleService.findActiveRules();
	}
	
	/** Fei: rule image**/
	@GetMapping("/discountimg/{id}")
	public ResponseEntity<byte[]> getDiscountImg(@PathVariable Integer id){
		ResponseEntity<byte[]> re = null;
		RuleBase bean = ruleService.findById(id);
		if (bean != null) {
			Blob blob = bean.getImage();
			
			try {
				byte[] b = blob.getBytes(1, (int) blob.length());
				HttpHeaders headers = new HttpHeaders();
				MediaType mediaType = MediaType.valueOf(bean.getMimeType());
				headers.setContentType(mediaType);
				re = new ResponseEntity<byte[]>(b, headers, HttpStatus.OK);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}		
		return re;
	}
	
	
	@GetMapping("/admin/discountrule")
	public String toDiscountPage() {
		return "commodity/discountRule";
	}
	
	@GetMapping("/admin/disountList")
	@ResponseBody
	public List<RuleBase> queryDiscountList(){
		return ruleService.findAll();
	}
	
	@GetMapping("admin/commList")
	@ResponseBody
	public List<CommodityBean> getAllComms(){
		return commService.findAll();
	}
	
	@PostMapping("admin/discount/{id}")
	@ResponseBody
	public ResponseEntity<String> getOffDiscount(@PathVariable Integer id){
		RuleBase bean = ruleService.findById(id);
		if (bean.getEndTime().before(new Date()) && bean.getStartTime().before(new Date())) {
			
			return new ResponseEntity<>("活動已過期，請嘗試刪除", HttpStatus.OK);
		}
		if (bean.getStartTime().after(new Date())) {
			return new ResponseEntity<>("活動尚未開始，請嘗試刪除", HttpStatus.OK);
		}
		bean.setEndTime(new Date(System.currentTimeMillis()-3000));
		ruleService.insert(bean);
		return new ResponseEntity<>("已下架", HttpStatus.OK);
				
	}
	
	@DeleteMapping("admin/discount/{id}")
	@ResponseBody
	public ResponseEntity<String> deleteDiscount(@PathVariable Integer id){
		if (ruleService.deleteRule(id)) {
			return new ResponseEntity<>("Deletion successed.", HttpStatus.OK);
		}
		return new ResponseEntity<>("Not allowed. The discount is consumed.", HttpStatus.OK);
	}
	
	
	@PostMapping("/admin/updateDiscount")
	@ResponseBody
	public ResponseEntity<String> updateDiscount(HttpServletRequest req) {
		MultipartHttpServletRequest params = (MultipartHttpServletRequest) req;
		String start = params.getParameter("startTime")+" 00:00";
		String end = params.getParameter("endTime")+ " 23:59";
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");	
		
		RuleBase rule = null;
		List<String> invalidIds = new ArrayList<String>();
		try {
			switch(params.getParameter("type")) {
				case "1": 
					rule = new BuyMoreDiscount(Integer.parseInt(params.getParameter("condition")), Integer.parseInt(params.getParameter("discount")), 
							sdf.parse(start), sdf.parse(end));
					String[] tokens = params.getParameter("commodity").split(",");
					Set<CommodityBean> commodity = new LinkedHashSet<>();
					invalidIds = ruleService.findCommIdWithActiveRule(start);
					for (String ele :tokens) {
						if (!invalidIds.contains(ele)) {
							commodity.add(commService.findById(Integer.parseInt(ele)));
							invalidIds.remove(ele);
						}			
					}
					if (commodity.isEmpty()) {
						return new ResponseEntity<>("選取的全部商品的檔期重疊, 未新增成功", HttpStatus.OK);
					}
					rule.setCommodity(commodity);
					break;
				case "2":
					rule = new TotalPriceDiscountRule(Integer.parseInt(params.getParameter("condition")), Integer.parseInt(params.getParameter("discount")), 
							sdf.parse(start), sdf.parse(end));
					break;
				default:
					System.out.println(params.getParameter("type"));
					return null;
			}

		} catch (NumberFormatException e1) {
			e1.printStackTrace();
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		
		MultipartFile file = params.getFile("photo");		
		byte[] b = null;
		String mimeType = null;
		try {
			if (file != null) {
				b = file.getBytes();
				mimeType = file.getContentType();
			}
			Blob blob = new SerialBlob(b);
			rule.setImage(blob);
			rule.setMimeType(mimeType);
			ruleService.insert(rule);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<>("成功新增, 檔期重疊的商品: "+invalidIds.toString(), HttpStatus.OK);
	}
	

	
}
