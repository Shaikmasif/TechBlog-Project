package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequset(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequset(req, resp);
	}

	public void processRequset(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		resp.setContentType("text/html");
		PrintWriter out = resp.getWriter();
		String userEmail = req.getParameter("email");
		String userPassword = req.getParameter("password");
		// creting userdao obj
		UserDao udao = new UserDao(ConnectionProvider.getConnection());
		// send email & password to fetch data
		User u = udao.getUserByEmailAndPassword(userEmail, userPassword);

		if (u == null) {
//			out.println("<h1>Error incorrect email or password</h1>");
			Message msg = new Message("Invalid Email or Password,Try With Another","error","alert-danger");
			HttpSession session = req.getSession();
			session.setAttribute("msg",msg);
			
			resp.sendRedirect("login_page.jsp");
		} else {

			HttpSession session = req.getSession();
			session.setAttribute("currentUser", u);
			resp.sendRedirect("profile.jsp");
		}

	}
}
