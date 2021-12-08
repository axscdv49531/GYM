package tw.gym.member.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import tw.gym.member.Model.MemberBean;

public class MemberValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return MemberBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		MemberBean mb = (MemberBean) target;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "", "姓名欄位不能為空");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "gender", "", "性別欄位未填");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "birthday", "", "生日欄位不能為空");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "phone", "", "號碼欄位不能為空");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "", "Email身份證欄位不能為空");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "county", "", "請選擇縣市");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "district", "", "請選擇區");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "address", "", "地址欄位不能為空");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "expirationdate", "", "入會時間欄位不能為空");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "emergencyContact", "", "緊急聯絡人欄位不能為空");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "emergencyPhone", "", "緊急連絡人電話欄位不能為空");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mPhoto", "", "請上傳照片");
	}

}