package com.msp.cp.common.SessionAuth;

import java.util.List;
import java.util.Map;

public interface SessionAuthDao {

	List<SessionAuthVO> sessionInqr(Map<String, Object> map);

}
