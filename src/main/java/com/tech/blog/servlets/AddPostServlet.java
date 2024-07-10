package com.tech.blog.servlets;

import java.io.Console;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@MultipartConfig
@WebServlet("/addPostServlet")
public class AddPostServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}

	public void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		PrintWriter out = resp.getWriter();
		resp.setContentType("text/html");

		int cId = Integer.parseInt(req.getParameter("cId"));
		String pTitle = req.getParameter("pTitle");
		String pContent = req.getParameter("pContent");
		String pCode = req.getParameter("pCode");
		Part part = req.getPart("pPic");
		String picName = part.getSubmittedFileName();

		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("currentUser");

		Post p = new Post(pTitle, pContent, pCode, picName, null, cId, user.getId());

		PostDao pdao = new PostDao(ConnectionProvider.getConnection());
		if (pdao.savePost(p)) {
			out.println("Done");
			String realPath = getServletContext().getRealPath("/") + "blog_pics" + File.separator + picName;
			Helper.saveProfile(part.getInputStream(), realPath);
		} else {
			out.println("Error");
		}
	}

}
