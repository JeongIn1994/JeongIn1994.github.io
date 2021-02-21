package com.flowerchest.service;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import com.flowerchest.controller.SocialLoginType;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class OauthService {
	private final GoogleOauth googleOauth;
	private final HttpServletResponse response;
	
	public void requset(SocialLoginType socialLoginType) {
		String redirectURL;
		switch(socialLoginType) {
			case GOOGLE : 	{
				redirectURL = googleOauth.getOauthRedirectURL();
			} break;
			// facebook kakao naver section
			default : {
				throw new IllegalArgumentException("Unknow Login Format");
			}
		}
		try {
			response.sendRedirect(redirectURL);
		}catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
