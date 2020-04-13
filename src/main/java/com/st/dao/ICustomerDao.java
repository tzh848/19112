package com.st.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface ICustomerDao {
	List checkcustomer2(Map params);
	List checkpubliccus2(Map params);
	List checkprivatecus2(Map params);
	List checkcustomer(Map params);
	int getCount();
	List checkpubliccus(Map params);
	int getPublicCount();
	int getPrivateCount(Map params);
	List checkprivatecus(Map params);
	List checkprivatecus_email(Map params);
	void delcustomer(Map params);
	void addcustomer(Map params);
	void updatecus(Map params);
	void gendan(Map params);
	void giveup(Map params);
	List no_visit_list(Map params);
	void init_tip(Map params);
}
