package com.springlec.base.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;

import com.springlec.base.model.TodoListDto;

public class TodoListDaoImpl implements TodoListDao {
	
	SqlSession sqlSession;
	public static String nameSpace = "com.springlec.base.dao.TodoListDao";
	
//	@Override
//	public List<TodoListDto> viewList(String uid) throws Exception {
//		// TODO Auto-generated method stub
//		return sqlSession.selectList(nameSpace + ".viewList");
//	}

	@Override
	public List<TodoListDto> viewList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(nameSpace + ".viewList");
	}

	@Override
	public void insertList(String userid, String imagefilename, String content, int viewstatus, int donestatus)
			throws Exception {
		sqlSession.insert(nameSpace + ".insertList");
		
	}

	@Override
	public void deleteList(int seq) throws Exception {
		sqlSession.delete(nameSpace + ".deleteList");
		
	}

	// @Override
	// public void updateList(int seq, String userid, String imagefilename, String content, int viewstatus, int donestatus)
	// 		throws Exception {
	// 	sqlSession.update(nameSpace + ".updateList");
		
	// }

	// xml 파일 수정하기
	// <update id="updateList">
	// 	UPDATE todolist 
	// 	SET userid=#{userid}, imagefilename=#{imagefilename}, content=#{content}, viewstatus=#{viewstatus}, donestatus=#{donestatus}
	// 	WHERE seq=#{seq}
	// </update>	

	@Override
	public void updateList(int seq, String content)
			throws Exception {
		sqlSession.update(nameSpace + ".updateList");
		
	}

	@Override
	public List<TodoListDto> searchList(String searchFor) throws Exception {
		return sqlSession.selectList(nameSpace + ".searchList");
	}
	

}
