<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*, classes.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="./css/adminPage.css" />
<script src="./js/addBook.js"></script>
<title>Document</title>
</head>
<body>
	<%
	if (session.getAttribute("userRole") != (null) && session.getAttribute("userRole").equals("admin")) {
	%>
	<!--Navigation Bar-->
	<jsp:include page="adminNavBar.jsp"></jsp:include>

	<!--Main Body page-->
	<div class="container mx-auto w-2/3 md:min-w-screen rounded-lg p-10">
		<%
		User u = (User) request.getAttribute("customerD");
		%>
		<form
			action="<%=request.getContextPath()%>/AdminUpdateUser?id=<%=u.getCustomer_id()%>"
			method="post">

			<!--Header-->
			<div class="grid grid-cols-2">
				<div>
					<h2 class="text-4xl md:text-3xl,text-bold  text-white ">Update <%=u.getFullName() %>
						Details</h2>
				</div>
				<div class="text-end">
					<input type="reset"
						class="rounded bg-white text-end text-gray-900 bg-white border border-gray-300 focus:outline-none hover:bg-gray-100 focus:ring-4 focus:ring-gray-200 font-medium rounded-full text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-gray-800 dark:text-white dark:border-gray-600 dark:hover:bg-gray-700 dark:hover:border-gray-600 dark:focus:ring-gray-700" />
					<input type="submit" name="submit" id="submit"
						class="rounded bg-white text-end text-gray-900 bg-white border border-gray-300 focus:outline-none hover:bg-gray-100 focus:ring-4 focus:ring-gray-200 font-medium rounded-full text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-gray-800 dark:text-white dark:border-gray-600 dark:hover:bg-gray-700 dark:hover:border-gray-600 dark:focus:ring-gray-700" />
				</div>
			</div>

			<div class="grid  md:grid-cols-3">
				<!--Book Details-->
				<div class="md:col-start-2 col-span-2 ">
					<div class="grid lg:grid-cols-2  md:grid-cols-1 gap-2">


						<div class="flex flex-col">
							<label class="text-xl sm:text-l text-white">First Name</label> <input
								type="text" name="fName" id="fName"
								class="rounded text-2xl sm:w-1/3,text-l"
								value="<%=u.getfName() %>" />
						</div>


						<div class="flex flex-col">
							<label class="text-xl text-white">Last Name</label> <input
								type="text" name="lName" id="lName" class="rounded text-2xl"
								value="<%=u.getlName() %>" />
						</div>


						<div class="flex flex-col">
							<label class="text-xl text-white">Password</label> <input
								type="password" name="password" id="password"
								class="rounded text-2xl" value="<%=u.getPassword() %>" />
						</div>

						<div class="flex flex-col">
							<label class="text-xl text-white">Re-Enter Password</label> <input
								type="password" name="passwordTest" id="passwordTest"
								class="rounded text-2xl" value="<%=u.getPassword() %>" />
						</div>

					</div>
				</div>
			</div>

		</form>
	</div>
	<%
	} else {
	response.sendRedirect("Home.jsp");
	}
	%>
</body>
<script>
	var passwordField = document.getElementById('password');
	var passwordConfirmationField = document.getElementById('passwordTest');

	function comparePasswords() {
		var password = passwordField.value;
		var passwordConfirmation = passwordConfirmationField.value;

		if (password !== passwordConfirmation) {
			passwordField.classList.add('border-red-500');
			passwordField.classList.add('border-4');
			passwordConfirmationField.classList.add('border-red-500');
			passwordConfirmationField.classList.add('border-4');
		} else {
			passwordField.classList.remove('border-red-500');
			passwordConfirmationField.classList.remove('border-red-500');
			passwordField.classList.remove('border-red-4');
			passwordConfirmationField.classList.remove('border-4');
		}
	}

	passwordConfirmationField.addEventListener('input', comparePasswords);
</script>

</html>
