package com.st.util;

import java.util.List;


public class LayJson {
	private String code = "0";
	private String msg = "";
	private int count = 100;
	private List data = null;

	public static LayJson getJSON(List data, int count) {
		LayJson lj = new LayJson(data);
		lj.setData(data);
		lj.setCount(count);
		return lj;
	}

	public LayJson(List data) {
		super();
		// if (data != null) {
		// this.count = data.size();
		// }

		this.data = data;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public List getData() {
		return data;
	}

	public void setData(List data) {
		// if (data != null) {
		// this.count = data.size();
		// }
		this.data = data;
	}

}
