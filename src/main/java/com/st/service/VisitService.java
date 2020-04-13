package com.st.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.bean.User;
import com.st.config.Context;
import com.st.dao.ICustomerDao;
import com.st.dao.IVisitDao;
import com.st.util.Email;
@Service
public class VisitService {

	@Autowired
	IVisitDao visitdao;
	@Autowired
	ICustomerDao customerdao;
	
	public void huifang(Map params) {
		String uuid=UUID.randomUUID().toString();
		params.put("visit_id", uuid);
		visitdao.huifang(params);
	}
	
	public List checkvisit() {
		List list=visitdao.checkvisit();
		return list;
	}
	
	public List checkvisit2(Map params) {
		List list=visitdao.checkvisit2(params);
		return list;
	}
	
	public void delvisit(String visit_id) {
		List list=new ArrayList();
		Map params=new HashMap();
		String[] str=visit_id.split(",");
		for(String str1:str) {
			list.add(str1);
		}
		params.put("visit_id", list);
		visitdao.delvisit(params);
	}
	
	public void visit_selected_email(Map params) {
		String title=params.get("title").toString();
		String info=params.get("info").toString();
		String email_arr=params.get("email_arr").toString();
		String[] email_str_arr=email_arr.split(",");
		try {
			Email.sendemail(title, info, email_str_arr);
		} catch (MessagingException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void visit_all_email( Map params,HttpSession session) {
		String title=params.get("title").toString();
		String info=params.get("info").toString();
		String username=(String) session.getAttribute("username");
		params.put("username", username);
		List<Map> list = customerdao.checkprivatecus_email(params);
		String addr_arr[] =new String[list.size()];
		for(int i=0;i<list.size();i++) {
			addr_arr[i]=(String) list.get(i).get("customer_email");
		}
		try {
			Email.sendemail(title, info, addr_arr);
		} catch (MessagingException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
//		User user=(User) session.getAttribute(Context.LOGIN_USER);
//		params.put("userid", user.getUserid());
//		params.put("login_userid", user.getUserid());
//		List<Map> list=
		
		
	}
}
