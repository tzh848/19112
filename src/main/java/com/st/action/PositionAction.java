package com.st.action;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.st.service.PositionService;
import com.st.util.JSON;
import com.st.util.LayJson;

@Controller
public class PositionAction {

	@Autowired
	PositionService posser;
	

	@RequestMapping("/checkrolename")
	@ResponseBody
	public LayJson checkrolename(@RequestParam Map params) {
		List list = posser.checkrolename(params);
		int count = posser.getCount();
		LayJson json = new LayJson(list);
		json.setCount(count);
		json.setData(list);
		return json;
	}

	@RequestMapping("/checkroles")
	@ResponseBody
	public JSON checkroles(@RequestParam Map params) {
		List list = posser.checkroles(params);
		JSON json = new JSON(list);
		return json;
	}
	
	@RequestMapping("/checkrolename2")
	@ResponseBody
	public List checkrolename2(@RequestParam String userid) {
		System.out.println("checkrolename2--userid----"+userid);
		List list = posser.checkrolename2(userid);
		System.out.println("checkrolename2--list----"+list);
		return list;
	}

	@RequestMapping("/checkrolename3")
	@ResponseBody
	public List checkrolename3() {
		List list = posser.checkrolename3();
		System.out.println("checkrolename3--list--"+list);
		return list;
	}
	@RequestMapping("/add_user_role")
	@ResponseBody
	public void add_user_role(@RequestParam Map params, HttpServletResponse response) throws IOException  {
		//response.setCharacterEncoding("utf-8");
		System.out.println(params);
	try{
		posser.del_user_role(params);
		posser.add_user_role(params);	
		response.getWriter().write("修改成功！");
	}catch(Exception e) {
		response.getWriter().write("修改失败！");
	}
}
	
	@RequestMapping("/delrole")
	@ResponseBody
	public void delrole(@RequestParam String role_id){
		posser.delrole(role_id);
		posser.deluserrole(role_id);
	}
	
	@RequestMapping("/addrole")
	@ResponseBody
	public void addrole(@RequestParam Map params){
		posser.addrole(params);
	}
	
	@RequestMapping("/updaterole")
	@ResponseBody
	public void updaterole(@RequestParam Map params){
		System.out.println("updaterole--params---"+params);
		posser.updaterole(params);
	}
}
