package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/signup")
@MultipartConfig
public class RegisterServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String check = req.getParameter("check");
		resp.setContentType("text/html");
		PrintWriter out = resp.getWriter();
		if(check==null) {
			out.println("box not checked");
		}else {
			String name = req.getParameter("user_name");
			String email = req.getParameter("user_email");
			String password = req.getParameter("user_password");
			String gender = req.getParameter("gender");
			String about = req.getParameter("about");
			
			//creating user obj and setting values
			User user = new User(name, email, password, gender, about);
			try {
				Thread.sleep(2500);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			//creating dao object
			UserDao udao = new UserDao(ConnectionProvider.getConnection());
			boolean addUser = udao.addUser(user);
			
			if(addUser) {
				out.println("Done");
			}else {
				out.println("error");
			}
		}
		
		
		
		
		
		
	}
	
}
