package com.st.util;

import java.util.Map;

public class Page {
	// 通过页码和每页的个数计算出开始位置
	public static void pageParam(Map params) {
		System.out.println(params);
		String page = params.get("page") + "";
		String limit = params.get("limit") + "";
		int page_i = Integer.parseInt(page);
		int limit_i = Integer.parseInt(limit);
		int start = limit_i * (page_i - 1);

		params.put("start", start);
	}
}
