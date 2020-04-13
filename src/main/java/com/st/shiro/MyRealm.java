package com.st.shiro;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.CredentialsException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.st.bean.Perm;
import com.st.bean.User;
import com.st.config.Context;
import com.st.service.TestService;
@Component
public class MyRealm extends AuthorizingRealm{

	@Autowired
	TestService testservice;
//	@Autowired
//	HttpSession session;
	
	
	/**
	 * 该方法一定是在成功登录后执行的
	 * 每当需要权限认证时都会执行此方法
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		System.out.println("------获取权限");
		Subject sub=SecurityUtils.getSubject();//获取当前访问用户的对象
		User user=(User)sub.getSession().getAttribute(Context.LOGIN_USER);
		List<String> lis=user.getPermissionCodes();
		SimpleAuthorizationInfo sai=new SimpleAuthorizationInfo();
		sai.addStringPermissions(lis);
		
//		String username=(String)SecurityUtils.getSubject().getPrincipal();
//		List list=testservice.getPermByUsername(username);//perm对象的一个集合
//		System.out.println("getPermByUsername----"+list);
//		
//		//需要一个字符串的集合
//		System.out.println("========"+getPermList(list));
//		List<String> list_str=getPermList(list);
//		sai.addStringPermissions(list_str);
		return sai;
	}

	private List<String> getPermList(List list){
		System.out.println("list1----"+list);
		List<Perm> PBlist=(List<Perm>)list;
		List<String> Str_perm_list=new ArrayList<String>();
		System.out.println("Str_perm_list----"+Str_perm_list);
		for(Perm pb:PBlist) {
			Str_perm_list.add(pb.getPerm_code());
		}
		return Str_perm_list;
	}
	
	
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		//获得前台登录用户的用户名和密码
		String username=token.getPrincipal().toString();
		String password=new String((char[]) token.getCredentials());	
		System.out.println("------------验证登录");
		//通过用户名查询用户相关数据
		
		User user=testservice.getUser(username);
		
		System.out.println("user.getAllPermissions().size()---"+user.getAllPermissions().size());

		//数据库验证是否正确
		//用户输入的是123456，需要将用户输入的密码加密成MD5字符串，和数据库中的数据进行校验
		SimpleHash sh=new SimpleHash("md5",password);//
//		sh=new SimpleHash("md5",password,username);
//		sh=new SimpleHash("md5",password,username,12);
		System.out.println("sh---"+sh.toString());
		if(user==null||user.getUsername()==null) {
			throw new CredentialsException("用户名不匹配");
		}else if(!sh.toString().equals(user.getPassword())) {
			throw new CredentialsException("密码不正确");
		}
		//获取session
		Subject sub=SecurityUtils.getSubject();//获取当前访问的对象
		sub.getSession().setAttribute(Context.LOGIN_USER, user);
		return new SimpleAuthenticationInfo(username,password,getName());
	}

}
