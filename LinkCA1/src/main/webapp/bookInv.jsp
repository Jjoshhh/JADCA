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
	<%
	if (session.getAttribute("userRole") != (null) && session.getAttribute("userRole").equals("admin")) {
	%>
	<!--Navigation Bar-->
	<jsp:include page="adminNavBar.jsp"></jsp:include>

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
				<a href="<%=request.getContextPath()%>/AddBook"
					class="text-blue-400 text-xl p-1">Add Book</a>
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
				<img class="rounded-t-lg"
					src="DisplayImage?isbn=<%=book.getISBN()%>" alt="Book Image" />
				<div class="p-5">
					<h5
						class="mb-2 text-xl font-bold tracking-tight text-gray-900 dark:text-white">
						<%=book.getTitle()%></h5>
					<!--Update Button-->
					<a href="UpdateBook?isbn=<%=book.getISBN()%>"
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
					<a
						href="<%=request.getContextPath()%>/DeleteBook?isbn=<%=book.getISBN()%>"
						class="block text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
						type="button">Toggle modal</a>

				</div>
			</div>
			<%
			}
			} else {
			%>
			<div
				class="container mx-auto min-h-screen text-center bg-transparent">
				<p class="text-center text-white-400 text-bold">No books found.</p>
			</div>
			<%
			}
			%>

		</div>
	</div>
	<%
	}
	%>
	<%
	} else {
	response.sendRedirect("Home.jsp");
	}
	%>
</body>
</html>
