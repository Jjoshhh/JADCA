<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*,classes.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Submit Review</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/32cc75cfc0.js"
	crossorigin="anonymous"></script>
<style>
.rating {
	direction: rtl;
	unicode-bidi: bidi-override;
}

.rating input[type="radio"] {
	display: none;
}

.rating label {
	color: #ddd;
	font-size: 30px;
	margin: 0;
	padding: 0;
	cursor: pointer;
	display: inline-block;
}

.rating label:before {
	content: "\f005";
	font-family: FontAwesome;
	font-weight: normal;
	font-style: normal;
	display: inline-block;
	text-shadow: 1px 1px #bbb;
	transform: rotateY(180deg);
}

.rating input[type="radio"]:checked ~ label:before, .rating input[type="radio"]:hover 
	 ~ label:before {
	color: gold;
}
</style>
</head>
<body>
	<div>
		<div class="flex justify-center items-center p-5">
			<p class="text-center text-3xl">Review's Section</p>
		</div>

		<%
		if (session.getAttribute("cus_id") != null) {
		%>
		<div class="my-10">
			<form class="flex flex-col justify-start mx-10"
				action="<%=request.getContextPath()%>/AddReview?isbn=<%=request.getParameter("isbn")%>"
				method="post">
				<div class="rating ">
					<input type="radio" name="rating" id="star5" value="5" /><label
						for="star5"></label> <input type="radio" name="rating" id="star4"
						value="4" /><label for="star4"></label> <input type="radio"
						name="rating" id="star3" value="3" /><label for="star3"></label>
					<input type="radio" name="rating" id="star2" value="2" /><label
						for="star2"></label> <input type="radio" name="rating" id="star1"
						value="1" /><label for="star1"></label>
				</div>
				<label for="description">Description:</label>
				<textarea name="description" id="description" rows="4"
					class="text-black" cols="50"></textarea>
				<!-- <input type="submit" value="Submit Review"> -->
				<div class="flex justify-end">
					<button type="submit"
						class="text-white bg-blue-700 hover:bg-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300 font-medium rounded-full text-sm px-5 py-2.5 text-center mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800 mt-2">Submit
						Review</button>
				</div>
			</form>
		</div>

		<script>
			$(document).ready(function() {
				// Set the rating value when a star is clicked
				$('.rating input[type="radio"]').click(function() {
					$('input[name="rating"]').val($(this).val());
				});
			});
		</script>
		<%
		}
		%>


		<!-- View all reviews -->
		<div class="flex flex-col-3">
			<%
			ArrayList<Review> reviews = (ArrayList<Review>) session.getAttribute("Reviews");
			if (reviews != null && reviews.size() > 0) {
				for (Review R : reviews) {
			%>
			<div>
				<div>
					<figure class="max-w-screen-md">

						<!-- Stars -->
						<jsp:include page="starRating.jsp">
							<jsp:param name="rating" value="<%=R.getRating()%>" />
						</jsp:include>

						<blockquote>
							<p class="text-2xl font-semibold text-white">
								"<%=R.getReview()%>"
							</p>
						</blockquote>
						<figcaption class="flex items-center mt-6 space-x-3">
							<img class="w-6 h-6 rounded-full"
								src="https://flowbite.s3.amazonaws.com/blocks/marketing-ui/avatars/bonnie-green.png"
								alt="profile picture">
							<div
								class="flex items-center divide-x-2 divide-gray-300 dark:divide-gray-700">
								<cite class="pr-3 font-medium text-white"><%=R.getCusName()%></cite>
							</div>
						</figcaption>
					</figure>
				</div>
				<div class="pt-5">
					<a href="DeleteReview?reviewID=<%=R.getReviewID()%>"
						class="focus:outline-none text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-900">Delete
						the Review</a>
				</div>
			</div>
			<%
			}
			} else {
			%>
			<div class="flex text-center justify-center items-center">
				<p class="text-xl text-bold">No reviews for this book!</p>
			</div>
			<%
			}
			%>
		</div>
	</div>
</body>
</html>
