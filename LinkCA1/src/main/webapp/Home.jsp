<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="classes.BookClass"%>
<%@ include file="HomepageConnection.jsp"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Splash Page</title>
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://kit.fontawesome.com/9c1a7a3896.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="./css/Home.css">
</head>

<body>
	<div class="relative w-full h-screen" id="front">

		<script>
		if (!window.location.href.includes("?")){
			window.location.href = "./filterConnection.jsp";
		}
		</script>

		<%@include file="navBar.jsp"%>

		<div id="loginAlert" class="hidden">
			<%@ include file="alert.jsp"%>
		</div>
		<!-- search bar -->
		<form action="HomePageConnection.jsp" method="get">
			<div
				class="text-xl flex justify-center absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-full">
				<div
					class="flex w-3/5 h-12 bg-white border-2 rounded-[50px] px-5 gap-3">
					<i class="fa-solid fa-search self-center"></i> <input
						class="w-full border-0 focus:outline-0" type="text"
						placeholder="Search For A Title" onkeypress="submitSearch(event)"
						id="inputSearch" />
				</div>
			</div>
		</form>

		<div
			class="flex justify-center mt-8 absolute left-1/2 -translate-x-1/2 bottom-12">
			<a href="#body" class="flex items-center text-white flex-col gap-1">
				<h5 class="ml-2">Scroll Down</h5> <i
				class="fa-solid fa-angle-down text-xl"></i>
			</a>
		</div>
	</div>

	<!-- side bar to filter options -->
	<div class="flex min-h-screen" id="body">
		<div class="bg-[#33363F] text-white w-1/5">
			<ul class="flex flex-col w-full py-4 px-5 sticky top-[100px] z-40 gap-4">
				<li>
					<p class="font-bold text-2xl">Pricing</p>
				</li>
				<!-- add slider eventually -->
				<div class="range-slider">
  					<input class="range-slider__range" type="range" value="50" min="0" max="50" step="0.5">
  					<span class="range-slider__value">0</span>
				</div>
				
				<li>
					<p class="font-bold text-2xl">Category</p>
				</li>

				<form id="formSubmit" method="get">

					<%
					// getting genre from the session attribute
					List<String> genreList = (List<String>) session.getAttribute("genreList");

					// looping through all the genres for checkbox
					for (String genre : genreList) {
					%>

					<li class="flex items-center py-3"><input type="checkbox"
						id="<%=genre%>" name="genre"
						class="form-checkbox h-4 w-4 bg-black text-black transition duration-150 ease-in-out"
						onclick="handleCheckboxClick()" value="<%=genre%>" /> <label
						for="<%=genre%>" class="ml-2 pl-3 text-l font-semibold"><%=genre%></label></li>

					<%
					}
					%>
				</form>
			</ul>
		</div>

		<!-- main content -->
		<div class="w-4/5 py-5 px-5">
			<p class="text-white font-bold pb-5">Displaying Search Results
				For:</p>
			<div class="grid grid-cols-4 gap-10 justify-items-center">

				<%
				// getting and storing image filepath
				String imagePath = request.getParameter("imageURL");

				// default image file path
				String defaultImagePath = "./img/placeholder_img.webp";

				// check if image is not found
				if (imagePath == null || imagePath.isEmpty()) {
					imagePath = defaultImagePath;
				}

				List<BookClass> bookList = (List<BookClass>) session.getAttribute("bookList");
				System.out.print(bookList);

				// check that arraylist is not empty
				if (bookList != null && !bookList.isEmpty()) {
					for (BookClass book : bookList) {
				%>
				<div class="w-full relative">

					<%
					if (book.getCustomer_id() == 0) {
					%>

					<form action="<%=request.getContextPath()%>/Bookmark?status=unchecked&ISBN=<%=book.getISBN() %>" method="post">
						<button type="submit">
							<i
								class="z-20 fa-regular fa-bookmark text-2xl absolute top-[45px] right-[20px] p-2"></i>
						</button>
					</form>
					<%
					} else {
					%>
					<form action="<%=request.getContextPath()%>/Bookmark?status=checked&ISBN=<%=book.getISBN() %>" method="post">
						<button type="submit">
							<i
								class="z-20 fa-solid fa-bookmark text-2xl absolute top-[45px] right-[20px] p-2"></i>
						</button>
					</form>
					<%
					}
					%>

					<form class="w-full"
						action="<%=request.getContextPath()%>/Books?title=<%=book.getTitle()%>"
						method="post">
						<button type="submit" class="w-full">
							<div
								class="w-full max-w-xs bg-white border border-gray-200 rounded-lg shadow bg-[#3D4D64] dark:border-gray-700"
								id="bookContainer">
								<div class="p-4 relative">
									<img class="rounded-lg" src="DisplayImage?isbn=<%=book.getISBN()%>"
										alt="<%=defaultImagePath%>" />
								</div>
								<div class="px-5 pb-5">
									<!-- product title -->
									<h5
										class="text-lg font-semibold tracking-tight text-gray-900 dark:text-white h-[30px] overflow-hidden">
										<p class="truncate text-left"><%=book.getTitle()%></p>
									</h5>
									<div class="flex items-center mt-1 mb-2.5">
										<svg aria-hidden="true" class="w-5 h-5 text-yellow-300"
											fill="currentColor" viewBox="0 0 20 20" s
											xmlns="http://www.w3.org/2000/svg">
	                                <title>First star</title>
	                                <path
												d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z">
	                                </path>
	                            </svg>
										<svg aria-hidden="true" class="w-5 h-5 text-yellow-300"
											fill="currentColor" viewBox="0 0 20 20"
											xmlns="http://www.w3.org/2000/svg">
	                                <title>Second star</title>
	                                <path
												d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z">
	                                </path>
	                            </svg>
										<svg aria-hidden="true" class="w-5 h-5 text-yellow-300"
											fill="currentColor" viewBox="0 0 20 20"
											xmlns="http://www.w3.org/2000/svg">
	                                <title>Third star</title>
	                                <path
												d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z">
	                                </path>
	                            </svg>
										<svg aria-hidden="true" class="w-5 h-5 text-yellow-300"
											fill="currentColor" viewBox="0 0 20 20"
											xmlns="http://www.w3.org/2000/svg">
	                                <title>Fourth star</title>
	                                <path
												d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z">
	                                </path>
	                            </svg>
										<svg aria-hidden="true" class="w-5 h-5 text-yellow-300"
											fill="currentColor" viewBox="0 0 20 20"
											xmlns="http://www.w3.org/2000/svg">
	                                <title>Fifth star</title>
	                                <path
												d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z">
	                                </path>
	                            </svg>
									</div>
									<div class="flex items-center justify-between">
										<span class="text-lg font-bold text-gray-900 dark:text-white">$<%=book.getPrice()%></span>
									</div>
								</div>
							</div>
						</button>
					</form>
				</div>
				<%
				}
				} else {
				%>
					<h1 class="col-span-4 text-white text-4xl font-bold my-12">No Results!</h1>
				<% } %>
			</div>
		</div>
	</div>

	<script>
		window.onscroll = function() {
			let navbar = document.querySelector("nav");
			if (window.pageYOffset > 0) {
				navbar.classList.add("scrolled");
			} else {
				navbar.classList.remove("scrolled");
			}
		};
		
		let navbar = document.querySelector("nav");
		navbar.classList.remove("scrolled");
		
		// redirect to view specific book
		function redirectBook(){
 			// window.location.href = "./java/servlets/BookDisplay.java";
 			// window.location.href = "./test.jsp"
		}
		
		function handleCheckboxClick() {
		  // getting all checked values of the query and storing it in an array
		  let checkboxesArr = document.querySelectorAll('input[type="checkbox"]:checked');
		  // captures the value of the text input
		  let inputSearch = document.getElementById("inputSearch").value;
		  
		  // extracting the value attribute of each checkbox
		  let selected = Array.from(checkboxesArr).map((x) => x.value);
		  
		  let combinedValues = selected.join(",");
		  
		  // removing the leading comma
		  if(combinedValues.startsWith(",")){
			  combinedValues = combinedValues.slice(1);
		  }
		  
		  let range = document.getElementsByClassName("range-slider__range")[0];
		  let rangeInput = range.value;
		  
		  return window.location.href = "./filterConnection.jsp?search=" + inputSearch + "&genre=" + combinedValues + "&price=" + rangeInput;
		}
		
		// handling search input submissions
		function submitSearch (event){
			// submit form when enter key is clicked
			if(event.keyCode == 13){
				event.preventDefault();
				handleCheckboxClick();
				// involke function to scroll to location on enter 
				// scrollToResult();
			}
		}
		
		// function to scroll to result
		/* function scrollToResult() {
			let section = document.getElementById("body");
			if (section){
				section.scrollIntoView({  behavior: "smooth", block: "end", inline: "nearest" });
			}
		} */
		
		if (window.location.href.includes("?")){
			let paramString = window.location.href.split('?')[1];
			// splits the parameters manually
			let queryString = new URLSearchParams(paramString);
			if (queryString.has("search")){
				// getting value for text input and passes it the url
				// ensures that it stays persistent
				document.getElementById("inputSearch").value = queryString.get("search") != "null" ? queryString.get("search") : "";
				// if search is not null then scroll down to #body
				if (queryString.get("search") != "") {
					document.getElementById("body").scrollIntoView({ behavior: "auto" })
				}
			}
			
			if(queryString.has("genre")){
				let genreArr = queryString.get("genre").split(",");
				let checkboxArr = document.querySelectorAll('input[type="checkbox"]');
				// if search is not null then scroll down to #body
				if (queryString.get("genre") != "") {
					document.getElementById("body").scrollIntoView({ behavior: "auto" })
				}
				// loop through checkbox array
				for (let checkbox of checkboxArr){
					// loop through key value pair
					// get name of checkbox
					// if checkbox.checked = true then finish
					if (genreArr.includes(checkbox.value)){
						checkbox.checked = true;
					}
				} 
			}
			
			if(queryString.has("price")) {
				//  Get ElementByClassName returns an array so need to get first index
				var range = document.getElementsByClassName("range-slider__range")[0];
				var value = document.getElementsByClassName("range-slider__value")[0];
				// Setting value of total range (2 values: query string value or 50)
				// if first value is false use last value 
				// if first value if true use first value
				range.value = queryString.get("price") || 50;
				value.innerText = range.value;
				if (queryString.get("price") != "") {
					document.getElementById("body").scrollIntoView({ behavior: "auto" })
				}
			}
			
			// alerting 
			// breaks the checkbox cos errCode is not part of the query
			if(queryString.has("errCode")){
				if(queryString.has("errCode")){
					document.getElementById("loginAlert").classList.remove("hidden");
					document.getElementById("alertContent").innerText = "Invalid Login Credentials"
				}
			}
		}else{
			window.location.href="./filterConnection.jsp"
		}
		
		
		
		function rangeSlider() {
			var sliders = document.getElementsByClassName("range-slider")[0];
			var range = document.getElementsByClassName("range-slider__range")[0];
			var value = document.getElementsByClassName("range-slider__value")[0];
			
			
			value.innerText = range.value;
			
			range.addEventListener("input", () => {
				value.innerText = range.value;
				handleCheckboxClick();
			})
		}
		rangeSlider()
	</script>
</body>

</html>