package tw.gym.coach.validators;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import tw.gym.coach.model.CoachBean;

public class CoachValidator implements Validator {

    @Override
    public boolean supports(Class<?> clazz) {
        return CoachBean.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        // TODO Auto-generated method stub

    }

}
