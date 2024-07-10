package com.tech.blog.servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
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
@WebServlet("/editServlet")
public class EditServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}

	public void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		resp.setContentType("text/html");
		PrintWriter out = resp.getWriter();
		// fetching updated data
		String userName = req.getParameter("user_name");
		String userEmail = req.getParameter("user_email");
		String userPassword = req.getParameter("user_password");
		String userAbout = req.getParameter("user_about");
		Part part = req.getPart("image");
		String imageName = part.getSubmittedFileName();

		// updating new data into session
		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("currentUser");
		user.setName(userName);
		user.setEmail(userEmail);
		user.setPassword(userPassword);
		user.setAbout(userAbout);
		String oldImageName = user.getProfile();
		user.setProfile(imageName);

		UserDao udao = new UserDao(ConnectionProvider.getConnection());
		boolean updatedUser = udao.updateUser(user);

		if (updatedUser) {
			String newFile = getServletContext().getRealPath("/") + "pics" + File.separator + imageName;
			String oldFile = getServletContext().getRealPath("/") + "pics" + File.separator + oldImageName;

			// deleting old profile
			if (!(oldImageName.equals("default-profile.jpg"))) {
				Helper.deleteProfile(oldFile);
			}

			// uploading new profile
			boolean sp = Helper.saveProfile(part.getInputStream(), newFile);

			// alerting
			if (sp) {
				Message msg = new Message("Profile Updated Successfully", "success", "alert-success");
				session.setAttribute("msg", msg);
				resp.sendRedirect("profile.jsp");
			} else {
				Message msg = new Message("Something Went Wrong!!", "danger", "alert-danger");
				session.setAttribute("msg", msg);
				resp.sendRedirect("profile.jsp");
			}
		} else {
			// alerting
			Message msg = new Message("Something Went Wrong!!", "danger", "alert-danger");
			session.setAttribute("msg", msg);
			resp.sendRedirect("profile.jsp");
		}
	}

}
