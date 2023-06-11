<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="classes.BookClass"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://cdn.tailwindcss.com"></script>
<script data-require="jquery@3.1.1" data-semver="3.1.1"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/9c1a7a3896.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="./css/bookDisplay.css">
<title>Document</title>
</head>
<body>
	<div class="relative w-full h-screen" id="front">
		<%@include file="navBar.jsp"%>

		<!-- side bar to filter options -->
		<div class="flex min-h-screen" id="body">
			<div class="bg-[#33363F] text-white w-1/5">
				<ul class="flex flex-col w-full py-4 px-5 sticky top-[100px] z-40">
					<li>
						<p class="font-bold text-2xl">Pricing</p>
					</li>
					<!-- add slider eventually -->
					<li>
						<p class="font-bold text-2xl">Category</p>
					</li>
					<li class="flex items-center py-5"><input type="checkbox"
						id="checkbox1"
						class="form-checkbox h-4 w-4 bg-black text-white transition duration-150 ease-in-out" />
						<label for="checkbox1" class="ml-2 pl-3 text-l font-semibold">Horror</label>
					</li>
					<li class="flex items-center pb-5"><input type="checkbox"
						id="checkbox1"
						class="form-checkbox h-4 w-4 bg-black text-white transition duration-150 ease-in-out" />
						<label for="checkbox1" class="ml-2 pl-3 text-l font-semibold">Fiction</label>
					</li>
					<li class="flex items-center pb-5"><input type="checkbox"
						id="checkbox1"
						class="form-checkbox h-4 w-4 bg-black text-white transition duration-150 ease-in-out" />
						<label for="checkbox1" class="ml-2 pl-3 text-l font-semibold">Non
							- Fiction</label></li>
					<li class="flex items-center pb-5"><input type="checkbox"
						id="checkbox1"
						class="form-checkbox h-4 w-4 bg-black text-white transition duration-150 ease-in-out" />
						<label for="checkbox1" class="ml-2 pl-3 text-l font-semibold">Fantasy</label>
					</li>
					<li class="flex items-center pb-5"><input type="checkbox"
						id="checkbox1"
						class="form-checkbox h-4 w-4 bg-black text-white transition duration-150 ease-in-out" />
						<label for="checkbox1" class="ml-2 pl-3 text-l font-semibold">Mystery</label>
					</li>
					<li class="flex items-center pb-5"><input type="checkbox"
						id="checkbox1"
						class="form-checkbox h-4 w-4 bg-black text-white transition duration-150 ease-in-out" />
						<label for="checkbox1" class="ml-2 pl-3 text-l font-semibold">Romance</label>
					</li>
				</ul>
			</div>

			<% 
				// getting and storing image filepath
				
			
				List <BookClass> displayBookList = (List<BookClass>)session.getAttribute("bookDetails");
								
				String title = null;
				String imageURL = null;
				String ISBN = null;
				String releaseDate = null;
				String publisher = null;
				String description = null;
				String genre = null;
				String author = null;
				double price = 0;
				int quantity = 0;
				int rating = 0;
				String publication = null;
				
				if (displayBookList != null && !displayBookList.isEmpty()){
					for (BookClass book : displayBookList){
			%>

			<div class="w-4/5 text-white">
				<div class="flex mt-6">
					<div class="flex flex-col">
						<img class="bg-white w-64 aspect-[3/4] ml-5 rounded-lg" src="<%= book.getImageURL() %>" alt="./img/placeholder_img.webp" /> 
						<div class="ml-5 mt-2">
							ISBN Identification Number:
							<p><%= book.getISBN() %></p>
						</div>
					</div>
					<div class="ml-5 flex flex-col w-full  pr-5">
						<div class="text-3xl font-bold tracking-wide"><%= book.getTitle() %></div>
						<div class="flex items-center mt-5">
							<svg aria-hidden="true" class="w-5 h-5 text-yellow-400"
								fill="currentColor" viewBox="0 0 20 20"
								xmlns="http://www.w3.org/2000/svg">
                                <title>First star</title>
                                <path
									d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z">
                                </path>
                            </svg>
							<svg aria-hidden="true" class="w-5 h-5 text-yellow-400"
								fill="currentColor" viewBox="0 0 20 20"
								xmlns="http://www.w3.org/2000/svg">
                                <title>Second star</title>
                                <path
									d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z">
                                </path>
                            </svg>
							<svg aria-hidden="true" class="w-5 h-5 text-yellow-400"
								fill="currentColor" viewBox="0 0 20 20"
								xmlns="http://www.w3.org/2000/svg">
                                <title>Third star</title>
                                <path
									d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z">
                                </path>
                            </svg>
							<svg aria-hidden="true" class="w-5 h-5 text-yellow-400"
								fill="currentColor" viewBox="0 0 20 20"
								xmlns="http://www.w3.org/2000/svg">
                                <title>Fourth star</title>
                                <path
									d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z">
                                </path>
                            </svg>
							<svg aria-hidden="true"
								class="w-5 h-5 text-gray-300 dark:text-gray-500"
								fill="currentColor" viewBox="0 0 20 20"
								xmlns="http://www.w3.org/2000/svg">
                                <title>Fifth star</title>
                                <path
									d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z">
                                </path>
                            </svg>
							<p
								class="ml-2 text-sm font-medium text-gray-500 dark:text-gray-400">4
								out of 5</p>
						</div>
						<div class="my-4 text-2xl font-bold" id="pricing"><%= book.getPrice() %></div>
						<hr>
						<div class="font-semibold gap-5 my-5" id="detailsGrid">
							<div class="">Published By:</div>
							<p class=""><%= book.getPublisher() %></p>
							<div class="">Genres:</div>
							<p class=""><%= book.getGenre() %></p>
							<div class="flex-start">
								<p>Authors:</p>
							</div>
							<div class="">
								<button type="button"
									class="text-white bg-gray-800 hover:bg-gray-900 focus:outline-none focus:ring-4 focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-gray-800 dark:hover:bg-gray-700 dark:focus:ring-gray-700 dark:border-gray-700">
									<%= book.getAuthor() %></button>
							</div>
						</div>
						<form class="" action="<%=request.getContextPath()%>/AddToBasket?title=<%=book.getTitle()%>&price=<%= book.getPrice()%>&imageURL=<%= book.getImageURL()%>&quantity=" method="POST" id="addToBasket">
						<div class="flex items-center">
							<div class="quantity">
								<span class="input-number-decrement" id="minus-btn">–</span><input
									class="input-number text-black" type="text" value="1" min="1"
									max="<%= book.getQuantity() %>" id="quantity-input" /><span
									class="input-number-increment" id="plus-btn">+</span>
							</div>
							<div class="ml-3"><%= book.getQuantity() %> Pieces Left</div>
						</div>
						<div class="flex space-x-3 mt-5">
								<button type="submit"
									class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center inline-flex items-center mr-2 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
									<svg aria-hidden="true" class="w-5 h-5 mr-2 -ml-1"
										fill="currentColor" viewBox="0 0 20 20"
										xmlns="http://www.w3.org/2000/svg">
									<path
											d="M3 1a1 1 0 000 2h1.22l.305 1.222a.997.997 0 00.01.042l1.358 5.43-.893.892C3.74 11.846 4.632 14 6.414 14H15a1 1 0 000-2H6.414l1-1H14a1 1 0 00.894-.553l3-6A1 1 0 0017 3H6.28l-.31-1.243A1 1 0 005 1H3zM16 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM6.5 18a1.5 1.5 0 100-3 1.5 1.5 0 000 3z"></path></svg>
									Add to cart
								</button>
							</form>
							<form>
								<button type="submit"
									class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center inline-flex items-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
									Review
									<svg aria-hidden="true" class="w-5 h-5 ml-2 -mr-1"
										fill="currentColor" viewBox="0 0 20 20"
										xmlns="http://www.w3.org/2000/svg">
									<path fill-rule="evenodd"
											d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z"
											clip-rule="evenodd"></path></svg>
								</button>
							</form>
						</div>
					</div>
				</div>
				<div class="flex flex-col ml-5 mt-40">
					<div class="my-3">Released <%= book.getDate() %></div>
					<div>
						<%= book.getDescription() %>
					</div>
				</div>
			</div>
				
			<script>
			document.getElementById("addToBasket").addEventListener("submit", function(event){
				// prevent default submission
				event.preventDefault();
				
				// Getting the input element
				let inputQuantity = document.getElementById("quantity-input");
				let quantityValue = inputQuantity.value;
				
				// constructing the URL
				let URL = "<%=request.getContextPath()%>/BasketServlet?ISBN=<%=book.getISBN()%>&Cart_id=null&quantity=" + quantityValue;
				
				// set value as form parameter
				document.getElementById("addToBasket").action = URL;
				
				// form submission
				document.getElementById("addToBasket").submit();
			})
			
			// Get the quantity elements
			const minusBtn = document.querySelector("#minus-btn");
			const quantityInput = document.querySelector("#quantity-input");
			const plusBtn = document.querySelector("#plus-btn");

			// Adding event listeners for plus and minus buttons
			// involking functions based on the input
			minusBtn.addEventListener('click', decreaseCount);
			plusBtn.addEventListener('click', increaseCount);

			function decreaseCount() {
				let currentQuantity = parseInt(quantityInput.value);
				if (currentQuantity > 1) {
					currentQuantity--;
					quantityInput.value = currentQuantity;
				}
			}

			function increaseCount() {
				// remember to conduct a check for if added quantity is above total quantity
				let currentQuantity = parseInt(quantityInput.value);
				currentQuantity++;
				quantityInput.value = currentQuantity;
			}
			</script>
			
			<%
				}
			}
			%>

		</div>
		<script>
			let url = window.location.href;
			if (url.includes("?")) {
				alert("Added to cart!")
			}
		</script>
</body>
</html>