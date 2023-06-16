<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
	<form action="ReviewServlet" method="post">
		<div class="rating">
			<input type="radio" name="rating" id="star5" value="5" /><label
				for="star5"></label> <input type="radio" name="rating" id="star4"
				value="4" /><label for="star4"></label> <input type="radio"
				name="rating" id="star3" value="3" /><label for="star3"></label> <input
				type="radio" name="rating" id="star2" value="2" /><label
				for="star2"></label> <input type="radio" name="rating" id="star1"
				value="1" /><label for="star1"></label>
		</div>
		<br> <label for="description">Description:</label>
		<textarea name="description" id="description" rows="4" cols="50"></textarea>
		<br> <input type="submit" value="Submit Review">
	</form>
	<script>
		$(document).ready(function() {
			// Set the rating value when a star is clicked
			$('.rating input[type="radio"]').click(function() {
				$('input[name="rating"]').val($(this).val());
			});
		});
	</script>
</body>
</html>
