package com.msp.cp.user.vo;

import org.springframework.stereotype.Component;

@Component
public class userVO {
	String user_id;
	String user_pwd;
	String emp_no;
	String user_nm;
	String dept_cd;
	String dept_nm;
	String rank_cd;
	String rank_nm;
	String duty_cd;
	String duty_nm;
	String cphone_num1;
	String cphone_num2;
	String cphone_num3;
	String phone_num1;
	String phone_num2;
	String phone_num3;
	String email_id;
	String email_domain;
	String hiredate;
	String created_by;
	String retiredate;
	String active_flg;
	String del_flg;
	String grp_cd;
	String code1;
	String code1_txt;
	
	
	
	
	public String getDuty_nm() {
		return duty_nm;
	}
	public void setDuty_nm(String duty_nm) {
		this.duty_nm = duty_nm;
	}
	public String getRank_nm() {
		return rank_nm;
	}
	public void setRank_nm(String rank_nm) {
		this.rank_nm = rank_nm;
	}
	public String getGrp_cd() {
		return grp_cd;
	}
	public void setGrp_cd(String grp_cd) {
		this.grp_cd = grp_cd;
	}
	public String getCode1() {
		return code1;
	}
	public void setCode1(String code1) {
		this.code1 = code1;
	}
	public String getCode1_txt() {
		return code1_txt;
	}
	public void setCode1_txt(String code1_txt) {
		this.code1_txt = code1_txt;
	}
	public String getDept_nm() {
		return dept_nm;
	}
	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
	}
	public String getDel_flg() {
		return del_flg;
	}
	public void setDel_flg(String del_flg) {
		this.del_flg = del_flg;
	}
	public String getRetiredate() {
		return retiredate;
	}
	public void setRetiredate(String retiredate) {
		this.retiredate = retiredate;
	}
	public String getUser_pwd() {
		return user_pwd;
	}
	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getRank_cd() {
		return rank_cd;
	}
	public void setRank_cd(String rank_cd) {
		this.rank_cd = rank_cd;
	}
	public String getDuty_cd() {
		return duty_cd;
	}
	public void setDuty_cd(String duty_cd) {
		this.duty_cd = duty_cd;
	}
	public String getCphone_num1() {
		return cphone_num1;
	}
	public void setCphone_num1(String cphone_num1) {
		this.cphone_num1 = cphone_num1;
	}
	public String getCphone_num2() {
		return cphone_num2;
	}
	public void setCphone_num2(String cphone_num2) {
		this.cphone_num2 = cphone_num2;
	}
	public String getCphone_num3() {
		return cphone_num3;
	}
	public void setCphone_num3(String cphone_num3) {
		this.cphone_num3 = cphone_num3;
	}
	public String getPhone_num1() {
		return phone_num1;
	}
	public void setPhone_num1(String phone_num1) {
		this.phone_num1 = phone_num1;
	}
	public String getPhone_num2() {
		return phone_num2;
	}
	public void setPhone_num2(String phone_num2) {
		this.phone_num2 = phone_num2;
	}
	public String getPhone_num3() {
		return phone_num3;
	}
	public void setPhone_num3(String phone_num3) {
		this.phone_num3 = phone_num3;
	}
	public String getEmail_id() {
		return email_id;
	}
	public void setEmail_id(String email_id) {
		this.email_id = email_id;
	}
	public String getEmail_domain() {
		return email_domain;
	}
	public void setEmail_domain(String email_domain) {
		this.email_domain = email_domain;
	}
	public String getHiredate() {
		return hiredate;
	}
	public void setHiredate(String hiredate) {
		this.hiredate = hiredate;
	}
	public String getCreated_by() {
		return created_by;
	}
	public void setCreated_by(String created_by) {
		this.created_by = created_by;
	}
	public String getActive_flg() {
		return active_flg;
	}
	public void setActive_flg(String active_flg) {
		this.active_flg = active_flg;
	}
	@Override
	public String toString() {
		return "userVO [user_id=" + user_id + ", user_pwd=" + user_pwd + ", emp_no=" + emp_no + ", user_nm=" + user_nm
				+ ", dept_cd=" + dept_cd + ", dept_nm=" + dept_nm + ", rank_cd=" + rank_cd + ", rank_nm=" + rank_nm
				+ ", duty_cd=" + duty_cd + ", duty_nm=" + duty_nm + ", cphone_num1=" + cphone_num1 + ", cphone_num2="
				+ cphone_num2 + ", cphone_num3=" + cphone_num3 + ", phone_num1=" + phone_num1 + ", phone_num2="
				+ phone_num2 + ", phone_num3=" + phone_num3 + ", email_id=" + email_id + ", email_domain="
				+ email_domain + ", hiredate=" + hiredate + ", created_by=" + created_by + ", retiredate=" + retiredate
				+ ", active_flg=" + active_flg + ", del_flg=" + del_flg + ", grp_cd=" + grp_cd + ", code1=" + code1
				+ ", code1_txt=" + code1_txt + "]";
	}
	
	
	
	
	
}

