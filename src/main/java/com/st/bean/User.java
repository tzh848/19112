package com.st.bean;

import java.util.ArrayList;
import java.util.List;

public class User {

	private String userid;
	private String username;
	private String password;
	private String city;
	private String regDate;
	private String regDate_text;
	private String lastLoginDate; 
	private String lastLoginDate_text;
	private String tel;
	private String sex;
	private int state;
	private List roles;
	
	public String getRegDate_text() {
		return regDate_text;
	}
	public void setRegDate_text(String regDate_text) {
		this.regDate_text = regDate_text;
		this.regDate = regDate;
	}
	public String getLastLoginDate_text() {
		return lastLoginDate_text;
	}
	public void setLastLoginDate_text(String lastLoginDate_text) {
		this.lastLoginDate_text = lastLoginDate_text;
		this.lastLoginDate = lastLoginDate;
	}
	public List getRoles() {
		return roles;
	}
	public void setRoles(List roles) {
		this.roles = roles;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getLastLoginDate() {
		return lastLoginDate;
	}
	public void setLastLoginDate(String lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * 获得用户的所有的权限
	 * @return
	 */
	public List getAllPermissions() {
		List list=new ArrayList();
		for(int i=0;i<roles.size();i++) {
			Role role=(Role) roles.get(i);
			list.addAll(role.getPermissions());
		}
		return list;
	}
	
	
	public List<String> getPermissionCodes(){
		List<Perm> list=getAllPermissions();
		System.out.println("getAllPermissions()---"+list);
		List<String> list_code=new ArrayList();
		for(Perm per:list) {
			list_code.add(per.getPerm_code());
		}
		return list_code;
	}
}
