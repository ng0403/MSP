package com.msp.cp.board.vo;

import java.sql.Date;

public class BoardVO {
	
	private String board_no;
	private String board_mng_no;
	private String file_cd;
	private String title;
	private String content;
	private String view_cnt;
	private String question_type_cd;
	private String answer_flg;
	private String active_flg;
	private String del_flg;
	private String created_by;
	private Date created;
	private String updated_by;
	private Date updated; 
	
	public String getBoard_no() {
		return board_no;
	} 


	public void setBoard_no(String board_no) {
		this.board_no = board_no;
	} 

	public String getBoard_mng_no() {
		return board_mng_no;
	} 

	public void setBoard_mng_no(String board_mng_no) {
		this.board_mng_no = board_mng_no;
	} 
	public String getFile_cd() {
		return file_cd;
	} 
	public void setFile_cd(String file_cd) {
		this.file_cd = file_cd;
	} 

	public String getTitle() {
		return title;
	} 

	public void setTitle(String title) {
		this.title = title;
	}
  
	public String getContent() {
		return content;
	}
  
	public void setContent(String content) {
		this.content = content;
	} 
	public String getView_cnt() {
		return view_cnt;
	} 
	public void setView_cnt(String view_cnt) {
		this.view_cnt = view_cnt;
	} 
	public String getQuestion_type_cd() {
		return question_type_cd;
	}  
	public void setQuestion_type_cd(String question_type_cd) {
		this.question_type_cd = question_type_cd;
	} 
	public String getAnswer_flg() {
		return answer_flg;
	} 
	public void setAnswer_flg(String answer_flg) {
		this.answer_flg = answer_flg;
	} 
	public String getActive_flg() {
		return active_flg;
	} 
	public void setActive_flg(String active_flg) {
		this.active_flg = active_flg;
	} 
	public String getDel_flg() {
		return del_flg;
	} 
	public void setDel_flg(String del_flg) {
		this.del_flg = del_flg;
	} 
	public String getCreated_by() {
		return created_by;
	} 
	public void setCreated_by(String created_by) {
		this.created_by = created_by;
	}  
	public Date getCreated() {
		return created;
	} 
	public void setCreated(Date created) {
		this.created = created;
	} 
	public String getUpdated_by() {
		return updated_by;
	}  
	public void setUpdated_by(String updated_by) {
		this.updated_by = updated_by;
	} 
	public Date getUpdated() {
		return updated;
	} 

	public void setUpdated(Date updated) {
		this.updated = updated;
	} 
	@Override
	public String toString() {
		return "BoardVO [board_no=" + board_no + ", board_mng_no=" + board_mng_no + ", file_cd=" + file_cd + ", title="
				+ title + ", content=" + content + ", view_cnt=" + view_cnt + ", question_type_cd=" + question_type_cd
				+ ", answer_flg=" + answer_flg + ", active_flg=" + active_flg + ", del_flg=" + del_flg + ", created_by="
				+ created_by + ", created=" + created + ", updated_by=" + updated_by + ", updated=" + updated + "]";
	}
	
	 
	
  
}
