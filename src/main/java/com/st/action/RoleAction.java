package com.st.action;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.st.service.TestService;

@Controller
@RequestMapping("/sys")
public class RoleAction {
	@Autowired
	TestService testSer;
	
	@RequestMapping("/admin")
	public String admin() {
		return "admin";
	}

	@RequestMapping("/visit")
	public String visit() {
		return "visit";
	}
	
	@RequestMapping("/privatecus")
	public String privatecus() {
		return "privatecus";
	}
	
	@RequestMapping("/publiccus")
	public String publiccus() {
		return "publiccus";
	}
	
	@RequestMapping("/customer")
	public String customer() {
		return "customer";
	}
	
	@RequestMapping("/bumen")
	public String bumen() {
		return "bumen";
	}
	
	@RequestMapping("/user")
	//@RequiresPermissions("user_system")
	public String user() {
		return "user";
	}
	
	@RequestMapping("/perm")
	@RequiresPermissions("user_system")
	public String perm() {
		return "perm";
	}
	
	@RequestMapping("/role_perm_page/{role_id}")
	public String role_perm_page(@PathVariable String role_id,HttpServletRequest request) {
		System.out.println("----role_perm_page"+role_id);
		request.setAttribute("role_id", role_id);
		return "index";
	}
	
	
	@RequestMapping("/role_perm/{role_id}/{perms}")
	public String role_perm(@PathVariable String role_id,@PathVariable  String perms) {
		System.out.println(role_id);
		System.out.println(perms);
		testSer.role_perm(role_id,perms);
		return "perm";
	}
	
	@RequestMapping("/rest/{id}/{name}")
	@ResponseBody
	public String rest(@PathVariable String id, @PathVariable String name) {
		return "id:" + id + ",name:" + name;
	}
}
