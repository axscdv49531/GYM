package tw.gym.commodity.model;

import java.lang.reflect.Field;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import tw.gym.commodity.service.CommodityService;

public class CommodityValidator implements Validator {
	
	private static final Logger Logger = LoggerFactory.getLogger(CommodityValidator.class);

	boolean insertFile = false;
	
	@Autowired
	CommodityService commService;
	
	public CommodityValidator() {
	}

	public CommodityValidator(boolean insertFile) {
		this.insertFile = insertFile;
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return CommodityBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		CommodityBean bean = (CommodityBean) target;
		Field[] lists = target.getClass().getFields();
		for (Field field:lists) {
			System.out.println(field.getName());
			System.out.println(field.getGenericType().getTypeName());
		}
		
		Logger.info("------- [CommodityValidator] : start to validate -------");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "itemName", "", "產品名稱不可空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "itemStock", "", "庫存數量不可空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "unitPrice", "", "單價不可空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "itemType", "", "不可空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "itemDesc", "", "不可空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "vendorName", "", "不可空白");
		
		Integer stock = bean.getItemStock();
		if (stock!=null && stock <= 0) {
			errors.rejectValue("itemStock", "", "庫存不可為0或負數");
		}
		
		Double price = bean.getUnitPrice();
		System.out.println(price);
		if (price!=null && price <= 0) {
			errors.rejectValue("unitPrice", "", "單價不可為0或負數");
		}
		
		if (insertFile) {
			Logger.info("----- [CommodityValidator] : uploadFile length is \"+ bean.getFile().length + \"-----");
			if (bean.getFile()[0].getSize() == 0) {
				errors.rejectValue("file", "", "必須上傳圖片");
			}
		}
		
	}

}
