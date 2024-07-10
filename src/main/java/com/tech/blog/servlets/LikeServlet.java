package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.LikeDao;
import com.tech.blog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@MultipartConfig
@WebServlet("/likeServlet")
public class LikeServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}

	protected void processRequest(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String operation = req.getParameter("operation");
		int uId = Integer.parseInt(req.getParameter("userId"));
		int pId = Integer.parseInt(req.getParameter("postId"));

		resp.setContentType("text/html");
		PrintWriter out = resp.getWriter();

//		out.println("This is  from server");
//		out.println(operation);
//		out.println(uId+"\n"+pId);

		LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
		if (operation.equals("Like")) {
			boolean f= ldao.insertLike(pId, uId);
				out.println(f);
			}
		

	}

}
