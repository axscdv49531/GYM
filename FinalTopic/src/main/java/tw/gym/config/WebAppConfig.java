package tw.gym.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
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

	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}

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
		registry.addViewController("/login/page").setViewName("Login");
		registry.addViewController("/login/welcome").setViewName("member/MemberIndex");
		registry.addViewController("/logout").setViewName("login/logoutResult");
		registry.addViewController("/logout/page").setViewName("login/logout");
//		registry.addViewController("/").setViewName("index");
		registry.addViewController("/header").setViewName("header");
		registry.addRedirectViewController("/courseform", "/course/courseform.controller");
		// registry.addRedirectViewController("/updateform",
		// "/course/showUpdateForm.controller");
		registry.addRedirectViewController("/courseQuery", "/course/showcourseQuery.controller");

		registry.addRedirectViewController("/courseSelectSystem", "/membercourse/courseselectionmain.controller");
		registry.addRedirectViewController("/myCourseSchedule", "/membercourse/mycourseschedulemain.controller");
		registry.addRedirectViewController("/selectCourseRecord", "/membercourse/selectcourserecordmain.controller");
		registry.addRedirectViewController("/myCourseSchedulePdf", "/course/viewpdf/mycourses");
		registry.addRedirectViewController("/allCoursePdf", "/course/viewpdf/allcourses");
	}

	@Override
	// /images/* ：指image底下下一層
	// /images/**：指image底下多層全部都找
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/css/**").addResourceLocations("/WEB-INF/resources/css/");
		registry.addResourceHandler("/images/**").addResourceLocations("/WEB-INF/resources/images/");
	}

	// @Override
	// public void addViewControllers(ViewControllerRegistry registry) {
	// // registry.addRedirectViewController("/", "membersmain.controller");
	// // registry.addViewController("/index").setViewName("form");
	// }

}
