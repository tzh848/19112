package com.st.action;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.st.service.BumenService;
import com.st.util.JSON;

@Controller
public class BumenAction {

	@Autowired
	BumenService bumenser;
	
	@RequestMapping("/checkbumen")
	@ResponseBody
	public JSON checkbumen() {
		List list=bumenser.checkbumen();
		JSON json=new JSON(list);
		return json;
	}
	
	@RequestMapping("/checkbumen2")
	@ResponseBody
	public JSON checkbumen2(@RequestParam Map params) {
		List list=bumenser.checkbumen2(params);
		JSON json=new JSON(list);
		return json;
	}
	
	@RequestMapping("/delbumen")
	@ResponseBody
	public void delbumen(@RequestParam String bmid) {
		bumenser.delbumen(bmid);
	}
	
	@RequestMapping("/addbumen")
	@ResponseBody
	public void addbumen(@RequestParam Map params) {
		bumenser.addbumen(params);
	}
	
	@RequestMapping("/updatebumen")
	@ResponseBody
	public void updatebumen(@RequestParam Map params) {
		System.out.println("updatebumen--params--"+params);
		bumenser.updatebumen(params);
	}
}
