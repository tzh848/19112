package com.st.util;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimerTask;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.st.config.Context;
import com.st.service.CustomerService;

@Component
public class TipTimer extends TimerTask {

	@Autowired
	CustomerService customerser;

	@Override
	public void run() {
		while (true) {
			try {
				Thread.sleep(1000 * 60*60);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// 到达零点执行该方法
			Date date = new Date();
			int h = date.getHours();
			System.out.println(h+"-----------h");
			if (h == 0) {
				// TODO Auto-generated method stub
				// 查询出所有两天没有进行回访的客户信息
				Map params = new HashMap();
				List<Map> list = customerser.no_visit_list(params);
				// 根据以上客户信息生成提示信息
				// 每一条数据添加一个id，拼接提示信息
				for (Map map : list) {
					Context.uuid(map);
					tip_info(map);
				}
				params.put("tip_infos", list);
				// 生成提示信息，保存到数据库中
				customerser.init_tip(params);
			}
		}
	}

	private void tip_info(Map params) {
		try {
			String customer_id = params.get("customer_id").toString();
			String customer_name = params.get("customer_name").toString();
			String tip_info = "你跟单的<a href='tip_customer/" + customer_id + "'>" + customer_name + "</a>客户已经超过两天没有进行回访了";
			params.put("tip_info", tip_info);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
