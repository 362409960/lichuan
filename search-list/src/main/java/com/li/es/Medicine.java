package com.li.es;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Medicine  implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer id;

	private String username;

	private String function;
	
	
	public Medicine() {

	}

	public Medicine(Integer id, String username, String function) {
           this.id = id;
           this.username = username;
           this.function = function;
	}
	
	

	

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getFunction() {
		return function;
	}

	public void setFunction(String function) {
		this.function = function;
	}
	
	
	

}
