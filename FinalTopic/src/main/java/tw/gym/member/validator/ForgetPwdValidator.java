package tw.gym.member.validator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import tw.gym.member.Model.MemberBean;
import tw.gym.member.Service.MemberService;

public class ForgetPwdValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return MemberBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		MemberBean mb = (MemberBean) target;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "", "不可空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "phone", "", "不可空白");

	}
}