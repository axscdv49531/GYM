package tw.gym.coachclass.validators;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import tw.gym.coach.model.ClassBean;

public class ClassValidator implements Validator {

    @Override
    public boolean supports(Class<?> clazz) {
        return ClassBean.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "className", "", "className欄位不得為空");

    }

}
