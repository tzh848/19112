package com.st.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallback;
import org.springframework.transaction.support.TransactionTemplate;

import com.st.bean.User;
import com.st.dao.TestDao;

@Service
public class TestService {

	@Autowired
	TestDao testD;
	@Autowired
	TransactionTemplate transT;

	/**
	 * 保存角色和权限的关联
	 */
	public void role_perm(String role_id,String perms) {
		//1将perms转为集合
		List list=tolist(perms);
		Map map=new HashMap();
		map.put("role_id", role_id);
		map.put("perms", list);
		testD.role_perm(map);
	}
	
	public List tolist(String perms) {
		List list=new ArrayList();
		String[] perm_arr=perms.split(",");
		for(String str:perm_arr) {
			if(!str.trim().equals("")) {
				list.add(str);
			}	
		}
		return list;
	}
	
	
	
	public User getUser(String username) {
		return testD.getUser(username);
	}
	
	public List treeJson() {
		return testD.treeJson();
	}
	
	public List checkrole() {
		return testD.checkrole();
	}
	
	public List getPermByUsername(String username) {
		return testD.getPermByUsername(username);
	}
	
	
//	@Transactional
//这个方式相当于一个事物
	public void addprotype() {
		// 新增数据
		// 新增两个 UUID Protypename---map

		// 验证事务 事务是一个整体
		// 1
		transT.execute(new TransactionCallback<Boolean>(){
			@Override
			public Boolean doInTransaction(TransactionStatus status) {
				try{
					Map map = new HashMap();
					UUID uuid = UUID.randomUUID();
					map.put("uuid", uuid.toString());
					map.put("goodsTypeName", "茶具22");
					testD.addprotype(map);

					System.out.println(1 / 0);
					// 2
					uuid = UUID.randomUUID();
					map.put("uuid", uuid.toString());
					map.put("goodsTypeName", "易碎品");
					testD.addprotype(map);
				}catch(Exception e) {
					status.setRollbackOnly();
					return false;
				}
				return true;
			}
			
		});
		
	}
	public void addprotype2() {
		Map map = new HashMap();
		UUID uuid = UUID.randomUUID();
		map.put("uuid", uuid.toString());
		map.put("goodsTypeName", "茶具22");
		testD.addprotype(map);

		System.out.println(1 / 0);
		// 2
		uuid = UUID.randomUUID();
		map.put("uuid", uuid.toString());
		map.put("goodsTypeName", "易碎品");
		testD.addprotype(map);
	}
}
