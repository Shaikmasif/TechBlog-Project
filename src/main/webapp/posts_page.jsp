<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.*"%>
<%@page errorPage="error_page.jsp"%>
<div class="row">
	<%
	User user = (User) session.getAttribute("currentUser");
	%>

	<%
	Thread.sleep(1000);
	PostDao post = new PostDao(ConnectionProvider.getConnection());

	int catid = Integer.parseInt(request.getParameter("cid"));

	List<Post> list = null;
	if (catid == 0) {
		list = post.getAllPosts();
	} else {
		list = post.getPostBycatId(catid);
		System.out.println(list);
	}

	if (list.size() == 0) {
		out.println("<h3 class='display-4 text-center'>No Posts In This Category...Try to post</h3>");
		return;
	}

	for (Post p : list) {
	%>
	<div class="col-md-6 mt-3">
		<div class="card">
			<img class="card-img-top img-fluid" style="height: 200px;"
				src="blog_pics/<%=p.getpPic()%>" alt="Card image cap">
			<div class="card-body">
				<b><%=p.getpTitle()%></b>
				<p><%=p.getpContent().substring(0, 20) + "..."%></p>
			</div>
			<div class="card-footer text-center primary-background">


				<%
				LikeDao ld = new LikeDao(ConnectionProvider.getConnection()); 
				%>
				<a href="#!" onclick="doLike(<%=p.getpId() %>,<%=user.getId() %>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="count-likes"> <%= ld.countLikesOnPost(p.getpId()) %></span></a>
				 <a	href="show_blog_page.jsp?pid=<%=p.getpId()%>" class="btn btn-outline-light btn-sm">Read More..</a> 
				 <a href="#!"	class="btn btn-outline-light btn-sm"><i	class="fa fa-commenting-o"></i><span>10</span></a>

			</div>
		</div>
	</div>
	<%
	}
	%>



</div>
