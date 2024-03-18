package com.springlec.base.model;

import java.sql.Timestamp;

public class TodoListDto {
	int seq;
	String userId;
	String imageFilename;
	String content;
	int viewStatus;
	int doneStatus;
	Timestamp insertDate;
	
	public TodoListDto() {
		// TODO Auto-generated constructor stub
	}

	
	public TodoListDto(int seq, String userId, String imageFilename, String content, int viewStatus, int doneStatus,
			Timestamp insertDate) {
		super();
		this.seq = seq;
		this.userId = userId;
		this.imageFilename = imageFilename;
		this.content = content;
		this.viewStatus = viewStatus;
		this.doneStatus = doneStatus;
		this.insertDate = insertDate;
	}

	
	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getImageFilename() {
		return imageFilename;
	}

	public void setImageFilename(String imageFilename) {
		this.imageFilename = imageFilename;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getViewStatus() {
		return viewStatus;
	}

	public void setViewStatus(int viewStatus) {
		this.viewStatus = viewStatus;
	}

	public int getDoneStatus() {
		return doneStatus;
	}

	public void setDoneStatus(int doneStatus) {
		this.doneStatus = doneStatus;
	}

	public Timestamp getInsertDate() {
		return insertDate;
	}

	public void setInsertDate(Timestamp insertDate) {
		this.insertDate = insertDate;
	}

}
