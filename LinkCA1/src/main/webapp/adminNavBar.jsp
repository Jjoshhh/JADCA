<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script src="https://cdn.tailwindcss.com"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.6.5/flowbite.min.css"
	rel="stylesheet" />
<style>
#dropdownHover::before {
	position: absolute;
	content: "";
	width: 0;
	height: 0;
	border-left: 10px solid transparent;
	border-right: 10px solid transparent;
	border-bottom: 10px solid white;
	top: -10px;
	left: 50%;
	transform: translateX(-50%);
}
</style>
</head>
<body>
	<nav class="bg-black text-white flex px-16 items-center w-full mb-10"
		id="navBar">
		<div class="flex flex-nowrap justify-around w-full">
			<a href="/home" class="flex items-center gap-3"> <img
				class="w-16 rounded-full" src="./src/book_logo.jpg" alt="" />
				<h4 class="font-bold text-xl text-white tracking-wide">SP
					BookStore</h4>
			</a>

			<!--Nav main elements-->
			<div class="flex flex-nowrap justify-evenly gap-16">
				<!--Book Inventory Management-->
				<a href="./bookInv.jsp"
					class="font-medium px-3 py-2 rounded-lg hover:bg-neutral-700 w-[100px] text-center">
					<i class="fa-solid fa-magnifying-glass text-white"></i>
					<h4 class="text-white">Book Inventory</h4>
				</a>
				<!--Dashboard for sales-->
				<a href="/cart"
					class="font-medium px-3 py-2 rounded-lg hover:bg-neutral-700 w-[100px] text-center">
					<i class="fa-solid fa-cart-shopping text-white"></i>
					<h4 class="whitespace-normal w-20 text-center text-white">
						Dashboard</h4>
				</a>
				<!--Logout-->
				<a href="<%=request.getContextPath() %>/Logout" class="flex font-medium px-3 py-2">
					<button class="Btn">
						<div class="pr-16">Logout</div>
						<svg class="svg text-4xl" xmlns="http://www.w3.org/2000/svg"
							width="16" height="16" fill="currentColor"
							class="bi bi-person-vcard-fill" viewBox="0 0 16 16">
                <path
								d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4Zm9 1.5a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 0-1h-4a.5.5 0 0 0-.5.5ZM9 8a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 0-1h-4A.5.5 0 0 0 9 8Zm1 2.5a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 0-1h-3a.5.5 0 0 0-.5.5Zm-1 2C9 10.567 7.21 9 5 9c-2.086 0-3.8 1.398-3.984 3.181A1 1 0 0 0 2 13h6.96c.026-.163.04-.33.04-.5ZM7 6a2 2 0 1 0-4 0 2 2 0 0 0 4 0Z" />
              </svg>
					</button>
				</a>
			</div>
		</div>
	</nav>
</body>
</html>