package com.st.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.dao.IUserDao;
import com.st.util.Page;


@Service
public class UserService {

	@Autowired
	IUserDao userdao;
	
	public List checkuser(Map params) {
		Page.pageParam(params);
		List list= userdao.checkuser(params);
		return list;
	}
	
	public int getCount() {
		int count= userdao.getCount();
		return count;
	}
	
	public int getCount2(String username) {
		int count= userdao.getCount2(username);
		return count;
	}
	
	public List checkusername() {
		List list= userdao.checkusername();
		return list;
	}

	public List checkusers(String username) {
		List list= userdao.checkusers(username);
		return list;
	}
	

	
	public void adduser(Map params) {
		String uuid=UUID.randomUUID().toString();
		params.put("userid", uuid);
		
		//将密码通过MD盐值加密
		SimpleHash sh=new SimpleHash("md5", "123456", params.get("uuid"));
		params.put("password", sh.toString());
		userdao.adduser(params);
	}
	
	public void deleteuser(String params) {
		List list=tolist(params);
		Map map=new HashMap();
		map.put("userid", list);
		System.out.println("map----"+map);
		userdao.deleteuser(map);
	}
	public List tolist(String perms) {
		List list=new ArrayList();
		String[] perm_arr=perms.split(",");
		for(String str:perm_arr) {
			if(!str.trim().equals("")) {
				list.add(str);
			}	
		}
		System.out.println(list);
		return list;
	}
	
	public void updataUserP(Map params) {
		userdao.updateUserP(params);
	}
	
	public void updatalastLoginDate(String username) {
		userdao.updatalastLoginDate(username);
	}
	
}
