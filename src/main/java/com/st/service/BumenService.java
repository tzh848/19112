package com.st.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.dao.IBumenDao;

@Service
public class BumenService {

	@Autowired
	IBumenDao bumendao;
	public List checkbumen() {
		List list = bumendao.checkbumen();
		return list;
	}
	
	public List checkbumen2(Map params) {
		List list = bumendao.checkbumen2(params);
		return list;
	}
	
	public void delbumen(String bmid) {
		List list=new ArrayList();
		Map map=new HashMap();
		String[] str=bmid.split(",");
		System.out.println("str----"+str);
		for(String str1:str) {
			list.add(str1);
		}
		map.put("bmid", list);
		bumendao.delbumen(map);
	}

	public void addbumen(Map params) {
		bumendao.addbumen(params);
	}
	
	public void updatebumen(Map params) {
		bumendao.updatebumen(params);
	}
}
