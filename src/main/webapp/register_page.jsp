<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SignUp Page</title>

<!-- css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/mycss.css" type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style type="text/css">
.banner-background{
clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 94%, 85% 88%, 16% 98%, 0 86%, 0 0);
}
</style>

</head>
<body>
	
<!-- 	navbar -->
	<%@include file="normal_navbar.jsp" %>	
	
	
	<main class=" primary-background banner-background " style="padding-bottom: 80px;">
	<div class="container" >
	<div class="col-md-6 offset-md-3" >
	<div class="card">
	<div class="card-header  primary-background text-center text-white">
	<span class="fa fa-user-circle fa-4x"></span><br>
	Register Here
	</div>
	<div class="card-body">
	
	<form id="reg-form" action="signup" method="post">
  
  <div class="form-group">
    <label for="User_name">User Name</label>
    <input name="user_name" type="text" class="form-control" id="user_name" aria-describedby="nameHelp" placeholder="Enter Name">
  </div>
  
  <div class="form-group">
    <label for="exampleInputEmail1">Email address</label>
    <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
  </div>
  
  
  <div class="form-group">
    <label for="exampleInputPassword1">Password</label>
    <input name="user_password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
  </div>
  
  <div class="form-group">
  <label for="gender">Gender</label><br>
  <input type="radio" name="gender" value="male" id="gender" />Male &nbsp;
  <input type="radio" name="gender" value="female" id="gender" />Female
  </div>
  	
  <div class="form-group">
	<textarea name="about" class="form-control" rows="3" placeholder="Write about yourself"></textarea>
  </div>
  	
  <div class="form-check">
    <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
    <label class="form-check-label" for="exampleCheck1">agree terms and conditions</label>
  </div>
  
  <div id="loader" class="container text-center" style="display: none;">
  <span class="fa fa-refresh fa-spin fa-4x " ></span><br>
  Please Wait..
  </div>
  
  <button id="reg-btn" type="submit" class="btn btn-outline-light btn-light primary-background mt-2 bg-light">Submit</button>

</form>
	</div>
	</div>
	</div>
	</div>
	</main>	
	
	
	
	
	
	
	
	
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
	
	<script type="text/javascript">
		
		$(document).ready(function(){
			console.log("loaded...");
			
			$('#reg-form').on('submit',function(event){
				
				event.preventDefault();
				
				let form = new FormData(this);
				
				$('#reg-btn').hide();
				$('#loader').show();
				
				$.ajax({
					url:'signup',
					type:'post',
					data:form,
					success:function(data,textStatus,jqXHR){
						console.log(data);
						
						  $('#reg-btn').show();
						  $('#loader').hide();
						
					    if(data.trim()==='Done'){	
						    swal("Registered Successfully, We are redirecting to login page")
						    .then((value) => {
						    window.location="login_page.jsp";
						    });
						   
					    }else{
						   swal(data);
					     }	
				    },
					error:function(jqXHR,textStatus,errorThrown){
						console.log(jqXHR);
						
						$('#reg-btn').show();
						$('#loader').hide();
						swal("Sorry! Something went wrong..");
					},
					processData:false,
					contentType:false
					
				});
				
				
				
			});
			
		
		
		});
		
	
	
	
	
	
	</script>
	
	
	
	
	
	
	
	
	
</body>
</html>