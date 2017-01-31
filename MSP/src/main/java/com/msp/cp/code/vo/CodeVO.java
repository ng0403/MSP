package com.msp.cp.code.vo;

import java.util.Date;

public class CodeVO {
	private String grp_cd, grp_nm, grp_desc, code1, code_txt, code_desc,
	               created_by, updated_by;
	private Date created, updated;
	
	public String getGrp_cd() {
		return grp_cd;
	}
	
	public void setGrp_cd(String grp_cd) {
		this.grp_cd = grp_cd;
	}
	
	public String getGrp_nm() {
		return grp_nm;
	}
	
	public void setGrp_nm(String grp_nm) {
		this.grp_nm = grp_nm;
	}
	
	public String getGrp_desc() {
		return grp_desc;
	}
	
	public void setGrp_desc(String grp_desc) {
		this.grp_desc = grp_desc;
	}
	
	public String getCode1() {
		return code1;
	}
	
	public void setCode1(String code1) {
		this.code1 = code1;
	}
	
	public String getCode_txt() {
		return code_txt;
	}
	
	public void setCode_txt(String code_txt) {
		this.code_txt = code_txt;
	}
	
	public String getCode_desc() {
		return code_desc;
	}
	
	public void setCode_desc(String code_desc) {
		this.code_desc = code_desc;
	}
	
	public String getCreated_by() {
		return created_by;
	}
	
	public void setCreated_by(String created_by) {
		this.created_by = created_by;
	}
	
	public String getUpdated_by() {
		return updated_by;
	}
	
	public void setUpdated_by(String updated_by) {
		this.updated_by = updated_by;
	}
	
	public Date getCreated() {
		return created;
	}
	
	public void setCreated(Date created) {
		this.created = created;
	}
	
	public Date getUpdated() {
		return updated;
	}
	
	public void setUpdated(Date updated) {
		this.updated = updated;
	}

}
