<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*, classes.Book"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="./css/adminPage.css" />
<script src="./js/addBook.js"></script>
<title>Document</title>
</head>
<body>
	<%
	if (session.getAttribute("userRole") != (null) && session.getAttribute("userRole").equals("admin")) {
	%>
	<!--Navigation Bar-->
	<jsp:include page="adminNavBar.jsp"></jsp:include>

	<!--Main Body page-->
	<div class="container mx-auto w-2/3 md:min-w-screen rounded-lg p-10">
		<%
		Book BookU = (Book) request.getAttribute("updatingBook");
		%>
		<form
			action="<%=request.getContextPath()%>/UpdateBook?isbn=<%=BookU.getISBN()%>"
			method="post" enctype="multipart/form-data">

			<!--Header-->
			<div class="grid grid-cols-2">
				<div>
					<h2 class="text-4xl md:text-3xl,text-bold  text-white ">Update
						the book!</h2>
				</div>
				<div class="text-end">
					<input type="reset"
						class="rounded bg-white text-end text-gray-900 bg-white border border-gray-300 focus:outline-none hover:bg-gray-100 focus:ring-4 focus:ring-gray-200 font-medium rounded-full text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-gray-800 dark:text-white dark:border-gray-600 dark:hover:bg-gray-700 dark:hover:border-gray-600 dark:focus:ring-gray-700" />
					<input type="submit" name="submit" id="submit"
						class="rounded bg-white text-end text-gray-900 bg-white border border-gray-300 focus:outline-none hover:bg-gray-100 focus:ring-4 focus:ring-gray-200 font-medium rounded-full text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-gray-800 dark:text-white dark:border-gray-600 dark:hover:bg-gray-700 dark:hover:border-gray-600 dark:focus:ring-gray-700" />
				</div>
			</div>

			<div class="grid  md:grid-cols-3">
				<!-- Book Image -->
				<div class="self-center">
					<img id="imagePreview" src="DisplayImage?isbn=<%=BookU.getISBN()%>"
						alt="Image Preview" class="w-3/4 p-5"> <input type="file"
						name="imageFile" id="imageFile" onchange="previewImage(event)">
				</div>
				<!--Book Details-->
				<div class="md:col-start-2 col-span-2 ">
					<div class="grid lg:grid-cols-2  md:grid-cols-1 gap-2">


						<div class="flex flex-col">
							<label class="text-xl sm:text-l text-white">Title</label> <input
								type="text" name="title" id="title"
								class="rounded text-2xl sm:w-1/3,text-l"
								value="<%=BookU.getTitle()%>" />
						</div>


						<div class="flex flex-col">
							<label class="text-xl text-white">ISBN-Number</label> <input
								type="text" name="ISBN" id="ISBN" class="rounded text-2xl"
								value="<%=BookU.getISBN()%>" disabled />
						</div>


						<div class="flex flex-col">
							<label class="text-xl text-white">Publication</label> <input
								type="text" name="publication" id="publication"
								class="rounded text-2xl" value="<%=BookU.getPublication()%>" />
						</div>



						<div class="flex flex-col">
							<label class="text-xl text-white">Publisher</label> <input
								type="text" name="publisher" id="publisher"
								class="rounded text-2xl" value="<%=BookU.getPublisher()%>" />
						</div>


						<div class="flex flex-col">
							<label class="text-xl text-white">Author</label> <input
								type="text" name="author" id="author" class="rounded text-2xl"
								value="<%=BookU.getAuthor()%>" />
						</div>

						<div class="flex flex-col">
							<label class="text-xl text-white">Rating</label> <select
								id="rating" name="rating" class="rounded text-2xl"
								onchange="checkRating()">
								<option value="-1">Select Rating</option>
								<option value="G"
									<%if (BookU.getRating().equals("G")) {
	out.print("selected");
}%>>G</option>
								<option value="PG"
									<%if (BookU.getRating().equals("PG")) {
	out.print("selected");
}%>>PG</option>
								<option value="PG-13"
									<%if (BookU.getRating().equals("PG-13")) {
	out.print("selected");
}%>>PG-13</option>
								<option value="NC-16"
									<%if (BookU.getRating().equals("NC-16")) {
	out.print("selected");
}%>>NC-16</option>
								<option value="R-21"
									<%if (BookU.getRating().equals("R-21")) {
	out.print("selected");
}%>>R-21</option>
							</select>
						</div>

						<div class="flex flex-col">
							<label class="text-xl text-white">Genre</label> <select
								id="genre" name="genre" class="rounded text-2xl">
								<option value="-1">Select Genre</option>
								<%
								try {

									// Get the genres from the servlet's request attribute
									ArrayList<String> genres = (ArrayList<String>) request.getAttribute("genres");

									// Generate the dropdown options based on the genre data
									for (String genre : genres) {
										if (genre.equals(BookU.getGenre())) {
									out.println("<option selected value=\"" + genre + "\">" + genre + "</option>");
										} else {
									out.println("<option value=\"" + genre + "\">" + genre + "</option>");
										}

									}
								} catch (Exception e) {
									e.printStackTrace();
								}
								%>
							</select>
						</div>

						<div class="flex flex-col">
							<label class="text-xl text-white">Quantity</label> <input
								type="number" name="quantity" id="quantity"
								class="rounded text-2xl" value="<%=BookU.getQuantity()%>" />
						</div>
						<div class="flex flex-col">
							<label class="text-xl text-white">Price</label> <input
								type="number" step="any" name="price" id="price"
								class="rounded text-2xl" value="<%=BookU.getPrice()%>" />
						</div>
						<div class="flex flex-col grow">
							<label class="text-xl text-white">Description</label>
							<textarea name="description" id="description" rows="4"
								class="rounded text-2xl" value="<%=BookU.getDescription()%>"></textarea>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<%
	} else {
	response.sendRedirect("Home.jsp");
	}
	%>
</body>
<script>
	document.getElementById('submit').addEventListener('click',
			function(event) {
				const ratingSelect = document.getElementById('rating');
				const genreSelect = document.getElementById('genre');
				const ratingValue = ratingSelect.value;
				const genreValue = genreSelect.value;

				if (ratingValue === '-1') {
					ratingSelect.classList.add('border-red-800');
					event.preventDefault();
				} else {
					ratingSelect.classList.remove('border-red-800');
				}

				if (genreValue === '-1') {
					genreSelect.classList.add('border-red-800');
					event.preventDefault();
				} else {
					genreSelect.classList.remove('border-red-800');
				}
			});
	function previewImage(event) {
		const input = event.target;
		const preview = document.getElementById('imagePreview');
		if (input.files && input.files[0]) {
			const reader = new FileReader();
			reader.onload = function(e) {
				preview.setAttribute('src', e.target.result);
				preview.style.display = 'block';
			}
			reader.readAsDataURL(input.files[0]);
		} else {
			preview.style.display = 'none';
		}
	}
</script>
</html>
