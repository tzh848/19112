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
import com.st.util.JSON;
import com.st.util.LayJson;

@Controller
public class CustomerAction {
	@Autowired
	CustomerService customerser;

	@RequestMapping("/checkcustomer2")
	@ResponseBody
	public JSON checkcustomer2(@RequestParam Map params) {
		List list = customerser.checkcustomer2(params);
		JSON json = new JSON(list);
		return json;
	}
	
	@RequestMapping("/checkpubliccus2")
	@ResponseBody
	public JSON checkpubliccus2(@RequestParam Map params) {
		List list = customerser.checkpubliccus2(params);
		JSON json = new JSON(list);
		return json;
	}
	
	@RequestMapping("/checkprivatecus2")
	@ResponseBody
	public JSON checkprivatecus2(@RequestParam Map params) {
		List list = customerser.checkprivatecus2(params);
		JSON json = new JSON(list);
		return json;
	}
	
	@RequestMapping("/checkcustomer")
	@ResponseBody
	public LayJson checkcustomer(@RequestParam Map params) {
		int count = customerser.getCount();
		List list = customerser.checkcustomer(params);
		LayJson json = new LayJson(list);
		json.setCount(count);
		json.setData(list);
		return json;
	}
	
	@RequestMapping("/checkpubliccus")
	@ResponseBody
	public LayJson checkpubliccus(@RequestParam Map params) {
		int count = customerser.getPublicCount();
		List list = customerser.checkpubliccus(params);
		LayJson json = new LayJson(list);
		return json;
	}
	
	@RequestMapping("/checkprivatecus")
	@ResponseBody
	public LayJson checkprivatecus(HttpSession session,@RequestParam Map params) {
		String username=(String) session.getAttribute("username");
		params.put("username", username);
		List list = customerser.checkprivatecus(params);
		int count=customerser.getPrivateCount(params);
		LayJson json = new LayJson(list);
		json.setCount(count);
		json.setData(list);
		return json;
	}
	
	@RequestMapping("/delcustomer")
	@ResponseBody
	public void delcustomer(@RequestParam String customer_id){
		customerser.delcustomer(customer_id);
		//customerser.deluserrole(customer_id);
	}

	@RequestMapping("/addcustomer")
	@ResponseBody
	public void addcustomer(@RequestParam Map params){
		customerser.addcustomer(params);
		//customerser.deluserrole(customer_id);
	}
	
	@RequestMapping("/updatecus")
	@ResponseBody
	public void updatecus(@RequestParam Map params){
		customerser.updatecus(params);
	}
	
	@RequestMapping("/gendan")
	@ResponseBody
	public void gendan(@RequestParam Map params){
		customerser.gendan(params);
	}

	@RequestMapping("/giveup")
	@ResponseBody
	public void giveup(@RequestParam Map params){
		customerser.giveup(params);
	}
}
