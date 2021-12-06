package tw.gym.config;

import java.awt.image.BufferedImage;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.http.converter.BufferedImageHttpMessageConverter;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebAppConfig implements WebMvcConfigurer {

	@Bean
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver resolver = new CommonsMultipartResolver();
		resolver.setDefaultEncoding("UTF-8");
		resolver.setMaxUploadSize(81920000);
		return resolver;
	}

    // @Override
    // public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
    // configurer.enable();
    // }

	// @Bean
	// public InternalResourceViewResolver viewResolver() {
	// InternalResourceViewResolver irViewResolver = new
	// InternalResourceViewResolver();
	// irViewResolver.setPrefix("/WEB-INF/pages/");
	// irViewResolver.setSuffix(".jsp");
	// // irViewResolver.setOrder(6);
	// return irViewResolver;
	// }
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/login/Member").setViewName("LoginMember");
		registry.addViewController("/login/Coach").setViewName("LoginCoach");
		registry.addViewController("/login/MemberSuccess").setViewName("member/MemberIndex");
		registry.addViewController("/login/CoachSuccess").setViewName("coach/CoachIndex");
		registry.addViewController("/logout").setViewName("login/logoutResult");
		registry.addViewController("/logout/page").setViewName("login/logout");
		registry.addViewController("/MemberProfile").setViewName("member/MemberProfile");
//		registry.addViewController("/").setViewName("index");
		registry.addViewController("/header").setViewName("header");
		
		registry.addViewController("/top_memberlogin").setViewName("top_memberlogin");
		registry.addViewController("/top_coachlogin").setViewName("top_coachlogin");
		registry.addViewController("/top_nologin").setViewName("top_nologin");
		registry.addViewController("/bottom").setViewName("bottom");
		registry.addViewController("/courseSelectSystem").setViewName("member/courSelectSytem");
		
		registry.addRedirectViewController("/courseform", "/course/courseform.controller");
		registry.addRedirectViewController("/courseQuery", "/course/showcourseQuery.controller");
		registry.addRedirectViewController("/courseSelectSystem", "/membercourse/courseselectionmain.controller");
		registry.addRedirectViewController("/myCourseSchedule", "/membercourse/mycourseschedulemain.controller");
		//registry.addRedirectViewController("/selectCourseRecord", "/membercourse/selectcourserecordmain.controller");
		registry.addRedirectViewController("/pastCourseRecord", "/membercourse/pastCourseRecord.controller");
		registry.addRedirectViewController("/myCourseSchedulePdf", "/course/viewpdf/mycourses");
		registry.addRedirectViewController("/allCoursePdf", "/course/viewpdf/allcourses");
		
		
	}

	@Override
	// /images/* ：指image底下下一層
	// /images/**：指image底下多層全部都找
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/css/**").addResourceLocations("/WEB-INF/resources/css/");
		registry.addResourceHandler("/images/**").addResourceLocations("/WEB-INF/resources/images/");
		registry.addResourceHandler("/js/**").addResourceLocations("/WEB-INF/resources/js/");
		registry.addResourceHandler("/font/**").addResourceLocations("/WEB-INF/resources/font/");
        registry.addResourceHandler("/fonts_classlist/**").addResourceLocations("/WEB-INF/resources/fonts_classlist/");
        registry.addResourceHandler("/css_classlist/**").addResourceLocations("/WEB-INF/resources/css_classlist/");
        registry.addResourceHandler("/styles_classIntro/**")
                .addResourceLocations("/WEB-INF/resources/styles_classIntro/");
        registry.addResourceHandler("/plugins_classIntro/**")
                .addResourceLocations("/WEB-INF/resources/plugins_classIntro/");
	}

	// @Override
	// public void addViewControllers(ViewControllerRegistry registry) {
	// // registry.addRedirectViewController("/", "membersmain.controller");
	// // registry.addViewController("/index").setViewName("form");
	// }
	
	@Bean
	public HttpMessageConverter<BufferedImage> createImageHttpMessageConverter() {
	    return new BufferedImageHttpMessageConverter();
	}
	
	@Bean
	public MessageSource messageSource() {
		ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
		messageSource.setBasenames("ValidationMessages");
		return messageSource;
	}
	

}
