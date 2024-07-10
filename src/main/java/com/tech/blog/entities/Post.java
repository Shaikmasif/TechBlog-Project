package com.tech.blog.entities;

import java.sql.Timestamp;

public class Post {
	private int pId;
	private String pTitle;
	private String pContent;
	private String pCode;
	private String pPic;
	private Timestamp regDate;
	private int catId;
	private int userId;
	private int likes;

	public Post() {
		super();
	}

	public Post(int pId, String pTitle, String pContent, String pCode, String pPic, Timestamp regDate, int catId,
			int userId, int likes) {
		super();
		this.pId = pId;
		this.pTitle = pTitle;
		this.pContent = pContent;
		this.pCode = pCode;
		this.pPic = pPic;
		this.regDate = regDate;
		this.catId = catId;
		this.userId = userId;
		this.likes = likes;
	}

	public int getpId() {
		return pId;
	}

	public void setpId(int pId) {
		this.pId = pId;
	}

	public String getpTitle() {
		return pTitle;
	}

	public void setpTitle(String pTitle) {
		this.pTitle = pTitle;
	}

	public String getpContent() {
		return pContent;
	}

	public void setpContent(String pContent) {
		this.pContent = pContent;
	}

	public String getpCode() {
		return pCode;
	}

	public void setpCode(String pCode) {
		this.pCode = pCode;
	}

	public String getpPic() {
		return pPic;
	}

	public void setpPic(String pPic) {
		this.pPic = pPic;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	public int getCatId() {
		return catId;
	}

	public void setCatId(int catId) {
		this.catId = catId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getLikes() {
		return likes;
	}

	public void setLikes(int likes) {
		this.likes = likes;
	}

	@Override
	public String toString() {
		return "Post [pId=" + pId + ", pTitle=" + pTitle + ", pContent=" + pContent + ", pCode=" + pCode + ", pPic="
				+ pPic + ", regDate=" + regDate + ", catId=" + catId + ", userId=" + userId + ", likes=" + likes + "]";
	}

	public Post(int pId, String pTitle, String pContent, String pCode, String pPic, Timestamp regDate, int catId,
			int userId) {
		super();
		this.pId = pId;
		this.pTitle = pTitle;
		this.pContent = pContent;
		this.pCode = pCode;
		this.pPic = pPic;
		this.regDate = regDate;
		this.catId = catId;
		this.userId = userId;
	}

	public Post(String pTitle, String pContent, String pCode, String pPic, Timestamp regDate, int catId, int userId) {
		super();
		this.pTitle = pTitle;
		this.pContent = pContent;
		this.pCode = pCode;
		this.pPic = pPic;
		this.regDate = regDate;
		this.catId = catId;
		this.userId = userId;
	}

	}
