package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDao {
	Connection con;

	public LikeDao(Connection con) {
		this.con = con;
	}

	public boolean insertLike(int postId, int userId) {
		boolean f = false;
		try {
			String query = "insert into liked(pId,uId) values(?,?) ;";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, postId);
			pstmt.setInt(2, userId);
			pstmt.executeUpdate();

			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	public int countLikesOnPost(int postId) {
		int count = 0;

		try {
			String query = "select count(*) from liked where pId = ?  ;";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, postId);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
				System.out.println(count);		}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return count;
	}

	public boolean isLikedByUser(int postId, int userId) {
		boolean f = false;
		try {
			String query = "select count(*) from liked where pId = ? AND uId = ? ;";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, postId);
			pstmt.setInt(2, userId);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	public boolean deleteLike(int postId, int userId) {
		boolean f = false;

		try {
			String query = "delete from liked where pId = ? AND uId = ? ;";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, postId);
			pstmt.setInt(2, userId);
			pstmt.executeUpdate();

			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}
}
