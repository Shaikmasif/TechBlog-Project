package com.tech.blog.entities;

public class Like {
	private int lId;
	private int userId;
	private int postId;
	public Like() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Like(int lId, int userId, int postId) {
		super();
		this.lId = lId;
		this.userId = userId;
		this.postId = postId;
	}
	public Like(int userId, int postId) {
		super();
		this.userId = userId;
		this.postId = postId;
	}
	public int getlId() {
		return lId;
	}
	public void setlId(int lId) {
		this.lId = lId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	
	
	
}
