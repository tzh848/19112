package com.st.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.st.service.TestService;
import com.st.util.JSON;

@Controller
public class TestAction {

	@Autowired
	TestService testS;

	
	@RequestMapping("/addprotype")
	@ResponseBody
	public String addprotype() {
		testS.addprotype();
		return "ceshi";
	}

	@RequestMapping("/treeJson")
	@ResponseBody
	public List treeJson() {
		List list = testS.treeJson();
		return list;
	}

	
	@RequestMapping("/checkrole")
	@ResponseBody
	public JSON checkrole() throws JsonProcessingException {
		List list=testS.checkrole();
		JSON json=new JSON(list);
		System.out.println(json);
		return json;
	}

}
