package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.tech.blog.entities.User;

public class UserDao {

	private Connection con;

	public UserDao(Connection con) {
		this.con = con;
	}

	public boolean addUser(User user) {
		boolean f = false;
		try {
			// adding user to database
			String query = "insert into user(name,email,password,gender,about) values(?,?,?,?,?);";

			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getAbout());

			pstmt.executeUpdate();
			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	// fetching data from db by user_email&passsword

	public User getUserByEmailAndPassword(String email, String password) {
		User user = null;
		try {
			String query = "select * from user where email=? and password=?;";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, email);
			pstmt.setString(2, password);

			ResultSet rs = pstmt.executeQuery();

			// i am expecting one user that why if otherwise (while loop)
			if (rs.next()) {
				// fetch data from db
				String name = rs.getString("name");

				// create new user & add data into new user
				user = new User();

				user.setName(name);
				user.setId(rs.getInt("id"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setGender(rs.getString("gender"));
				user.setAbout(rs.getString("about"));
				user.setProfile(rs.getString("profile"));
				user.setRdate(rs.getTimestamp("rdate"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return user;
	}

	public boolean updateUser(User user) {
		boolean f = false;
		String query = "update user set name=? , email=? , password=? , about=? , profile=?  where  id=?    ;";
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getAbout());
			pstmt.setString(5, user.getProfile());

			pstmt.setInt(6, user.getId());
			pstmt.executeUpdate();
			f = true;

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return f;
	}

	public User getUserByUserId(int userId) {
		User user = null;
		try {
			String query = "select * from user where id =? ;";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, userId);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				// fetch data from db
				String name = rs.getString("name");

				// create new user & add data into new user
				user = new User();

				user.setName(name);
				user.setId(rs.getInt("id"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setGender(rs.getString("gender"));
				user.setAbout(rs.getString("about"));
				user.setProfile(rs.getString("profile"));
				user.setRdate(rs.getTimestamp("rdate"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

}
