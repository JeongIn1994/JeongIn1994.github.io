package com.flowerchest.helper.converter;

import org.springframework.context.annotation.Configuration;
import org.springframework.core.convert.converter.Converter;

import com.flowerchest.controller.SocialLoginType;
@Configuration
public class SocialLoginTypeConverter implements Converter<String, SocialLoginType> {
	
    @Override
    public SocialLoginType convert(String s) {
        return SocialLoginType.valueOf(s.toUpperCase());
    }
    
}
