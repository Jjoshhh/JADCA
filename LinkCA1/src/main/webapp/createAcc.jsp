<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="./css/userLogin.css" />
<title>Document</title>
</head>
<body class="bg-cover">
<%
	String context = request.getContextPath();
%>
	<div id="alertContainer"
		class="hidden bg-red-500 text-white px-4 py-2 rounded-md fixed bottom-4 right-4"></div>

	<section class="">
		<div
			class="flex flex-col items-center justify-center mx-auto md:h-screen lg:py-0">
			<div
				class="w-full bg-white rounded-lg shadow dark:border md:mt-0 sm:max-w-md xl:p-0 dark:bg-black dark:border-gray-700">
				<div class="p-6 space-y-4 md:space-y-6 sm:p-8">
					<h1
						class="text-xl font-bold leading-tight tracking-tight text-gray-900 md:text-2xl dark:text-white">
						Create an account</h1>
					<form action="<%=context%>/AccountCreation" method="post" class="space-y-4 md:space-y-6 grid">
						<div class="grid grid-cols-2 gap-6">
							<div>
								<label for="firstName"
									class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">First
									Name</label> <input type="text" name="firstName" id="firstName"
									class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
									placeholder="" required="" />
							</div>
							<div class="grid-cols-6">
								<label for="lastName"
									class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Last
									Name</label> <input type="text" name="lastName" id="lastName"
									placeholder=""
									class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
									required="" />
							</div>
						</div>
						<div class="grid grid-cols-2 gap-6">
							<div>
								<label for="username"
									class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Username</label>
								<input type="text" name="username" id="username" placeholder=""
									class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
									required="" />
							</div>
							<div>
								<label for="email"
									class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Email</label>
								<input type="email" name="email" id="email"
									class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
									required="" />
							</div>
						</div>

						<div class="grid grid-cols-2 gap-6">
							<div>
								<label for="password"
									class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Password</label>
								<input type="password" name="password" id="password"
									class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
									required="" />
							</div>
							<div>
								<label for="confirm-password"
									class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Confirm
									password</label> <input type="confirm-password" name="confirm-password"
									id="confirm-password"
									class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
									required="" />
							</div>
						</div>
						<div class="flex items-start">
							<div class="flex items-center h-5">
								<input id="terms" aria-describedby="terms" type="checkbox"
									class="w-4 h-4 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:bg-gray-700 dark:border-gray-600 dark:focus:ring-primary-600 dark:ring-offset-gray-800"
									required />
							</div>
							<div class="ml-3 text-sm">
								<label for="terms"
									class="font-light text-gray-500 dark:text-gray-300">I
									accept the <a
									class="font-medium text-primary-600 hover:underline dark:text-primary-500"
									href="#">Terms and Conditions</a>
								</label>
							</div>
						</div>
						<button type="submit"
							class="w-full text-white bg-primary-600 hover:bg-primary-700 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800">
							Create an account</button>
						<p class="text-sm font-light text-gray-500 dark:text-gray-400">
							Already have an account? <a href="./login.html"
								class="font-medium text-primary-600 hover:underline dark:text-primary-500">Login
								here</a>
						</p>
					</form>
				</div>
			</div>
		</div>
	</section>
	<script>
		const passwordInput = document.getElementById("password");
		const confirmPasswordInput = document
				.getElementById("confirm-password");
		const alertContainer = document.getElementById("alertContainer");

		function checkPasswordMatch() {
			const password = passwordInput.value;
			const confirmPassword = confirmPasswordInput.value;

			if (password !== confirmPassword) {
				alertContainer.classList.remove("hidden");
				alertContainer.innerText = "Password and Confirm Password do not match.";
			} else {
				alertContainer.classList.add("hidden");
				alertContainer.innerText = "";
			}
		}

		passwordInput.addEventListener("input", checkPasswordMatch);
		confirmPasswordInput.addEventListener("input", checkPasswordMatch);
	</script>
</body>
</html>
