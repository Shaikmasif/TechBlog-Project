package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tech.blog.entities.*;

public class CommentDao {

	Connection con;

	public CommentDao(Connection con) {
		super();
		this.con = con;
	}

	// inserting comments into the table
	public boolean insertComment(String commentText, int postId, int userId) {
		boolean f = false;
		try {
			String sql = "insert into comments(commentText,postId,userId) values(? ,? ,?) ;";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, commentText);
			pstmt.setInt(2, postId);
			pstmt.setInt(3, userId);
			pstmt.executeUpdate();
			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	// retrieving comments from the table
	public List<Comment> fetchAllCommentsByPostId(int postId) {
		List<Comment> commentList = new ArrayList<>();
		try {
			String sql = "select * from comments where postId = ? ;";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, postId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int commentId = rs.getInt("commentId");
				String commentText = rs.getString("commentText");
				int pId = rs.getInt("postId");
				int userId = rs.getInt("userId");
				Timestamp time = rs.getTimestamp("time");
				// creating comment object
				Comment comment = new Comment(commentId, commentText, pId, userId, time);
				// putting object in list
				commentList.add(comment);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return commentList;
	}

	public int countCommentsByPostId(int postId) {
		int count = 0;
		try {
			String sql = "select count(*) from comments where postId = ? ;";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, postId);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				count=rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
}
