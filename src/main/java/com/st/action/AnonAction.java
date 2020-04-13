package com.st.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.CredentialsException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.st.config.Context;
import com.st.service.TipService;
import com.st.service.UserService;
@Controller
public class AnonAction/* implements ErrorController */{

	@Autowired
	UserService uservice;
	@Autowired
	TipService tips;
	
	@RequestMapping("/login")
	public String login() {
		//获得令牌
		//UsernamePasswordToken token=new UsernamePasswordToken(params.get("username").toString(), params.get("password").toString());
		//当前用户拿着令牌去认证登录
		//Subject subject=SecurityUtils.getSubject();
		//subject就是当前用户
//		try {
//			subject.login(token);
			//subject.
			//return "sys/";
		//}catch(CredentialsException c) {
			//捕捉到异常 登录失败
			return "login";
		//}	
	}
	
	/*
	 * @RequestMapping("/login2") public String login2() { return "login2"; }
	 */
	
	@RequestMapping("/tologin")
	public String tologin() {
		return "tologin";
	}
	
	@RequestMapping("login_system")
	public String login_system(String username,String password,HttpServletRequest request,HttpSession session) {
		//获得令牌
		UsernamePasswordToken token=new UsernamePasswordToken(username, password);
		//当前用户拿着令牌去认证登录
		Subject sub=SecurityUtils.getSubject();//获取当前访问用户的对象
		//sub就是当前用户
		try {	
			sub.login(token);
			//查询当前用户需要提示信息的数量
			int count=tips.loginUser_tip_count(session);
			System.out.println("Anon----"+count);
			session.setAttribute(Context.TIP_COUNT, count);
		}catch(CredentialsException ce) {
			request.setAttribute("msg", ce.getMessage());
		
			
			return "login";
		}
		session.setAttribute("username", username);
		uservice.updatalastLoginDate(username);
		return "admin";
	}
	
	/*
	 * @RequestMapping("/norole") public String norole() { return "norole"; }
	 */
}
