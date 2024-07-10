<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.*"%>
<%@page import="com.tech.blog.entities.*,java.util.ArrayList"%>
<%@page errorPage="error_page.jsp" %>
<% User user=(User)session.getAttribute("currentUser"); 
    if(user==null){
    	response.sendRedirect("login_page.jsp");
    }
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Profile page</title>
<!-- css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/mycss.css" type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style type="text/css">
body{
	background-image: url("img/bg2.webp");
	background-size: cover;
	background-attachment: fixed;
}
</style>

</head>
<body>
	
<!-- /* 	navbar */ -->
	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
	<a class="navbar-brand" href="index.jsp"> <span class="	fa fa-briefcase"></span>
		TechBlog
	</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link" href="#"> <span
					class="fa fa-caret-square-o-right"></span> Explore Here <span
					class="sr-only">(current)</span>
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

			<li class="nav-item"><a class="nav-link" href="#"> <span class="fa fa-address-book-o"></span> Contact</a></li>
			<li class="nav-item"><a class="nav-link" href="#" data-toggle="modal" data-target="#do-post-modal"> <span class="fa fa-plus"></span> Do Post</a></li>
			
		</ul>
		<ul class="navbar-nav mr-right">
		    <li class="nav-item"><a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal" > <span class="fa fa fa-user-circle"></span> <%=user.getName()%> </a></li>
			<li class="nav-item"><a class="nav-link" href="logoutServlet"> <span class="fa fa fa-user-plus"></span> Logout</a></li>
		</ul>
	</div>
</nav>


<!-- 	end of navbar  -->

<!-- 		alert of bootstrap -->
   
						<%	Message msg=(Message)session.getAttribute("msg");
							if(msg!=null){
								%> 
								<div class="alert <%=msg.getCssStyle() %>" role="alert">
                                <%=msg.getContent() %>
                                </div>
								<%
								session.removeAttribute("msg");
							}
						%>

<!-- 		end alert of bootstrap -->


<!-- 		main body -->

			<div class="container">
			<div class="row">
<!-- 			categories -->
			<div class="col-md-4  text-center">
				
				<div class="list-group mt-4 ">
                  <a href="#" onclick="getPost(0,this)" class="c-link  list-group-item list-group-item-action active"> All Posts</a>
				  <%
				  PostDao p2dao = new PostDao(ConnectionProvider.getConnection());
				  ArrayList<Category> list2= p2dao.getAllCategories();
				  for(Category c2:list2){
				  %>
				      <a href="#" onclick="getPost(<%=c2.getcId() %>,this)" class="c-link  list-group-item list-group-item-action"><%=c2.getcName() %></a>
				  <%
				  } 
				  %>
                 </div>
			
			</div>
<!-- 			posts -->
			<div class="col-md-8  mt-4">
<!-- 				loader -->
				<div class="container text-center" id="loader">
					<i class="fa fa-refresh fa-4x fa-spin " ></i><br>
					<h5>loading...</h5>
				</div>
<!-- 				post -->
				<div class="container-fluid" id="post-content">
					
				</div>
			</div>


			</div>
			
			</div>


<!-- 			end of main body -->




       <!-- modal -->

<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header primary-background">
              <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="container text-center">
        	<img src="pics/<%=user.getProfile() %>" class="img-fluid" style="border-radius: 50%; max-width:140px;"/>
        	<h5 class="modal-title mb-5" id="exampleModalLabel"> <%=user.getName()%> </h5>
  <div id="profile-content">   	
 <table class="table">
  <tbody>
    <tr>
      <th scope="row">Id:</th>
      <td><%=user.getId() %></td>
    </tr>
    <tr>
      <th scope="row">Email:</th>
      <td><%=user.getEmail() %></td>
    </tr>
    <tr>
      <th scope="row">Gender:</th>
      <td><%=user.getGender() %></td>
    </tr>
    <tr>
      <th scope="row">Status:</th>
      <td><%=user.getAbout() %></td>
    </tr><tr>
      <th scope="row">Registered On:</th>
      <td><%=user.getRdate().toLocaleString() %></td>
    </tr>
  </tbody>
</table>
        	
        </div>
        </div>
<!--         profile edit code -->
        <div id="profile-edit" class="container text-center mb-10" style="display:none; ">
        	<h6 class="mb-3">Edit Details Carefully</h6>
        <form action="editServlet" method="post" enctype="multipart/form-data" class="form">
        	<table class="table">
        		<tr>
        		<td>Id:</td>
        		<td><%=user.getId() %></td>
        		</tr>
        		<tr>
        		<td>Name:</td>
        		<td><input class="form-control" type="text" name="user_name" value="<%=user.getName() %>" /></td>
        		</tr>
        		<tr>
        		<td>Email:</td>
        		<td><input class="form-control" type="email" name="user_email" value="<%=user.getEmail() %>" /></td>
        		</tr>
        		<tr>
        		<td>Password:</td>
        		<td><input class="form-control" type="password" name="user_password" value="<%=user.getPassword() %>" /></td>
        		</tr>
        		<tr>
        		<td>Gender:</td>
        		<td><%=user.getGender().toUpperCase() %></td>
        		</tr>
        		<tr>
        		<td>Status:</td>
        		<td><textarea rows="3" name="user_about" class="form-control"><%=user.getAbout() %></textarea> </td>
        		</tr>
        		<tr>
        		<td>New Profile:</td>
        		<td><input type="file" name="image" class="form-control"/> </td>
        		</tr>
        	</table>
        	<button class=" btn btn-outline-primary" type="submit" >Save Changes</button>
        </form>
        
      </div>
        
<!--         end of profile edit code -->
        
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button id="edit-btn" type="button" class="btn btn-primary">Edit</button>
      </div>
    </div>
  </div>
</div>
       
       <!--  end of modal -->
	
	
<!-- 	do post modal -->
           
<!-- Modal -->
<div class="modal fade" id="do-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Provide The Post Details</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="do-post-form" class="form"  method="post" enctype="multipart/form-data">
        	<div class="form-group">
        		<select name="cId" class="form-control">
        			<option  selected disabled>Select Category</option>
        			<%
        			PostDao pdao = new PostDao(ConnectionProvider.getConnection());
        			ArrayList<Category> list = pdao.getAllCategories();
        			for(Category c : list){
        			%>
        			<option value="<%= c.getcId()%>" > <%=c.getcName() %></option>
        			<%	
        			}
        			%>
        		</select>
        	
        	</div>
        	<div class="form-group">
        	<input class="form-control" type="text" name="pTitle" placeholder="Enter Post Title" />
        	</div>
        	<div class="form-group">
			<textarea rows="5" name="pContent" class="form-control" placeholder="Enter Post Content"></textarea>
        	</div>
        	<div class="form-group">
			<textarea rows="5" name="pCode" class="form-control" placeholder="Enter Program Code(if any)"></textarea>
        	</div>
        	<div class="form-group">
        	<label>Select post pic:</label><br>
        	<input class="form-control" name="pPic" type="file"/>
        	</div>
        	<div class="container text-center">
        	<button class="btn btn-outline-primary btn-light  bg-blue btn-lg" type="submit">Post</button>
        	</div>
        </form>
      </div>
      
    </div>
  </div>
</div>
         
<!-- 		end of do post modal -->
	
	
	
	
	
	
	
	<!-- 	     javascripts -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>
	<script	src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script	src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>	
	<script src="script/myjavascript.js" type="text/javascript"></script>	
	
	<!-- Profile-edit java script -->
	<script type="text/javascript">
		
		$(document).ready(function(){
// 			console.log("ready")
			let editStatus=false;
			
			$("#edit-btn").click(function(){
				if(editStatus==false)
				{
				    $("#profile-content").hide();
				    $("#profile-edit").show();
				    editStatus=true;
				    $(this).text("Back")
				}else{
					$("#profile-content").show();
					$("#profile-edit").hide();
					editStatus=false;
					$(this).text("Edit")
				}
			});
		});
	</script>
	
<!-- 	do post script -->
		<script type="text/javascript">
		
		$(document).ready(function(e){
			

			$("#do-post-form").on("submit",function(event){
				console.log("you have clicked on post");

				event.preventDefault();
				
				let form = new FormData(this);
				
				$.ajax({
					url:"addPostServlet",
					type:'post',
					data:form,
					success:function(data,textStatus,jqXHR){
						console.log(data);
						
						if(data.trim()==='Done'){
							swal("Good job!", "Your post is uploaded!", "success");
						}else{
							swal("Sorry!!","Something Went Wrong! Try Again","error");
						}
						
						
					},
					error:function(jqXHR,textStatus,errorThrown){
						console.log(jqXHR);
						console.log("Error in sending");
						swal("Sorry!!","Something Went Wrong! Try Again","error");

					},
					processData:false,
					contentType:false
				});
			});
		});
		</script>
	
	
	
<!-- 	end of do post script -->
	
<!-- 	loader & post-content script -->
         <script type="text/javascript">
			
			function getPost(catId,temp){
				console.log(catId);
				$('.c-link').removeClass('active');
				
				$('#loader').show()
				$('#post-content').hide()
				
				$.ajax({
					url:'posts_page.jsp',
					data:{cid:catId},
					success:function(data,textStatus,jqXHR){
						$('#loader').hide()
						$('#post-content').show()
						$('#post-content').html(data)
						$(temp).addClass('active');
					}
				});
			}
			
			
			$(document).ready(function(e){
				let allpostref=$('.c-link')[0]
				getPost(0,allpostref)
			})
			
         </script> 

<!-- end of	loader & post-content script -->
	
</body>
</html>