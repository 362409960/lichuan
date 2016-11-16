package com.li.es;

public class Blog {
	
	private Integer id;
	
	private String title;
	
	private String date;
	
	private String context;
	
	public Blog(){
		
	}
	
	public Blog(Integer id,String title,String date,String context){
		this.context = context;
		this.title = title;
		this.date = date;
		this.id = id;
	}
	

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}
	
	

}
