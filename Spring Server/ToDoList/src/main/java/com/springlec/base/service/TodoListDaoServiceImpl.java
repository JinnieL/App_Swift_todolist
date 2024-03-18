package com.springlec.base.service;

import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springlec.base.dao.TodoListDao;
import com.springlec.base.model.TodoListDto;

@Service
public class TodoListDaoServiceImpl implements TodoListDaoService {
	
	@Autowired
	TodoListDao todoDao;

	@Override
	public JSONObject viewList() throws Exception {
		JSONObject jsonList = new JSONObject();
		JSONArray itemList = new JSONArray();
		
		List<TodoListDto> viewList = todoDao.viewList();
		
		System.out.println("Service Implement");
		
		if (viewList != null) {
			for (int i = 0; i < viewList.size(); i++) {
				JSONObject tempJson =new JSONObject();
				
				tempJson.put("seq", viewList.get(i).getSeq());
	            tempJson.put("userid", viewList.get(i).getUserId());
	            tempJson.put("imagefilename", viewList.get(i).getImageFilename());
	            tempJson.put("content", viewList.get(i).getContent());
	            tempJson.put("viewstatus", viewList.get(i).getViewStatus());
	            tempJson.put("donestatus", viewList.get(i).getDoneStatus());

				itemList.add(tempJson);
			}
			jsonList.put("viewList", itemList); 		// "viewList"가 웹 페이지에서 보임 (results 역할)

		} else {
			jsonList = null;
		}

		return jsonList;

	}

	@Override
	public void insertList(String userid, String imagefilename, String content, int viewstatus, int donestatus)
			throws Exception {
		todoDao.insertList(userid, imagefilename, content, viewstatus, donestatus);
		
	}

	@Override
	public void deleteList(int seq) throws Exception {
		todoDao.deleteList(seq);
		
	}

	// @Override
	// public void updateList(int seq, String userid, String imagefilename, String content, int viewstatus, int donestatus)
	// 		throws Exception {
	// 	todoDao.updateList(seq, userid, imagefilename, content, viewstatus, donestatus);
		
	// }
	@Override
	public void updateList(int seq, String content)
			throws Exception {
		todoDao.updateList(seq, content);
		
	}

	@Override
	public JSONObject searchList(String searchFor) throws Exception {
		JSONObject jsonList = new JSONObject();
		JSONArray itemList = new JSONArray();
		
		searchFor = '%' + searchFor + '%';
		List<TodoListDto> viewList = todoDao.searchList(searchFor);
		
		System.out.println("Service Implement search Query");
		
		if (viewList != null) {
			for (int i = 0; i < viewList.size(); i++) {
				JSONObject tempJson =new JSONObject();
				
				tempJson.put("seq", viewList.get(i).getSeq());
	            tempJson.put("userid", viewList.get(i).getUserId());
	            tempJson.put("imagefilename", viewList.get(i).getImageFilename());
	            tempJson.put("content", viewList.get(i).getContent());
	            tempJson.put("viewstatus", viewList.get(i).getViewStatus());
	            tempJson.put("donestatus", viewList.get(i).getDoneStatus());

				itemList.add(tempJson);
			}
			jsonList.put("viewList", itemList); 		// "viewList"가 웹 페이지에서 보임 (results 역할)

		} else {
			jsonList = null;
		}

		return jsonList;
	}
	
	

}
