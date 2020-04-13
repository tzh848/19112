package com.st.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.st.service.CustomerService;
import com.st.service.VisitService;
import com.st.util.JSON;

@Controller
public class VisitAction {

	@Autowired
	VisitService visitservice;
	
	@RequestMapping("/huifang")
	@ResponseBody
	public void huifang(@RequestParam Map params) {
		System.out.println(params);
		visitservice.huifang(params);
	}
	
	@RequestMapping("/checkvisit")
	@ResponseBody
	public JSON checkvisit() {
		List list=visitservice.checkvisit();
		JSON json=new JSON(list);
		return json;
	}
	
	@RequestMapping("/checkvisit2")
	@ResponseBody
	public JSON checkvisit2(@RequestParam Map params) {
		List list=visitservice.checkvisit2(params);
		JSON json=new JSON(list);
		return json;
	}
	
	@RequestMapping("/delvisit")
	@ResponseBody
	public void delvisit(@RequestParam String visit_id) {
		visitservice.delvisit(visit_id);
	}
	
	@RequestMapping("/visit_selected_email")
	@ResponseBody
	public void visit_selected_email(@RequestParam Map params) {
		visitservice.visit_selected_email(params);
	}
	
	@RequestMapping("/visit_all_email")
	@ResponseBody
	public void visit_all_email(@RequestParam Map params,HttpSession session) {
	
		visitservice.visit_all_email(params,session);
	}
}
