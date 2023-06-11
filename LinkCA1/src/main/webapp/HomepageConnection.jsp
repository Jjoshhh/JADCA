<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession"%>
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
	String dbPassword = "z9N3Eif7Y5";

	// initializing values
	Connection connection = null;
	Statement statement = null;
	ResultSet resultSet = null;

	// sql statement for accessing and populating checkboxes
	try {
		// Connecting to the database
		// loading jdbc driver
		Class.forName(jdbcDriver);
		connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

		// Executing the sql statement
		String sqlGenre = "SELECT DISTINCT genre FROM booklist";

		// processing query
		statement = connection.createStatement();
		resultSet = statement.executeQuery(sqlGenre);

		// creating arraylist
		List<String> genreList = new ArrayList<>();

		// looping through and getting results 
		while (resultSet.next()) {
			String genre = resultSet.getString("genre");

			// adding booklist to the arraylist
			genreList.add(genre);

			// Get the session object
			HttpSession genreSession = request.getSession();

			genreSession.setAttribute("genreList", genreList);
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