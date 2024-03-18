package com.springlec.base.service;

import org.json.simple.JSONObject;



public interface TodoListDaoService {
//	JSONObject viewList(String uid) throws Exception;
	JSONObject viewList() throws Exception;
	public void insertList(String userid, String imagefilename, String content, int viewstatus, int donestatus) throws Exception;
	public void deleteList(int seq) throws Exception;
	// public void updateList(int seq, String userid, String imagefilename, String content, int viewstatus, int donestatus) throws Exception;
	public void updateList(int seq, String content) throws Exception;
	JSONObject searchList(String searchFor) throws Exception;
}
