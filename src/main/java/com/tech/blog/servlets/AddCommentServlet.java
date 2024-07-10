package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.CommentDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/commentServlet")
public class AddCommentServlet extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}

	public void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		PrintWriter out = resp.getWriter();
		
		System.out.println("hi");
		String commentText = req.getParameter("comment_text");
		System.out.println(commentText);
		int postId = Integer.valueOf(req.getParameter("post_id"));
		System.out.println(postId);
		

		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("currentUser");
		int userId = user.getId();

		CommentDao cdao = new CommentDao(ConnectionProvider.getConnection());
		if (cdao.insertComment(commentText, postId, userId)) {
			out.println("Done");
		} else {
			out.println("Error");
		}

	}

}
