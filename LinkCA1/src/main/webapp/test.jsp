<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/AddImage" method="post" enctype="multipart/form-data">
		<input type="file" name="imageFile"> <input type="submit"
			value="Upload">
	</form>
	
	<img src="DisplayImage?ISBN=022206676-8" alt="Image">
	

</body>
</html>