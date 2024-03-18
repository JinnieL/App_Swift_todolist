package com.springlec.base.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.springlec.base.model.TodoListDto;
import com.springlec.base.service.TodoListDaoService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class TodoListController {
	
	@Autowired
	TodoListDaoService service ;
	
	// 모든 투두리스트 불러오기
	@RequestMapping("/todolist")
	public String viewList(HttpServletRequest request, Model model) throws Exception {
		String userid = request.getParameter("userid");
		JSONObject viewList = service.viewList();
		
		model.addAttribute("viewList", viewList);
		return "viewList";		
	}
	
	@PostMapping("/uploadImage")
	public void imageName(MultipartHttpServletRequest multipartRequest) throws IOException{
		String directory = System.getProperty("user.dir") + "/src/main/resources/static/images/";
		MultipartFile imageFile = multipartRequest.getFile("imageFile");
		String imageFileName = imageFile.getOriginalFilename();
		
		File file = new File(directory, imageFileName);
		imageFile.transferTo(file);
		System.out.println(imageFileName);
		
	}
	
	
	@RequestMapping("/insert")
	public void insertList(HttpServletRequest request, Model model) throws Exception{
		String userid = request.getParameter("userid");
		String imagefilename = request.getParameter("imagefilename");
		String content = request.getParameter("content");
		int viewstatus = Integer.parseInt(request.getParameter("viewstatus"));
		int donestatus = Integer.parseInt(request.getParameter("donestatus"));
		
		service.insertList(userid, imagefilename, content, viewstatus, donestatus);
	}
	
	@RequestMapping("/update")
	public void updateList(HttpServletRequest request, Model model) throws Exception{
		int seq = Integer.parseInt(request.getParameter("seq"));
		// String userid = request.getParameter("userid");
		// String imagefilename = request.getParameter("imagefilename");
		String content = request.getParameter("content");
		// int viewstatus = Integer.parseInt(request.getParameter("viewstatus"));
		// int donestatus = Integer.parseInt(request.getParameter("donestatus"));
		
		// service.updateList(seq, userid, imagefilename, content, viewstatus, donestatus);
		service.updateList(seq, content);
	}
	
	@RequestMapping("/delete")
	public void deleteList(HttpServletRequest request, Model model) throws Exception{
		int seq = Integer.parseInt(request.getParameter("seq"));
		service.deleteList(seq);;
	}
	
	@RequestMapping("/search")
	public String searchList(HttpServletRequest request, Model model) throws Exception {
		String searchFor = request.getParameter("searchFor");
		JSONObject searchList = service.searchList(searchFor);
		
		model.addAttribute("viewList", searchList);
		return "viewList";		
	}
	
	

}
