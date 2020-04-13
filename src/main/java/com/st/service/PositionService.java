package com.st.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.dao.IPositionDao;
import com.st.util.Page;

@Service
public class PositionService {
	@Autowired
	IPositionDao posdao;

	public List checkrolename(Map params) {
		Page.pageParam(params);
		List list = posdao.checkrolename(params);
		return list;
	}
	
	public int getCount() {
		int count = posdao.getCount();
		return count;
	}
	
	public List checkroles(Map params) {
		List list = posdao.checkroles(params);
		return list;
	}
	
	public List checkrolename2(String userid) {
		List list = posdao.checkrolename2(userid);
		return list;
	}
	public List checkrolename3() {
		List list = posdao.checkrolename3();
		return list;
	}
	public void del_user_role(Map params) {
		System.out.println("del_user_role---params--"+params);
		posdao.del_user_role(params);
	}
	public void addrole(Map params) {
		posdao.addrole(params);
	}
	
	public void updaterole(Map params) {
		posdao.updaterole(params);
	}
	
	public void delrole(String role_id) {
		List list=new ArrayList();
		Map map=new HashMap();
		String[] str=role_id.split(",");
		for(String str1:str) {
			list.add(str1);
		}
		map.put("role_id", list);
		posdao.delrole(map);
	}
	
	public void deluserrole(String role_id) {
		List list=new ArrayList();
		Map map=new HashMap();
		String[] str=role_id.split(",");
		for(String str1:str) {
			list.add(str1);
		}
		map.put("role_id", list);
		posdao.deluserrole(map);
	}
	
	public void add_user_role(Map params) {
		String str=(String) params.get("role_id");
		System.out.println("str----"+str);
		String regex="\\\"value\":\"(.*?)\\\",\"title\":\"";
		System.out.println("regex"+regex);
		Pattern p=Pattern.compile(regex);
		java.util.regex.Matcher m=p.matcher(str);
		List list=new ArrayList();
		while(m.find()) {
			list.add(m.group(1));
			System.out.println("m.group(1)----"+m.group(1));
		}
		params.put("role_id", list);
		System.out.println("add_user_role==params---"+params);
		posdao.add_user_role(params);
	}
}
