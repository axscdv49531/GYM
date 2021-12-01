package tw.gym.config;

import org.springframework.context.annotation.Bean;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

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
    // InternalResourceViewResolver irViewResolver = new InternalResourceViewResolver();
    // irViewResolver.setPrefix("/WEB-INF/pages/");
    // irViewResolver.setSuffix(".jsp");
    // // irViewResolver.setOrder(6);
    // return irViewResolver;
    // }

    @Override
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
