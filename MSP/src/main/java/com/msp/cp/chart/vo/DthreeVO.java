package com.msp.cp.chart.vo;

public class DthreeVO {

	private String area;
	private String korea;
	private String foreigner;
	private String active_flg;
	
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getKorea() {
		return korea;
	}
	public void setKorea(String korea) {
		this.korea = korea;
	}
	public String getForeigner() {
		return foreigner;
	}
	public void setForeigner(String foreigner) {
		this.foreigner = foreigner;
	}
	public String getActive_flg() {
		return active_flg;
	}
	public void setActive_flg(String active_flg) {
		this.active_flg = active_flg;
	}
	
	@Override
	public String toString() {
		return "DthreeVO [area=" + area + ", korea=" + korea + ", foreigner=" + foreigner + ", active_flg=" + active_flg
				+ "]";
	}
	
}
