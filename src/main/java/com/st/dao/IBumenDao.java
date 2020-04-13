package com.st.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface IBumenDao {

	List checkbumen();
	List checkbumen2(Map params);
	void delbumen(Map params);
	void addbumen(Map params);
	void updatebumen(Map params);
}
