package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import com.tech.blog.helper.ConnectionProvider;

public class PostDao {

	private Connection con;

	public PostDao(Connection con) {
		super();
		this.con = con;
		System.out.println(con);
	}

	public ArrayList<Category> getAllCategories() {
		ArrayList<Category> list = new ArrayList<>();
		try {
			String query = "select * from categories;";
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(query);
			while (rs.next()) {
				Category c = new Category();
				int id = rs.getInt(1);
				String name = rs.getString(2);
				String desc = rs.getString(3);

				c.setcId(id);
				c.setcName(name);
				c.setcDescription(desc);
				list.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean savePost(Post p) {

		boolean f = false;

		try {
			String query = "insert into posts(pTitle,pContent,pCode,pPic,catId,userId) values (?,?,?,?,?,?) ;";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, p.getpTitle());
			pstmt.setString(2, p.getpContent());
			pstmt.setString(3, p.getpCode());
			pstmt.setString(4, p.getpPic());
			pstmt.setInt(5, p.getCatId());
			pstmt.setInt(6, p.getUserId());

			pstmt.executeUpdate();
			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	// get all posts
	public List<Post> getAllPosts() {
		List<Post> list = new ArrayList<>();

		try {
			String query = "select * from posts order by pId desc ;";
			PreparedStatement pstmt = con.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int pId = rs.getInt("pId");
				String pTitle = rs.getString("pTitle");
				String pContent = rs.getString("pContent");
				String pCode = rs.getString("pCode");
				String pPic = rs.getString("pPic");
				Timestamp pDate = rs.getTimestamp("regDate");
				int catId = rs.getInt("catId");
				int userId = rs.getInt("userId");
				LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
				int likes =ld.countLikesOnPost(pId);

				Post p = new Post(pId, pTitle, pContent, pCode, pPic, pDate, catId, userId,likes);
				System.out.println(p);
				list.add(p);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// get all post by catId
	public List<Post> getPostBycatId(int catId) {
		List<Post> list = new ArrayList<>();

		try {
			String query = "select * from posts where catId=? ;";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, catId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int pId = rs.getInt("pId");
				String pTitle = rs.getString("pTitle");
				String pContent = rs.getString("pContent");
				String pCode = rs.getString("pCode");
				String pPic = rs.getString("pPic");
				Timestamp pDate = rs.getTimestamp("regDate");
				int userId = rs.getInt("userId");

				Post p = new Post(pId, pTitle, pContent, pCode, pPic, pDate, catId, userId);

				list.add(p);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// get post by postId
	public Post getPostByPostId(int pId) {
		Post post = null;

		try {
			String query = "select * from posts where pId=? ;";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, pId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				String pTitle = rs.getString("pTitle");
				String pContent = rs.getString("pContent");
				String pCode = rs.getString("pCode");
				String pPic = rs.getString("pPic");
				Timestamp pDate = rs.getTimestamp("regDate");
				int catId = rs.getInt("catId");
				int userId = rs.getInt("userId");

				post = new Post(pId, pTitle, pContent, pCode, pPic, pDate, catId, userId);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return post;
	}

}
