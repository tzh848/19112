package com.st.action;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.st.service.UserService;
import com.st.util.JSON;
import com.st.util.LayJson;

@Controller
public class UserAction {
	@Autowired
	UserService uservice;

//	@RequestMapping("user")
//	public String user_page() {
//		return "user";
//	}
	@RequestMapping("checkuser")
	@ResponseBody
	public LayJson checkuser(@RequestParam Map params) throws JsonProcessingException {
		System.out.println("params----"+params);
		List list = uservice.checkuser(params);
		//查询总数据有多少行
		int count = uservice.getCount();
		LayJson json=new LayJson(list);
		//设置总数据量
		json.setCount(count);
		json.setData(list);
		System.out.println(json);
		return json;
	}
	@RequestMapping("checkusername")
	@ResponseBody
	public LayJson checkusername() throws JsonProcessingException {
		List list = uservice.checkusername();
		LayJson json=new LayJson(list);
//		String strjson2=list2.toString();
//		strjson=strjson.substring(0, strjson.length()-1);
		return json;
	}
	
	@RequestMapping("checkusers")
	@ResponseBody
	public LayJson checkusers(String username) throws JsonProcessingException {
		List list = uservice.checkusers(username);
		int count=uservice.getCount2(username);
		LayJson json=new LayJson(list);
		json.setCount(count);
		json.setData(list);
		System.out.println(json);
		return json;
	}
	

	@RequestMapping("/adduser")
	@ResponseBody
	public void adduser(@RequestParam Map params){
		uservice.adduser(params);
	}
	
	@RequestMapping("/deluser")
	@ResponseBody
	public void deleteuser(@RequestParam String userid){
		System.out.println(userid);
		uservice.deleteuser(userid);
	}
	
	@RequestMapping("/updateuserP")
	@ResponseBody
	public void updateUserP(@RequestParam Map params) {
		System.out.println("updateuserP--params--"+params);
		uservice.updataUserP(params);
	}
}
