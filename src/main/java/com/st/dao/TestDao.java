package com.st.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.st.bean.User;

@Repository
public interface TestDao {

	List treeJson();

	void addprotype(Map params);

	List checkrole();

	User getUser(String username);

	void role_perm(Map map);

	List getPermByUsername(String username);
}
