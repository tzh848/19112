package com.st.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface IUserDao {

	List checkuser(Map params);
	List checkusername();
	List checkusers(String username);
	void adduser(Map params);
	void deleteuser(Map params);
	void updateUserP(Map params);
	void updatalastLoginDate(String username);
	int getCount();
	int getCount2(String username);
}
