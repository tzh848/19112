package com.st.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
@Repository
public interface IPositionDao {

	List checkrolename(Map params);
	int getCount();
	List checkroles(Map params);
	List checkrolename2(String userid);
	List checkrolename3();
	void del_user_role(Map params);
	void delrole(Map params);
	void add_user_role(Map params);
	void deluserrole(Map params);
	void addrole(Map params);
	void updaterole(Map params);
}
