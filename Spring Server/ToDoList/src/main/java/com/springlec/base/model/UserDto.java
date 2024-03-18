package com.springlec.base.model;

import java.sql.Timestamp;

public class UserDto {
	String userId;
	String password;
	Timestamp deleteDate;

	public UserDto() {
		// TODO Auto-generated constructor stub
	}

	public UserDto(String userId, String password, Timestamp deleteDate) {
		super();
		this.userId = userId;
		this.password = password;
		this.deleteDate = deleteDate;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Timestamp getDeleteDate() {
		return deleteDate;
	}

	public void setDeleteDate(Timestamp deleteDate) {
		this.deleteDate = deleteDate;
	}
}
