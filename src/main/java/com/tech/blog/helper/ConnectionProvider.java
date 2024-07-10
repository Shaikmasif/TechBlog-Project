package com.tech.blog.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionProvider {

	private static Connection con;

	public static Connection getConnection() {

		if (con == null) {
			try {
				// load the driver
				  System.out.println("Loading driver...");
		            Class.forName("com.mysql.cj.jdbc.Driver");
		            System.out.println("Driver loaded successfully.");

				// establish connection
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/techblog", "root", "Database@1234");
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return con;
	}
}
