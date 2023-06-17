
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="classes.CartItems"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/9c1a7a3896.js"
	crossorigin="anonymous"></script>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="./css/DisplayItems.css">
</head>

<body>

	<%
	final DecimalFormat decimalFormat = new DecimalFormat("#0.00");
	double totalPrice = 0;
	%>
	<div class="bg-[dark]">
		<%@include file="navBar.jsp"%>
	</div>

	<div class="flex justify-center mt-[164px]">
		<div class="bg-white w-3/4 aspect-[2.5/1] rounded-xl">
			<div class="mx-10">
				<div class="text-3xl font-bold mt-3 mb-4" id="title">Items
					Checkout</div>
				<hr class="border-2 h-px bg-gray-200 border-0 dark:bg-gray-700">
				<div class="flex flex-col justify-start overflow-scroll h-[375px]"
					id="cart-contents">

					<%
					if (!(request.getParameter("clearCart") != null)) {

						if (session.getAttribute("ItemsToCheckout") != null && session.getAttribute("ItemsToCheckout") != "") {

							// getting the session details
							List<CartItems> displayCartList = (List<CartItems>) session.getAttribute("ItemsToCheckout");

							// Initializing variables
							String dbISBN = null;
							String dbTitle = null;
							int dbQuantity = 0;
							double dbPrice = 0;
							String dbImageURL = null;

							// If arraylist has contents
							// loop through everything and display
							System.out.println(displayCartList != null);
							System.out.println(!displayCartList.isEmpty());
							if (displayCartList != null && !displayCartList.isEmpty()) {
						for (CartItems item : displayCartList) {
							dbISBN = item.getISBN();
							dbTitle = item.getTitle();
							dbQuantity = item.getQuantity();
							dbPrice = item.getPrice();
							dbImageURL = item.getImageURL();

							// Calculating the itemList and prices
							double itemTotal = dbPrice * dbQuantity;
							totalPrice += itemTotal;
					%>

					<div
						class="grid displayGrid bg-[black] w-full aspect-[7/1] my-5 rounded-xl items-center text-white font-semibold text-xl">
						<img class="bg-[#D9D9D9] m-3 w-24 aspect-[1/1.5] rounded-xl"
							src="" alt="" />
						<div class="flex flex-col w-full">
							<div class="" id="title"><%=dbTitle%></div>
							<div class="py-2" id="ISBN"><%=dbISBN%></div>
						</div>
						<div class="" id="price">
							$<%=dbPrice%></div>
						<div><%=dbQuantity%>
							Pieces
						</div>
						<form class="p-4"
							action="<%=request.getContextPath()%>/RemoveBook?ISBN=<%=dbISBN%>"
							method="post">
							<button type="submit">
								<i class="fa-solid fa-xmark text-3xl" style="color: #ff0000;"></i>
							</button>
						</form>
					</div>

					<%
					}
					}
					}
					} else if(request.getParameter("clearCart").equals("true")) {
					%>
					<div class="self-center text-4xl font-bold">No Items In Cart!</div>

					<style>
#cart-contents {
	justify-content: center;
	``
}
</style>
				</div>
				<%
				}
				%>


				<hr class="border-2 h-px bg-gray-200 border-0 dark:bg-gray-700">
				<div class="flex text-3xl font-bold my-3 justify-between">
					<div class="justify-start">Total Cost:</div>
					<div class="flex justify-end">
						<p class="mr-2 mt-0.5">
							$<%=decimalFormat.format(totalPrice)%></p>
						<form action="<%=request.getContextPath()%>/CheckOut"
							class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center inline-flex items-center mr-2 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800 ml-3">
							<button type="submit">
								<svg aria-hidden="true" class="w-5 h-5 mr-2 -ml-1"
									fill="currentColor" viewBox="0 0 20 20"
									xmlns="http://www.w3.org/2000/svg">
								<path
										d="M3 1a1 1 0 000 2h1.22l.305 1.222a.997.997 0 00.01.042l1.358 5.43-.893.892C3.74 11.846 4.632 14 6.414 14H15a1 1 0 000-2H6.414l1-1H14a1 1 0 00.894-.553l3-6A1 1 0 0017 3H6.28l-.31-1.243A1 1 0 005 1H3zM16 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM6.5 18a1.5 1.5 0 100-3 1.5 1.5 0 000 3z"></path></svg>
								Check Out
							</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 
	<script>
		if (window.location.href.includes("?")) {
			alert("Transaction Approved!");
			window.location.href = "./Home.jsp";
		}
	</script>
 -->
</body>
</html>
