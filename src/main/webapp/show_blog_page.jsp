<%@page import="com.tech.blog.dao.CommentDao"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.*"%>
<%@page errorPage="error_page.jsp"%>
<!-- verify if user is logged in -->
<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("login_page.jsp");
}
%>

<%
int pId = Integer.parseInt(request.getParameter("pid"));
PostDao pdao = new PostDao(ConnectionProvider.getConnection());
Post post = pdao.getPostByPostId(pId);
%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%=post.getpTitle()%></title>
<!-- css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/mycss.css" type="text/css">
<!-- Font Awesome CDN for icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style type="text/css">
.post-title {
	font-weight: 100;
	font-size: 30px;
}

.post-user-info {
	font-weight: 400;
	font-size: 18px;
}

.post-date {
	font-weight: 600;
}

.post-content {
	font-weight: 100;
	font-size: 25px;
}

.post-code {
	font-weight: bold;
	font-size: 20px;
}

body {
	background-image: url("img/bg2.webp");
	background-size: cover;
	background-attachment: fixed;
}

.comment {
	background-color: #ffffff;
	border: 1px solid #dee2e6;
	border-radius: 5px;
	padding: 10px; /* Smaller padding */
	margin-bottom: 10px; /* Smaller margin */
}

.comment small {
	display: block; /* Place the timestamp on a new line */
	color: #868e96;
	/* Move timestamp to the right */
	margin-left: auto;
}
</style>


<script src="script/myjavascript.js"></script>
</head>
<body>


	<!-- /* 	navbar */ -->
	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<a class="navbar-brand" href="index.jsp"> <span
			class="	fa fa-briefcase"></span> TechBlog
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link"
					href="profile.jsp"> <span class="fa fa-caret-square-o-right"></span>
						Explore Here <span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <span class="fa fa-check-square-o"></span>
						Categories
				</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Programming</a> <a
							class="dropdown-item" href="#">Data Structures</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Something else here</a>
					</div></li>

				<li class="nav-item"><a class="nav-link" href="#"> <span
						class="fa fa-address-book-o"></span> Contact
				</a></li>

			</ul>
			<ul class="navbar-nav mr-right">
				<li class="nav-item"><a class="nav-link" href="#!"
					data-toggle="modal" data-target="#profile-modal"> <span
						class="fa fa fa-user-circle"></span> <%=user.getName()%>
				</a></li>
				<li class="nav-item"><a class="nav-link" href="logoutServlet">
						<span class="fa fa fa-user-plus"></span> Logout
				</a></li>
			</ul>
		</div>
	</nav>


	<!-- 	end of navbar  -->

	<!-- 		alert of bootstrap -->

	<%
	Message msg = (Message) session.getAttribute("msg");
	if (msg != null) {
	%>
	<div class="alert <%=msg.getCssStyle()%>" role="alert">
		<%=msg.getContent()%>
	</div>
	<%
	session.removeAttribute("msg");
	}
	%>

	<!-- 		end alert of bootstrap -->



	<!-- 	main content of the body -->

	<div class="container">
		<div class="row my-4">
			<div class="col-md-8 offset-md-2">
				<div class="card">
					<div class="card-header primary-background text-light">
						<h4 class="post-title"><%=post.getpTitle()%></h4>
					</div>


					<div class="card-body">

						<div class="container">
							<img class="my-4 card-img-top img-fluid " style="height: 300px;"
								src="blog_pics/<%=post.getpPic()%>" alt="Card image cap">
						</div>

						<div class="row"
							style="border: 1px solid #e2e2e2; padding-top: 15px;">
							<div class="col-md-8">
								<%
								UserDao udao = new UserDao(ConnectionProvider.getConnection());
								String name = udao.getUserByUserId(post.getUserId()).getName();
								%>
								<p class="post-user-info">
									<a href="#"><%=name%></a> has Posted on:
								</p>
							</div>
							<div class="col-md-4">
								<p class="post-date"><%=DateFormat.getDateTimeInstance().format(post.getRegDate())%></p>
							</div>
						</div>

						<p class="post-content"><%=post.getpContent()%></p>
						<br> <br>
						<pre class="post-code"><%=post.getpCode()%></pre>
					</div>
					<div class="card-footer primary-background">
						<%
						LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
						%>
						<a href="#!"
							onclick="doLike(<%=post.getpId()%>,<%=user.getId()%>)"
							class="btn btn-outline-light btn-sm"> <i
							class="fa fa-thumbs-o-up"></i><span class="count-likes"> <%=ld.countLikesOnPost(post.getpId())%></span></a>
						<%
					CommentDao cdao = new CommentDao(ConnectionProvider.getConnection());
					List<Comment> comments = cdao.fetchAllCommentsByPostId(pId);
					%>
						<a href="#!" id="toggleComments" class="btn btn-outline-light btn-sm"> <i
							class="fa fa-commenting-o"></i><span> <%= cdao.countCommentsByPostId(pId) %></span></a>

					</div>

					

					<div class="card-footer" id="commentsContainer">
						<h3>Comments:</h3>
						<div class="comment-container" >
							<%
							for (Comment c : comments) {
							%>


							<%
							// Fetch the username associated with the userId
							User user1 = udao.getUserByUserId(c.getUserId());
							String username = (user1 != null) ? user1.getName() : "Unknown User";
							%>
							<div class="comment">
								<p>
									<strong><%=username%>:</strong>
									<%=c.getCommentText()%></p>
								<small><%=c.getTime().toLocaleString()%></small>
							</div>
							<%
							}
							%>
						</div>

						<!-- Form to add a new comment -->
						<!-- New Comment Form -->
						<div class="comment-form">
							<form action="commentServlet" method="post" id="form-comment">
								<input type="hidden" name="post_id" value="<%=post.getpId()%>">
								<div class="form-group">
									<label for="commentText">Add a Comment:</label>
									<div class="input-group">
										<textarea class="form-control" id="commentText"
											name="comment_text" rows="2" required></textarea>
										<div class="input-group-append">
											<button type="submit" class="btn btn-primary">
												<i class="fas fa-paper-plane"></i>
												<!-- Font Awesome send icon -->
											</button>
										</div>
									</div>
								</div>
							</form>
						</div>

					</div>
					<!-- card footer end -->


				</div>
			</div>
		</div>
	</div>

	<!--  end of main content of the body -->


	<!-- modal -->

	<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header primary-background">
					<h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img src="pics/<%=user.getProfile()%>" class="img-fluid"
							style="border-radius: 50%; max-width: 140px;" />
						<h5 class="modal-title mb-5" id="exampleModalLabel">
							<%=user.getName()%>
						</h5>
						<div id="profile-content">
							<table class="table">
								<tbody>
									<tr>
										<th scope="row">Id:</th>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<th scope="row">Email:</th>
										<td><%=user.getEmail()%></td>
									</tr>
									<tr>
										<th scope="row">Gender:</th>
										<td><%=user.getGender()%></td>
									</tr>
									<tr>
										<th scope="row">Status:</th>
										<td><%=user.getAbout()%></td>
									</tr>
									<tr>
										<th scope="row">Registered On:</th>
										<td><%=user.getRdate().toLocaleString()%></td>
									</tr>
								</tbody>
							</table>

						</div>
					</div>
					<!--         profile edit code -->
					<div id="profile-edit" class="container text-center mb-10"
						style="display: none;">
						<h6 class="mb-3">Edit Details Carefully</h6>
						<form action="editServlet" method="post"
							enctype="multipart/form-data" class="form">
							<table class="table">
								<tr>
									<td>Id:</td>
									<td><%=user.getId()%></td>
								</tr>
								<tr>
									<td>Name:</td>
									<td><input class="form-control" type="text"
										name="user_name" value="<%=user.getName()%>" /></td>
								</tr>
								<tr>
									<td>Email:</td>
									<td><input class="form-control" type="email"
										name="user_email" value="<%=user.getEmail()%>" /></td>
								</tr>
								<tr>
									<td>Password:</td>
									<td><input class="form-control" type="password"
										name="user_password" value="<%=user.getPassword()%>" /></td>
								</tr>
								<tr>
									<td>Gender:</td>
									<td><%=user.getGender().toUpperCase()%></td>
								</tr>
								<tr>
									<td>Status:</td>
									<td><textarea rows="3" name="user_about"
											class="form-control"><%=user.getAbout()%></textarea></td>
								</tr>
								<tr>
									<td>New Profile:</td>
									<td><input type="file" name="image" class="form-control" />
									</td>
								</tr>
							</table>
							<button class=" btn btn-outline-primary" type="submit">Save
								Changes</button>
						</form>

					</div>

					<!--         end of profile edit code -->

				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button id="edit-btn" type="button" class="btn btn-primary">Edit</button>
				</div>
			</div>
		</div>
	</div>

	<!--  end of modal -->



	<!-- 	     javascripts -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" type="text/javascript"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	


	<script type="text/javascript">
		$(document).ready(function() {
			//console.log("ready")
			let editStatus = false;

			$("#edit-btn").click(function() {
				if (editStatus == false) {
					$("#profile-content").hide();
					$("#profile-edit").show();
					editStatus = true;
					$(this).text("Back")
				} else {
					$("#profile-content").show();
					$("#profile-edit").hide();
					editStatus = false;
					$(this).text("Edit")
				}
			});
		});
	</script>

<!-- Script for comment section -->
<script>
    $(document).ready(function () {
    	$("#commentsContainer").hide();
    	let status = false;
        $("#toggleComments").on("click", function () {
        	if(status==false){
        	$("#commentsContainer").show();
        	status = true;
        	}else{
        		$("#commentsContainer").hide();
        		status = false;
        	}
        });
        
     
    });
</script>



<script>
$(document).ready(function(e){
			console.log("loaded...");
			
			$('#form-comment').on('submit',function(event){
				console.log("you have clicked on button");
				event.preventDefault();
				
				let form = new FormData(this);
				//printing whatever we are fetching
				for (let pair of form.entries()) {
			        console.log(pair[0] + ': ' + pair[1]);
			    }
				
				$.ajax({
					url:'commentServlet',
					type:"POST",
					data:form,
					success:function(data,textStatus,jqXHR){
						
						
					    if(data.trim()==='Done'){	
					    	console.log(data);
					    	window.location = "show_blog_page.jsp";
					    }	
				    },
					error:function(jqXHR,textStatus,errorThrown){
						console.log(jqXHR);
						window.location.href = "show_blog_page.jsp";
					},
					processData:false,
					contentType:false
				});
			});
			
});
	
	</script>
	

</body>
</html>