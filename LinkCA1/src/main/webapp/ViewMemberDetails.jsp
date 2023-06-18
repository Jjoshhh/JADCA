
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="classes.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.tailwindcss.com"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.6.5/flowbite.min.css"
	rel="stylesheet" />
<script src="https://kit.fontawesome.com/9c1a7a3896.js"
	crossorigin="anonymous"></script>
<title>Insert title here</title>
<link rel="stylesheet" href="./css/ViewMemberDetails.css">
</head>
<body id="front">
	<div class="">
		<%@include file="navBar.jsp"%>

		<form action="<%=request.getContextPath()%>/UpdateUser" method="post"
			class="pt-[200px] flex justify-center self-center h-full text-white font-semibold text-2xl">
			<div class="bg-[#3D4D64] rounded-xl w-3/4 aspect-[1/0.5] mx-auto"
				id="display_details">
				<div class="flex justify-center my-5">
					<p class="font-semibold text-4xl">Edit Profile</p>
					<div class=" flex justify-end">
						<input type="submit"
							class="text-white bg-blue-700 hover:bg-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300 font-medium rounded-full text-sm px-5 py-2.5 text-center mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800" />
					</div>
				</div>
				<div class="flex justify-center">
					<div class="w-1/2 m-10 flex justify-center" id="icons_image">
						<div class="bg-white aspect-[1/1] rounded-full"></div>
					</div>
					<%
					if (request.getAttribute("customerDetails") != null) {
						User c = (User) request.getAttribute("customerDetails");
						if (c != null) {
					%>
					<div class="w-1/2">
						<div class="flex flex-col align-middle mx-10 space-y-5">
							<label>First Name: </label> <input type="text" name="fName"
								value=<%=c.getfName()%> placeholder="" class="text-black" /> <label>Last
								Name: </label> <input type="text" name="lName" value=<%=c.getlName()%>
								placeholder="" class="text-black" /> <label>Password: </label>
							<input type="password" name="password" value=<%=c.getPassword()%>
								id="password" name="fName" placeholder="" class="text-black" />
							<label>Re-enter Password: </label> <input type="password"
								name="passwordTest" id="passwordTest" value=<%=c.getPassword()%>
								placeholder="" class="text-black" />
						</div>
					</div>
					<%
					}
					}
					%>
				</div>
			</div>
		</form>

		<div class="flex justify-center items-center p-10">
			<a href="DeleteUser"
				class="focus:outline-none text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-900">Delete
				Account</a>
		</div>


	</div>
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
