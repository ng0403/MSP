package com.crm.cp.test.user.vo;

import org.springframework.stereotype.Component;

@Component
public class userVO {
		String USER_ID;
		String PWD;
		String USER_NAME;
		String EMAIL;
		String CELL_PHONE;
		String HOME_PHONE;
		String COMPANY_PHONE;
		String P_CHANNEL_CD;
		String USER_TYPE_CD;
		String ORG_ID;
		String ACTIVE_FLG;
		
		
		public String getUSER_ID() {
			return USER_ID;
		}
		public void setUSER_ID(String uSER_ID) {
			USER_ID = uSER_ID;
		}
		public String getPWD() {
			return PWD;
		}
		public void setPWD(String pWD) {
			PWD = pWD;
		}
		public String getUSER_NAME() {
			return USER_NAME;
		}
		public void setUSER_NAME(String uSER_NAME) {
			USER_NAME = uSER_NAME;
		}
		public String getEMAIL() {
			return EMAIL;
		}
		public void setEMAIL(String eMAIL) {
			EMAIL = eMAIL;
		}
		public String getCELL_PHONE() {
			return CELL_PHONE;
		}
		public void setCELL_PHONE(String cELL_PHONE) {
			CELL_PHONE = cELL_PHONE;
		}
		public String getHOME_PHONE() {
			return HOME_PHONE;
		}
		public void setHOME_PHONE(String hOME_PHONE) {
			HOME_PHONE = hOME_PHONE;
		}
		public String getCOMPANY_PHONE() {
			return COMPANY_PHONE;
		}
		public void setCOMPANY_PHONE(String cOMPANY_PHONE) {
			COMPANY_PHONE = cOMPANY_PHONE;
		}
		public String getP_CHANNEL_CD() {
			return P_CHANNEL_CD;
		}
		public void setP_CHANNEL_CD(String p_CHANNEL_CD) {
			P_CHANNEL_CD = p_CHANNEL_CD;
		}
		public String getUSER_TYPE_CD() {
			return USER_TYPE_CD;
		}
		public void setUSER_TYPE_CD(String uSER_TYPE_CD) {
			USER_TYPE_CD = uSER_TYPE_CD;
		}
		public String getORG_ID() {
			return ORG_ID;
		}
		public void setORG_ID(String oRG_ID) {
			ORG_ID = oRG_ID;
		}
		public String getACTIVE_FLG() {
			return ACTIVE_FLG;
		}
		public void setACTIVE_FLG(String aCTIVE_FLG) {
			ACTIVE_FLG = aCTIVE_FLG;
		}
		@Override
		public String toString() {
			return "userVO [USER_ID=" + USER_ID + ", PWD=" + PWD + ", USER_NAME=" + USER_NAME + ", EMAIL=" + EMAIL
					+ ", CELL_PHONE=" + CELL_PHONE + ", HOME_PHONE=" + HOME_PHONE + ", COMPANY_PHONE=" + COMPANY_PHONE
					+ ", P_CHANNEL_CD=" + P_CHANNEL_CD + ", USER_TYPE_CD=" + USER_TYPE_CD + ", ORG_ID=" + ORG_ID
					+ ", ACTIVE_FLG=" + ACTIVE_FLG + "]";
		}
		
		
}

