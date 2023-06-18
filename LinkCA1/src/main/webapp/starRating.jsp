<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://kit.fontawesome.com/32cc75cfc0.js"
	crossorigin="anonymous"></script>
<title>Insert title here</title>
</head>
<body>
	<div class="flex items-center mb-5">
		
		<%
		int rating = Integer.parseInt(request.getParameter("rating"));
		int coloured = rating;
		int nonColoured = 5 - rating;
		
		for (int i = 0; i < coloured; i++) {
		%>
		<!-- Coloured Stars -->
		<svg aria-hidden="true" class="w-5 h-5 text-yellow-400"
			fill="currentColor" viewBox="0 0 20 20"
			xmlns="http://www.w3.org/2000/svg">
								<title>Star</title><path
				d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
		<%
		}
		%>

		
		<%
		for (int i = 0; i < nonColoured; i++) {
		%>
		<!-- Non Coloured Stars -->
		<svg aria-hidden="true"
			class="w-5 h-5 text-gray-300 dark:text-gray-500" fill="currentColor"
			viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
									<title>Star</title><path
				d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
		<%
		}
		%>
	</div>
</body>
</html>