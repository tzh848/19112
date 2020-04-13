package com.st.config;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class Context {

	public static final String LOGIN_USER="login_user";
	public static final String TIP_COUNT="TIP_COUNT";

	public static List toListstr(String str) {
		String[] s_arr = str.split(",");
		List list=new ArrayList();
		for (String s : s_arr) {
			if (!s.trim().equals(""))
				list.add(s);
		}
		return list;
	}
	
	public static void uuid(Map params) {
		UUID uuid = UUID.randomUUID();
		params.put("uuid", uuid.toString());
	}
}
