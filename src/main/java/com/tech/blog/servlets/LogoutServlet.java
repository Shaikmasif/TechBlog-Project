package com.tech.blog.servlets;

import java.io.IOException;

import com.tech.blog.entities.Message;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/logoutServlet")
public class LogoutServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}

	public void processRequest(HttpServletRequest req, HttpServletResponse resp) throws IOException ,ServletException{

		HttpSession session = req.getSession();
		session.removeAttribute("currentUser");
		
		Message msg = new Message("Logout Successfully","success","alert-success");
		
		session.setAttribute("msg", msg);
		resp.sendRedirect("login_page.jsp");
	}

}
