package com.st.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.util.Arrays;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Email {

	public static void sendemail(String title,String info,String[] add_arr) throws MessagingException, IOException {
		//设置服务器属性
		Properties props=new Properties();
		props.setProperty("mail.host", "smtp.163.com");//设置163邮箱服务器
		props.setProperty("mail.transport.protocol", "smtp");//邮件发送协议
		props.setProperty("mail.smtp.auth", "true");//需要验证用户名和密码
		//创建会话
		Session session=Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				// TODO Auto-generated method stub
				//发件人邮件用户名、授权码   VTPWHWWBUPFIMCPA
				return new PasswordAuthentication("tang2544006098@163.com","VTPWHWWBUPFIMCPA");
			}
		});
		//开启调试模式，可以看到程序发送email的运行状态
		session.setDebug(true);
		//获得传输者对象
		Transport t=session.getTransport();
		//连接服务器 四个参：邮箱服务--账号--密码
		t.connect("smtp.163.com",  "tang2544006098@163.com", "tzh258456");
		//邮件内容
		Message message=new MimeMessage(session);
		//谁发送的
		message.setFrom(new InternetAddress("tang2544006098@163.com"));
		//发给谁  2544006098@qq
		InternetAddress[] I_add_arr=new InternetAddress[add_arr.length];
		for(int i=0;i<I_add_arr.length;i++) {
			I_add_arr[i]=new InternetAddress(add_arr[i]);
		}
		message.setRecipients(Message.RecipientType.TO, I_add_arr);
		//邮件的标题
		message.setSubject(title);
//		String text="";
//		URL url=new URL("https://www.layui.com/doc/");
//		InputStream is=url.openStream();
//		url.openStream();
//		char[] c_arr=new char[1024];
//		int l=0;
//		Reader r=new InputStreamReader(is);
//		while((l=r.read(c_arr))>0) {
//			text+=new String(Arrays.copyOf(c_arr, l));
//		}
		//邮件的文本内容
		message.setContent(info, "text/html;charset=UTF-8");
		//message.setContent(text, "text/html;charset=UTF-8");
		//发送邮件
		t.sendMessage(message, message.getAllRecipients());
		//关闭传输者流
		t.close();
	}
}
