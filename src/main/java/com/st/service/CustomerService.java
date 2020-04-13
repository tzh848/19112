package com.st.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.dao.ICustomerDao;
import com.st.util.Page;

@Service
public class CustomerService {
	@Autowired
	ICustomerDao customerdao;

	public List checkcustomer2(Map params) {
		List list = customerdao.checkcustomer2(params);
		return list;
	}
	
	public List checkpubliccus2(Map params) {
		List list = customerdao.checkpubliccus2(params);
		return list;
	}
	
	public List checkprivatecus2(Map params) {
		List list = customerdao.checkprivatecus2(params);
		return list;
	}
	
	public List checkcustomer(Map params) {
		Page.pageParam(params);
		List list = customerdao.checkcustomer(params);
		return list;
	}

	public int getCount() {
		int count = customerdao.getCount();
		return count;
	}
	
	public List checkpubliccus(Map params) {
		Page.pageParam(params);
		List list = customerdao.checkpubliccus(params);
		return list;
	}
	
	public int getPublicCount() {
		int count = customerdao.getPublicCount();
		return count;
	}
	
	public List checkprivatecus(Map params) {
		Page.pageParam(params);
		List list = customerdao.checkprivatecus(params);
		return list;
	}
	
	public int getPrivateCount(Map params) {
		int count = customerdao.getPrivateCount(params);
		return count;
	}
	
	public void delcustomer(String customer_id) {
		List list=new ArrayList();
		Map map=new HashMap();
		String[] str=customer_id.split(",");
		for(String str1:str) {
			list.add(str1);
		}
		map.put("customer_id", list);
		customerdao.delcustomer(map);
	}
	
	public void addcustomer(Map params) {
		String uuid=UUID.randomUUID().toString();
		params.put("customer_id", uuid);
		customerdao.addcustomer(params);
	}
	
	public void updatecus(Map params) {
		customerdao.updatecus(params);
	}
	
	public void gendan(Map params) {
		System.out.println("gendan---service---"+params);
		String str=(String) params.get("customer_id");
		List list=new ArrayList();
		String[] str_arr=str.split(",");
		for(String str1:str_arr) {
			list.add(str1);
		}
		params.put("customer_id", list);
		customerdao.gendan(params);
	}
	
	public void giveup(Map params) {
		System.out.println("giveup---service---"+params);
		String str=(String) params.get("customer_id");
		List list=new ArrayList();
		String[] str_arr=str.split(",");
		for(String str1:str_arr) {
			list.add(str1);
		}
		params.put("customer_id", list);
		customerdao.giveup(params);
	}
	
	public void delcustomer(Map params) {
		customerdao.delcustomer(params);
	}
	
	public List no_visit_list(Map params) {
		return customerdao.no_visit_list(params);
	}
	
	public void init_tip(Map params) {
		customerdao.init_tip(params);
	}
}
