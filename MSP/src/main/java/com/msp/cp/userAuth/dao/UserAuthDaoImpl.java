package com.msp.cp.userAuth.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.msp.cp.auth.vo.AuthVO;
import com.msp.cp.userAuth.vo.UserAuthVO;

@Repository
public class UserAuthDaoImpl implements UserAuthDao{
	
	@Resource(name = "sqlSession")
	private SqlSession sqlSession;

	public void setSqlSessionTemplate(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//사용자권한 리스트 조회
	@Override
    public List<UserAuthVO> userAuthList(Map<String, Object> map) {
    	List<UserAuthVO> list = null;
    	try {
    		list = sqlSession.selectList("userAuth.userAuthList", map);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return list;
    }
    
	//사용자권한 리스트 행 수
    @Override
	public int getUserAuthCount(Map<String, Object> map) {
		
		int count = sqlSession.selectOne("userAuth.userAuthCount", map);
		
		return count;
	}
    
    //권한 리스트
  	@Override
    public List<AuthVO> authList(Map<String, Object> map) {
      	List<AuthVO> list = null;
      	try {
      		list = sqlSession.selectList("userAuth.authList", map);
      	} catch (Exception e) {
      		e.printStackTrace();
      	}
      	return list;
    }
  	
  	//상세 사용자권한 리스트
  	@Override
  	public List<AuthVO> user_authList(Map<String, Object> map) {
  		List<AuthVO> list = null;
  		try {
  			list = sqlSession.selectList("userAuth.user_authList", map);
  		} catch (Exception e) {
  			e.printStackTrace();
  		}
  		return list;
  	}
    
    //사용자권한 상세 확인
    @Override
    public UserAuthVO openUserAuthDetail(String user_id){
    	UserAuthVO uav = new UserAuthVO();
		try{
			uav=sqlSession.selectOne("userAuth.userAuthDetail",user_id);
		}catch(Exception e){
			e.printStackTrace();
		}
		return uav;
	}
    
    //새 사용자권한 등록
    @Override
	public int createUserAuth(UserAuthVO userAuthVO) {
		int result=0;
		try {
			 result = sqlSession.insert("userAuth.createUserAuth", userAuthVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
    
    //사용자권한 수정
    @Override
	public int updateUserAuth(UserAuthVO userAuthVO) {
		int result=0;
		try {
			 result = sqlSession.update("userAuth.updateUserAuth", userAuthVO);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return result;
	}
    
    //사용자권한 삭제
    @Override
    public int deleteUserAuth(UserAuthVO userAuthVO) {
    	int result=0;
    	try {
    		result = sqlSession.update("userAuth.deleteUserAuth", userAuthVO);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}		
    	return result;
    }
    
    //사용자ID 확인
	@Override
	public UserAuthVO getUserId(Map<String, Object> map){
		UserAuthVO uav = new UserAuthVO();
		try{
			uav=sqlSession.selectOne("userAuth.getUserId",map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return uav;
	}

}
