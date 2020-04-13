package com.st.bean;

import java.util.List;

public class TreePoint {

	private String perm_id;
	private String perm_name;
	
	private String id;
	private String title;
	private List<TreePoint> children;
	public String getPerm_id() {
		return perm_id;
	}
	public void setPerm_id(String perm_id) {
		this.perm_id = perm_id;
	}
	public String getPerm_name() {
		return perm_name;
	}
	public void setPerm_name(String perm_name) {
		this.perm_name = perm_name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public List<TreePoint> getChildren() {
		return children;
	}
	public void setChildren(List<TreePoint> children) {
		this.children = children;
	}
	
}
