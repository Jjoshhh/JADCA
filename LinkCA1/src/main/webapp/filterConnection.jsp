
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement"%>
<%@ page import="java.util.List, java.util.ArrayList, java.net.*"%>
<%@ page import="classes.BookClass"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// database values
	String jdbcDriver = "com.mysql.jdbc.Driver";
	String dbURL = "jdbc:mysql://localhost:3306/jad_ca";
	String dbUsername = "root";
	String dbPassword = "GapingJaw@2005";

	// initializing values
	Connection connection = null;
	Statement statement = null;
	ResultSet resultSet = null;

	// search and checkbox combined

	// Getting the query parameter from the URL
	String getGenre = request.getParameter("genre");
	String getSearch = request.getParameter("search");
	String getPrice = request.getParameter("price");
	System.out.println("The search is " + getSearch);

	// Getting customer ID from the URL
		int customerID;
		if (session.getAttribute("cus_id") != null) {
			customerID = (int) session.getAttribute("cus_id");
		} else {
			customerID = 0;
		}
		System.out.println("This is the customerID " + customerID);

	// loading jdbc driver
	try {
		// declare prepared statement
		PreparedStatement preparedStatement = null;

		// loading jdbc driver
		Class.forName(jdbcDriver);
		connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

		try {
			// constructing the sql queries using StringBuilder
			// construct the base query
			StringBuilder newQuery = new StringBuilder(
			"SELECT bl.*, bm.customer_id FROM booklist as bl LEFT JOIN bookmark as bm ON bl.ISBN = bm.ISBN WHERE (bm.customer_id = ? OR bm.customer_id IS null) AND bl.quantity > 0");

			// Appending the price to the sql query
			if (getPrice != null && getPrice != "") {
		newQuery.append(" AND bl.price <= ?");
			}

			String[] genreArray = null;
			// if checkboxes are selected
			if (getGenre != null && getGenre != "") {
		newQuery.append(" AND bl.genre IN");

		genreArray = getGenre.split(",");
		System.out.println(genreArray.toString());

		for (String i : genreArray) {
			System.out.println(i);
		}
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < genreArray.length; i++) {
			sb.append("?,");
		}
		System.out.println(sb);
		System.out.println(sb.length());

		String sbstring = sb.substring(0, sb.length() - 1);
		newQuery.append("(" + sbstring + ")");
			}

			// if books are searched for
			if (getSearch != null && getSearch != "") {
		newQuery.append(" AND bl.title RLIKE ?");
			}

			// prepare the statement
			preparedStatement = connection.prepareStatement(newQuery.toString());

			preparedStatement.setInt(1, customerID);

			// Binding parameters
			int parameterIndex = 2;

			if (getPrice != null && getPrice != "") {
		double price = Double.parseDouble(getPrice);
		preparedStatement.setDouble(parameterIndex, price);
		parameterIndex++;
			}

			if (genreArray != null && getGenre != "") {
		// increment the index of the question 
		// originally 1 and increases each time
		for (int i = 0; i < genreArray.length; i++) {
			preparedStatement.setString(parameterIndex, genreArray[i]);
			parameterIndex++;
		}
			}

			if (getSearch != null && getSearch != "") {
		preparedStatement.setString(parameterIndex, getSearch);
			}

			System.out.println(preparedStatement);
			// Execute query
			resultSet = preparedStatement.executeQuery();

			// creating arraylist
			List<BookClass> bookList = new ArrayList<>();

			// processing and displaying of results
			while (resultSet.next()) {
		String ISBN = resultSet.getString("ISBN");
		String imageURL = resultSet.getString("imageURL");
		String title = resultSet.getString("title");
		double price = resultSet.getDouble("price");
		

		// creating a BookClass instance
		BookClass bookclass = new BookClass(imageURL, title, price, ISBN);

		// adding booklist to the arraylist
		bookList.add(bookclass);

			}

			// Get the session object
			HttpSession genreSession = request.getSession();

			genreSession.setAttribute("bookList", bookList);

			if (getSearch == null) {
		getSearch = "";
			}

			if (getGenre == null) {
		getGenre = "";
			}

			if (getPrice == null) {
		getPrice = "";
			}

			response.sendRedirect("Home.jsp?search=" + getSearch + "&genre=" + getGenre + "&price=" + getPrice);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// closing everything
			if (resultSet != null) {
		try {
			resultSet.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
			}
			if (statement != null) {
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
			}
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		// closing everything
		if (resultSet != null) {
			try {
		resultSet.close();
			} catch (SQLException e) {
		e.printStackTrace();
			}
		}
		if (statement != null) {
			try {
		connection.close();
			} catch (SQLException e) {
		e.printStackTrace();
			}
		}
	}
	%>
</body>
</html>
