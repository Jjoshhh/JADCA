<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.Cookie"%>
<%@ page import="java.util.*"%>
<%@ page import="classes.CartItems"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.tailwindcss.com"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.6.5/flowbite.min.css"
	rel="stylesheet" />
<title>Insert title here</title>
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
	<nav class="text-white flex px-16 items-center w-full scrolled"
		id="navBar">
		<div class="flex flex-nowrap justify-around w-full">
			<a href="./Home.jsp" class="flex items-center gap-3"> <img
				class="w-16 rounded-full" src="./img/book_logo.jpg" alt="">
				<h4 class="font-bold text-xl text-white tracking-wide">SP
					BookStore</h4>
			</a>
			<div class="flex flex-nowrap justify-evenly gap-16">
				<%if(session.getAttribute("userRole") != null && session.getAttribute("userRole").equals("customer")){ %>
				<a href="<%=request.getContextPath() %>/UpdateUser" 
					class="font-medium px-3 py-2 rounded-lg hover:bg-neutral-700 w-[100px] text-center">
					<i class="fa-solid fa-gear"></i>
					<h4 class="text-white">Settings</h4>
				</a> 
				<%} %>
				<a href="./Home.jsp"
					class="font-medium px-3 py-2 rounded-lg hover:bg-neutral-700 w-[100px] text-center">
					<i class="fa-solid fa-magnifying-glass text-white"></i>
					<h4 class="text-white">Search</h4>
				</a> <a>
					<button
						class="font-medium px-3 py-2 rounded-lg hover:bg-neutral-700 w-[100px] text-center"
						id="dropdownHoverButton" data-dropdown-toggle="dropdownHover"
						data-dropdown-trigger="hover">
						<i class="fa-solid fa-cart-shopping text-white"></i>
						<h4 class="whitespace-normal w-20 text-center text-white">Cart</h4>
					</button> <!-- Dropdown menu -->
					<div id="dropdownHover"
						class="z-30 p-4 flex flex-col gap-4 hidden bg-white text-black divide-y divide-gray-100 rounded-lg shadow w-[275px]">
						<div class="text-xl font-semibold" id="title">Your Cart</div>
						<div class="flex flex-col gap-4 max-h-[200px] overflow-y-auto"
							id="cart-contents">

							<%
							// Access the cartItemsCookie from request cookies
							Cookie[] cookies = request.getCookies();
							String cartItemsString = null;
							if (cookies != null) {
								for (Cookie cookie : cookies) {
									if (cookie.getName().equals("cartItemsCookie")) {
								cartItemsString = cookie.getValue();
								break;
									}
								}
								if (cartItemsString != null) {
									ArrayList<CartItems> cartItemsList = new ArrayList<>();
									// Split the cartItemString and retrieve individual values
									String[] cartItemsArray = cartItemsString.split("#");
									for (String cartItem : cartItemsArray) {
								String[] itemValues = cartItem.split("\\|");
								if (itemValues.length == 5) {
									String ISBN = itemValues[0];
									String cart_id = itemValues[1];
									String title = itemValues[2];
									String imageURL = itemValues[3];
									double price = Double.parseDouble(itemValues[4]);

									// creating a new cart object
									CartItems cartItemObj = new CartItems(ISBN, cart_id, title, imageURL, price);

									// add object to the arraylist
									cartItemsList.add(cartItemObj);
								}
									}
									// Displaying the cart items
									for (CartItems cartItem : cartItemsList) {
							%>
							<div class="flex items-center justify-between gap-3">
								<!-- <div class="w-[50px] aspect-[3/4] bg-gray-700 rounded-md"></div> -->
								<img
									class="min-w-[50px] w-[50px] aspect-[3/4] bg-gray-700 rounded-md"
									src="DisplayImage?isbn=<%=cartItem.getISBN()%>" alt="" />
								<div class="flex flex-col w-[175px]">
									<div class="truncate"><%=cartItem.getTitle()%></div>
									<div><%=cartItem.getPrice()%></div>
								</div>
							</div>

							<%
							}
							} else {

							// no product
							%>
							<div class="flex items-center justify-between gap-3">
								<img class="min-w-[50px]" src="./img/no_items_img.webp"
									alt="no-items" />
							</div>
							<%
							}
							}
							%>
						</div>
						<!-- <hr class="bg-[black] my-3 px-3"> -->
						<form action="<%=request.getContextPath()%>/DisplayItems"
							method="POST">
							<button
								class="flex text-white bg-[#050708] hover:bg-[#050708]/80 focus:ring-4 focus:outline-none focus:ring-[#050708]/50 font-medium rounded-lg text-sm px-5 py-2.5 text-center inline-flex gap-1 items-center dark:hover:bg-[#050708]/40 dark:focus:ring-gray-600 justify-center w-full"
								type="submit">
								Check out <i class="fa-solid fa-cart-shopping text-white"></i>
							</button>
						</form>
					</div>

				</a><a>
					<button data-modal-target="admin-modal"
						data-modal-toggle="admin-modal" type="button"
						class="font-medium px-3 py-2 rounded-lg hover:bg-neutral-700 w-[100px] text-center">
						<i class="fa-solid fa-user text-white"></i>
						<h4 class="text-white">Admin</h4>
					</button>
				</a>

				<%
				// Getting cookies
				Cookie[] customerCookie = request.getCookies();
				boolean loggedIn = false;

				for (Cookie perCookie : customerCookie) {
					if (perCookie.getName().equals("cart_id")) {
						loggedIn = true;
						break;
					}
				}

				boolean cusExist = loggedIn;

				if (loggedIn) {
				%>

				<div class="flex font-medium text-sm px-3 py-2">
					<form class="flex font-medium px-3 py-2"
						action="<%=request.getContextPath()%>/Logout" method="post">
						<button class="Btn">
							<div class="pr-16">Logout</div>
							<svg class="svg text-4xl" xmlns="http://www.w3.org/2000/svg"
								width="16" height="16" fill="currentColor"
								class="bi bi-person-vcard-fill" viewBox="0 0 16 16">
                                <path
									d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4Zm9 1.5a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 0-1h-4a.5.5 0 0 0-.5.5ZM9 8a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 0-1h-4A.5.5 0 0 0 9 8Zm1 2.5a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 0-1h-3a.5.5 0 0 0-.5.5Zm-1 2C9 10.567 7.21 9 5 9c-2.086 0-3.8 1.398-3.984 3.181A1 1 0 0 0 2 13h6.96c.026-.163.04-.33.04-.5ZM7 6a2 2 0 1 0-4 0 2 2 0 0 0 4 0Z" />
                              </svg>
						</button>
					</form>
				</div>

				<%
				} else {
				%>

				<div class="flex font-medium px-3 py-2">
					<a class="flex font-medium text-sm px-3 py-2" href="login.jsp">
						<button class="Btn">
							<div class="pr-16">Login</div>
							<svg class="svg text-4xl" xmlns="http://www.w3.org/2000/svg"
								width="16" height="16" fill="currentColor"
								class="bi bi-person-vcard-fill" viewBox="0 0 16 16">
                                <path
									d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4Zm9 1.5a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 0-1h-4a.5.5 0 0 0-.5.5ZM9 8a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 0-1h-4A.5.5 0 0 0 9 8Zm1 2.5a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 0-1h-3a.5.5 0 0 0-.5.5Zm-1 2C9 10.567 7.21 9 5 9c-2.086 0-3.8 1.398-3.984 3.181A1 1 0 0 0 2 13h6.96c.026-.163.04-.33.04-.5ZM7 6a2 2 0 1 0-4 0 2 2 0 0 0 4 0Z" />
                              </svg>
						</button>
					</a>
				</div>

				<%
				}
				%>
			</div>
		</div>
	</nav>

	<!-- Admin modal -->
	<form class="rounded-lg"
		action="<%=request.getContextPath()%>/AdminValidate">
		<div id="admin-modal" tabindex="-1" aria-hidden="true"
			class="fixed top-0 left-0 right-0 z-50 hidden w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full">
			<div class="relative w-full max-w-md max-h-full">
				<!-- Modal content -->
				<div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
					<button type="button"
						class="absolute top-3 right-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-800 dark:hover:text-white"
						data-modal-hide="admin-modal">
						<svg aria-hidden="true" class="w-5 h-5" fill="currentColor"
							viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd"
								d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
								clip-rule="evenodd"></path>
                    </svg>
						<span class="sr-only">Close modal</span>
					</button>
					<div class="px-6 py-6 lg:px-8 bg-gray-700 text-white rounded-lg">
						<h3 class="mb-4 text-xl font-medium text-white">Sign in to
							our platform</h3>
						<form class="space-y-6" action="#">
							<div>
								<label for="email"
									class="block mb-2 text-sm font-medium text-white">Your
									email</label> <input type="email" name="email" id="email"
									class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white"
									placeholder="name@company.com" required>
							</div>
							<div>
								<label for="password"
									class="block mb-2 text-sm font-medium text-white">Your
									password</label> <input type="password" name="password" id="password"
									placeholder="••••••••"
									class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white"
									required>
							</div>
							<div class="flex justify-between my-5">
								<div class="flex items-start">
									<div class="flex items-center h-5">
										<input id="remember" type="checkbox" value=""
											class="w-4 h-4 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-blue-300 dark:bg-gray-600 dark:border-gray-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 dark:focus:ring-offset-gray-800">
									</div>
									<label for="remember"
										class="ml-2 text-sm font-medium text-gray-900 text-white">Remember
										me</label>
								</div>
							</div>
							<button type="submit"
								class="w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Login
								to your account</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</form>


	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.6.5/flowbite.min.js"></script>
</body>
</html>