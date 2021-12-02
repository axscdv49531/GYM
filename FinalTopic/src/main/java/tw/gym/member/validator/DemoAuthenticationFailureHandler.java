package tw.gym.member.validator;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import tw.gym.member.util.DemoResponse;

public class DemoAuthenticationFailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request,
            HttpServletResponse response, AuthenticationException exception)
            throws IOException, ServletException {
        
        response.setStatus(HttpStatus.FORBIDDEN.value());
        DemoResponse data = new DemoResponse(HttpStatus.FORBIDDEN.value(),exception.getMessage());
        response.getOutputStream().println(new ObjectMapper().writeValueAsString(data));
        
    }

}
