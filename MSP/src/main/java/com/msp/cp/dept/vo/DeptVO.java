package com.msp.cp.dept.vo;

public class DeptVO {
	
	public String dept_cd;
	public String dept_nm;
	public String dept_num1;
	public String dept_num2;
	public String dept_num3;
	public String dept_fnum1;
	public String dept_fnum2;
	public String dept_fnum3;
	public String active_flg;
	
	public String dept_leader;
	
	public String keyword;
	
	public String getDept_leader() {
		return dept_leader;
	}

	public void setDept_leader(String dept_leader) {
		this.dept_leader = dept_leader;
	}

	public String getDept_cd() {
		return dept_cd;
	}

	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}

	public String getDept_nm() {
		return dept_nm;
	}

	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
	}

	public String getDept_num1() {
		return dept_num1;
	}

	public void setDept_num1(String dept_num1) {
		this.dept_num1 = dept_num1;
	}

	public String getDept_num2() {
		return dept_num2;
	}

	public void setDept_num2(String dept_num2) {
		this.dept_num2 = dept_num2;
	}

	public String getDept_num3() {
		return dept_num3;
	}

	public void setDept_num3(String dept_num3) {
		this.dept_num3 = dept_num3;
	}

	public String getDept_fnum1() {
		return dept_fnum1;
	}

	public void setDept_fnum1(String dept_fnum1) {
		this.dept_fnum1 = dept_fnum1;
	}

	public String getDept_fnum2() {
		return dept_fnum2;
	}

	public void setDept_fnum2(String dept_fnum2) {
		this.dept_fnum2 = dept_fnum2;
	}

	public String getDept_fnum3() {
		return dept_fnum3;
	}

	public void setDept_fnum3(String dept_fnum3) {
		this.dept_fnum3 = dept_fnum3;
	}

	public String getActive_flg() {
		return active_flg;
	}

	public void setActive_flg(String active_flg) {
		this.active_flg = active_flg;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "DeptVO [dept_cd=" + dept_cd + ", dept_nm=" + dept_nm + ", dept_num1=" + dept_num1 + ", dept_num2="
				+ dept_num2 + ", dept_num3=" + dept_num3 + ", dept_fnum1=" + dept_fnum1 + ", dept_fnum2=" + dept_fnum2
				+ ", dept_fnum3=" + dept_fnum3 + ", active_flg=" + active_flg + ", keyword=" + keyword + "]";
	}

}
