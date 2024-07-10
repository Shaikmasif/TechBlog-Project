package com.tech.blog.entities;

import java.sql.Timestamp;

public class Comment {
	private int commentId;
	private String commentText;
	private int postId;
	private int userId;
	private Timestamp time;

	public Comment() {
		super();
	}

	public Comment(int commentId, String commentText, int postId, int userId, Timestamp time) {
		super();
		this.commentId = commentId;
		this.commentText = commentText;
		this.postId = postId;
		this.userId = userId;
		this.time = time;
	}

	public Comment(String commentText, int postId, int userId, Timestamp time) {
		super();
		this.commentText = commentText;
		this.postId = postId;
		this.userId = userId;
		this.time = time;
	}

	public int getCommentId() {
		return commentId;
	}

	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}

	public String getCommentText() {
		return commentText;
	}

	public void setCommentText(String commentText) {
		this.commentText = commentText;
	}

	public int getPostId() {
		return postId;
	}

	public void setPostId(int postId) {
		this.postId = postId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public Timestamp getTime() {
		return time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

}
