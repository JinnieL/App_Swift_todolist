package com.springlec.base.dao;

import java.util.List;

import org.json.simple.JSONObject;

import com.springlec.base.model.TodoListDto;

public interface TodoListDao {
//	public List<TodoListDto> viewList(String uid) throws Exception;
	public List<TodoListDto> viewList() throws Exception;
	public void insertList(String userid, String imagefilename, String content, int viewstatus, int donestatus) throws Exception;
	public void deleteList(int seq) throws Exception;
	// public void updateList(int seq, String userid, String imagefilename, String content, int viewstatus, int donestatus) throws Exception;
	public void updateList(int seq, String content) throws Exception;
	public List<TodoListDto> searchList(String searchFor) throws Exception;
}
