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
<script src="https://kit.fontawesome.com/9c1a7a3896.js"
	crossorigin="anonymous"></script>
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
			<a href="bookInv.jsp" class="flex items-center gap-3"> <img
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
					<h4 class="text-white">Inventory</h4>
				</a>
				
				<!--Book Inventory Management-->
				<a href="./customerInv.jsp"
					class="font-medium px-3 py-2 rounded-lg hover:bg-neutral-700 w-[100px] text-center">
					<i class="fa-solid fa-magnifying-glass text-white"></i>
					<h4 class="text-white">Customers</h4>
				</a>
				
				<!--Dashboard for sales-->
				<a href="/cart"
					class="font-medium px-3 py-2 rounded-lg hover:bg-neutral-700 w-[100px] text-center">
					<i class="fa-solid fa-cart-shopping text-white"></i>
					<h4 class="whitespace-normal w-20 text-center text-white">
						Dashboard</h4>
				</a>
				<!--Logout-->
				<form action="<%=request.getContextPath()%>/Logout" method="post" class="font-medium px-3 py-2 rounded-lg hover:bg-neutral-700 w-[100px] text-center"
					class="flex font-medium px-3 py-2">
					<button class="Btn">
						<div class="pr-16">Logout</div>
					</button>
				</form>
			</div>
		</div>
	</nav>
</body>
</html>