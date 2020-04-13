package com.st.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.bean.User;
import com.st.config.Context;
import com.st.dao.ITipDao;



@Service
public class TipService {

	@Autowired
	ITipDao tipd;
	
	public int loginUser_tip_count(HttpSession session) {
		User user=(User) session.getAttribute(Context.LOGIN_USER);
		Map map=new HashMap();
		map.put("userid", user.getUserid());
		int count=tipd.loginUser_tip_count(map);
		return count;
	}
}
