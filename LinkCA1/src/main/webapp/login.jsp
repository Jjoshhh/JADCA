<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="./css/userLogin.css" />
<title>Document</title>
</head>
<body class="bg-cover">
	<%
	String errCode = request.getParameter("errCode");
	%>
	<%
	if (errCode != null) {
	%>
	<!-- Error Notification -->
	<div id="toast-simple"
		class="fixed top-4 right-4 flex items-center max-w-xs p-4 space-x-4 text-gray-500 bg-white divide-x divide-gray-200 rounded-lg shadow dark:text-gray-400 dark:divide-gray-700 space-x dark:bg-gray-800 <%if (errCode != null) {%> active <%}%>"
		role="alert">
		<svg aria-hidden="true"
			class="w-5 h-5 text-blue-600 dark:text-blue-500" focusable="false"
			data-prefix="fas" data-icon="paper-plane" role="img"
			xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
    <path fill="currentColor"
				d="M511.6 36.86l-64 415.1c-1.5 9.734-7.375 18.22-15.97 23.05c-4.844 2.719-10.27 4.097-15.68 4.097c-4.188 0-8.319-.8154-12.29-2.472l-122.6-51.1l-50.86 76.29C226.3 508.5 219.8 512 212.8 512C201.3 512 192 502.7 192 491.2v-96.18c0-7.115 2.372-14.03 6.742-19.64L416 96l-293.7 264.3L19.69 317.5C8.438 312.8 .8125 302.2 .0625 289.1s5.469-23.72 16.06-29.77l448-255.1c10.69-6.109 23.88-5.547 34 1.406S513.5 24.72 511.6 36.86z"></path>
  </svg>
		<div class="pl-4 text-sm font-normal">Message sent successfully.</div>
	</div>
	<%
	}
	%>

	<div class="flex h-screen justify-center items-center">
		<div
			class="w-full max-w-sm p-4 bg-white border border-gray-200 rounded-lg shadow sm:p-6 md:p-8 dark:bg-black dark:border-gray-700">
			<form class="space-y-6" action="<%=request.getContextPath()%>/Login"
				method="post">
				<div class="flex justify-center">
					<h5 class="text-xl font-medium text-gray-900 dark:text-white">
						Sign in to our platform</h5>
				</div>
				<div>
					<label for="username"
						class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your
						Username</label> <input type="text" name="username" id="username"
						class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white"
						required />
				</div>
				<div>
					<label for="password"
						class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your
						password</label> <input type="password" name="password" id="password"
						class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white"
						required />
				</div>
				<div class="flex items-start">
					<div class="flex items-start">
						<div class="flex items-center h-5">
							<input id="remember" type="checkbox" value=""
								class="w-4 h-4 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-blue-300 dark:bg-gray-700 dark:border-gray-600 dark:focus:ring-blue-600 dark:ring-offset-gray-800 dark:focus:ring-offset-gray-800"
								required />
						</div>
					</div>
				</div>
				<button type="submit"
					class="w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
					Login to your account</button>
				<div class="text-sm font-medium text-gray-500 dark:text-gray-300">
					Not registered? <a href="./createAcc.jsp"
						class="text-blue-700 hover:underline dark:text-blue-500">Create
						account</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
