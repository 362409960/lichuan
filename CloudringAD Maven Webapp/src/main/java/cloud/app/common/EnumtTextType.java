package cloud.app.common;

public enum EnumtTextType {
	
	IMAGE("image"),VIDEO("video"),MUSIC("music"),DOC("doc");
	
	private String values;
	
	private EnumtTextType(String values){
		this.values=values;
	}

	public String getValues() {
		return values;
	}

	public void setValues(String values) {
		this.values = values;
	}
	
	

}
