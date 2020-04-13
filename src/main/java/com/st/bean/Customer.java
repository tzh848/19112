package com.st.bean;

public class Customer {

	private String customer_id;
	private String customer_name;
	private String customer_man;//客户联系人
	private String customer_tel;
	private String customer_email;
	private String customer_addr;
	private String customer_grade;//客户评价
	private String create_time;
	private String create_time_text;
	private String customer_user;//客户业务员
	private int state;
	private int customer_public;
	
	public String getCreate_time_text() {
		return create_time_text;
	}
	public void setCreate_time_text(String create_time_text) {
		this.create_time_text = create_time_text;
		this.create_time = create_time;
	}
	public String getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(String customer_id) {
		this.customer_id = customer_id;
	}
	public String getCustomer_name() {
		return customer_name;
	}
	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
	}
	public String getCustomer_man() {
		return customer_man;
	}
	public void setCustomer_man(String customer_man) {
		this.customer_man = customer_man;
	}
	public String getCustomer_tel() {
		return customer_tel;
	}
	public void setCustomer_tel(String customer_tel) {
		this.customer_tel = customer_tel;
	}
	public String getCustomer_email() {
		return customer_email;
	}
	public void setCustomer_email(String customer_email) {
		this.customer_email = customer_email;
	}
	public String getCustomer_addr() {
		return customer_addr;
	}
	public void setCustomer_addr(String customer_addr) {
		this.customer_addr = customer_addr;
	}
	public String getCustomer_grade() {
		return customer_grade;
	}
	public void setCustomer_grade(String customer_grade) {
		this.customer_grade = customer_grade;
	}
	
	public String getCreate_time() {
		return create_time;
	}
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
	public String getCustomer_user() {
		return customer_user;
	}
	public void setCustomer_user(String customer_user) {
		this.customer_user = customer_user;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public int getCustomer_public() {
		return customer_public;
	}
	public void setCustomer_public(int customer_public) {
		this.customer_public = customer_public;
	}
	
	
}
