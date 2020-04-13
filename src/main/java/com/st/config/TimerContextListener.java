package com.st.config;

import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import org.springframework.beans.factory.annotation.Autowired;

import com.st.util.TipTimer;

@WebListener
public class TimerContextListener implements ServletContextListener {

	@Autowired
	TipTimer tt;

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		// 项目启动时即执行该方法

		// 创建一个计时器--每隔一天（到达一个时间点）就会做一件事情
		// 定时任务

		Timer timer = new Timer();
		timer.schedule(tt, 0);

		// 将两天未回访的客户信息生成提示信息数据
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// TODO Auto-generated method stub

	}

}
