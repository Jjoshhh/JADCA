<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="classes.Book"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="./css/adminPage.css" />
<title>SP BookStore</title>
</head>
<body class="">
	<!--Navigation Bar-->
	<nav class="bg-black text-white flex px-16 items-center w-full"
		id="navBar">
		<div class="flex flex-nowrap justify-around w-full">
			<a href="/home" class="flex items-center gap-3"> <img
				class="w-16 rounded-full" src="./src/book_logo.jpg" alt="" />
				<h4 class="font-bold text-xl text-white tracking-wide">SP
					BookStore</h4>
			</a>

			<!--Nav main elements-->
			<div class="flex flex-nowrap justify-evenly gap-16">
				<!--Dashboard for sales-->
				<a href="./dashboard.html"
					class="font-medium px-3 py-2 rounded-lg hover:bg-neutral-700 w-[100px] text-center">
					<i class="fa-solid fa-cart-shopping text-white"></i>
					<h4 class="whitespace-normal w-20 text-center text-white">
						Dashboard</h4>
				</a>
				<!--Book Inventory Management-->
				<a href="./bookInv.html"
					class="font-medium px-3 py-2 rounded-lg hover:bg-neutral-700 w-[100px] text-center">
					<i class="fa-solid fa-magnifying-glass text-white"></i>
					<h4 class="text-white">Book Inventory</h4>
				</a>

				<!--Logout-->
				<a href="./" class="flex font-medium px-3 py-2">
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

	<!--Page-->
	<form action="<%=request.getContextPath()%>/BookSearch" method="post">
		<div
			class="container mx-auto rounded-lg min-h-screen bg-transparent flex justify-center items-center flex-col">
			<div class="flex w-3/4">
				<!--Select search by-->
				<div class="relative w-1/5">
					<select name="option"
						class="rounded-l-lg bg-gray-50 border border-gray-300 text-gray-900 text-sm focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
						<option selected value="title">Title</option>
						<option value="isbn">ISBN Number</option>
					</select>
				</div>

				<div class="relative w-full">
					<input type="search" id="search-dropdown" name="searchQuery"
						class="block p-2.5 w-full z-20 text-sm text-gray-900 bg-gray-50 rounded-r-lg border-l-gray-50 border-l-2 border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-l-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:border-blue-500"
						placeholder="" />

					<button type="submit"
						class="absolute top-0 right-0 p-2.5 text-sm font-medium text-white bg-blue-700 rounded-r-lg border border-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
						<svg aria-hidden="true" class="w-5 h-5" fill="none"
							stroke="currentColor" viewBox="0 0 24 24"
							xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round"
								stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
              </svg>
						<span class="sr-only">Search</span>
					</button>
				</div>
			</div>

			<div>
				<a href="./addBook.jsp" class="text-blue-400 text-xl p-1">Add
					Book</a>
			</div>

			<!--Scroll down button-->
			<div class="flex justify-center items-center">
				<a href="#cards"> <img src="./img/down.png"
					class="text-xs h-16 animate-bounce" />
				</a>
			</div>
		</div>
	</form>

	<%
	if (request.getAttribute("bookList") != null) {
	%>
	<!-- Cards -->
	<div class="container mx-auto min-h-screen text-center bg-transparent">
		<div id="cards" class="grid grid-cols-5 gap-4">
			<%
			List<Book> bookList = (List<Book>) request.getAttribute("bookList");
			if (bookList != null && !bookList.isEmpty()) {
				for (Book book : bookList) {
			%>
			<div
				class="flex flex-col  bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700">
				<a href="#" class="self-center"> <img class="rounded-t-lg"
					src="DisplayImage?isbn=<%= book.getISBN() %>" alt="" />
				</a>
				<div class="p-5">
					<h5
						class="mb-2 text-xl font-bold tracking-tight text-gray-900 dark:text-white">
						<%=book.getTitle()%></h5>
					<!--Update Button-->
					<a href="./updateBook.html"
						class="inline-flex items-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
						Update <svg aria-hidden="true" class="w-4 h-4 ml-2 -mr-1"
							fill="currentColor" viewBox="0 0 20 20"
							xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd"
								d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z"
								clip-rule="evenodd"></path>
              </svg>
					</a>
					<!--Delete Button-->
					<button data-modal-target="#popup-modal"
						data-modal-toggle="popup-modal"
						class="text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-800"
						type="button">Delete</button>


					<div id="popup-modal" tabindex="-1"
						class="fixed top-0 left-0 right-0 z-50 hidden p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full">
						<div class="relative w-full max-w-md max-h-full">
							<div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
								<button type="button"
									class="absolute top-3 right-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-800 dark:hover:text-white"
									data-modal-hide="popup-modal">
									<svg aria-hidden="true" class="w-5 h-5" fill="currentColor"
										viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                      <path fill-rule="evenodd"
											d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
											clip-rule="evenodd"></path>
                    </svg>
									<span class="sr-only">Close modal</span>
								</button>
								<div class="p-6 text-center">
									<svg aria-hidden="true"
										class="mx-auto mb-4 text-gray-400 w-14 h-14 dark:text-gray-200"
										fill="none" stroke="currentColor" viewBox="0 0 24 24"
										xmlns="http://www.w3.org/2000/svg">
                      <path stroke-linecap="round"
											stroke-linejoin="round" stroke-width="2"
											d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
									<h3
										class="mb-5 text-lg font-normal text-gray-500 dark:text-gray-400">
										Are you sure you want to delete this product?</h3>
									<button data-modal-hide="popup-modal" type="button"
										class="text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 dark:focus:ring-red-800 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2">
										Yes, I'm sure</button>
									<button data-modal-hide="popup-modal" type="button"
										class="text-gray-500 bg-white hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200 rounded-lg border border-gray-200 text-sm font-medium px-5 py-2.5 hover:text-gray-900 focus:z-10 dark:bg-gray-700 dark:text-gray-300 dark:border-gray-500 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-600">
										No, cancel</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			} else {
			%>
			<p>No books found.</p>
			<%
			}
			%>

		</div>
	</div>
	<%
	}
	%>

</body>
</html>
