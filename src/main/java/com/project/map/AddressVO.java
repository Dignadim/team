package com.project.map;

public class AddressVO {

	private String Sido;
	private String Gugun;
	
	public String getSido() {
		return Sido;
	}

	public void setSido(String sido) {
		Sido = sido;
	}

	public String getGugun() {
		return Gugun;
	}

	public void setGugun(String gugun) {
		Gugun = gugun;
	}

	@Override
	public String toString() {
		return "AddressVO [Sido=" + Sido + ", Gugun=" + Gugun + "]";
	}	
	
}
