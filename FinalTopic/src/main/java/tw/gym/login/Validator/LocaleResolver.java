//package tw.gym.login.Validator;
//
//import org.springframework.context.MessageSource;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.support.ReloadableResourceBundleMessageSource;
//import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
//import org.springframework.web.servlet.i18n.CookieLocaleResolver;
//import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
//
//public class LocaleResolver extends LocaleChangeInterceptor {
//	@Override
//	public void addInterceptors(InterceptorRegistry registry) {
//		LocaleChangeInterceptor localeChangeInterceptor = new LocaleChangeInterceptor();
//		localeChangeInterceptor.setParamName("lang");
//		registry.addInterceptor(localeChangeInterceptor);
//	}
//
//	@Bean
//	public LocaleResolver localeResolver() {
//		CookieLocaleResolver cookieLocaleResolver = new CookieLocaleResolver();
//		return cookieLocaleResolver;
//	}
//
//	@Bean 
//	public MessageSource messageSource(){ 
//		ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource(); 
//		messageSource.setBasename("classpath:messages"); 
//		messageSource.setUseCodeAsDefaultMessage(true); 
//		messageSource.setDefaultEncoding("UTF-8"); 
//		messageSource.setCacheSeconds(0); 
//		return messageSource; }
//}
