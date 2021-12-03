package tw.gym.member.validator;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import com.fasterxml.jackson.databind.ObjectMapper;

import tw.gym.member.util.DemoResponse;

public class DemoAuthenticationEntryPoint implements AuthenticationEntryPoint {

	  @Override
	    public void commence(HttpServletRequest request,
	            HttpServletResponse response, 
	            AuthenticationException authException) throws IOException, ServletException {
	        
	        response.setStatus(HttpStatus.UNAUTHORIZED.value()); 
	        DemoResponse data = new DemoResponse(HttpStatus.UNAUTHORIZED.value(), HttpStatus.UNAUTHORIZED.name());
	        response.getOutputStream().println(new ObjectMapper().writeValueAsString(data));
	    }
}
