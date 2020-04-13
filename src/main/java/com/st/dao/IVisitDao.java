package com.st.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface IVisitDao {

	void huifang(Map params);
	List checkvisit();
	List checkvisit2(Map params);
	void delvisit(Map params);
}
