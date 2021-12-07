package tw.gym.member.validator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import tw.gym.member.Model.MemberBean;
import tw.gym.member.Service.MemberService;

public class PasswordValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return MemberBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		MemberBean mb = (MemberBean) target;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "oldpwd", "", "不可空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password1", "", "不可空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "confirmedPassword", "", "不可空白");

		if (mb.getOldpwd().equals(mb.getPassword1())) {
			errors.rejectValue("password1", "", "新密碼和原密碼相同");
		}
		if (!mb.getPassword1().equals(mb.getConfirmedPassword())) {
			errors.rejectValue("confirmedPassword", "", "請再次輸入新密碼");
		}

	}

}