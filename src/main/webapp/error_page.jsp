<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page isErrorPage="true" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sorry! Something went wrong..</title>
<!-- css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/mycss.css" type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style type="text/css">
.banner-background {
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 94%, 85% 88%, 16% 98%, 0 86%, 0 0);
}
</style>


</head>
<body>
		<div class="container text-center"> 
		<img src="img/error.png" class="img-fluid"/>
		<h3 class="display-3">Sorry! Something Went Wrong</h3>
		<br>
		<h5><%=exception %></h5>
		<a class="btn btn-outline-light btn-light primary-background bg-light  btn-lg mt-3">Home</a>
		</div>



</body>
</html>