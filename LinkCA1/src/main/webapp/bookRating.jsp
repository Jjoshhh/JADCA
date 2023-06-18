<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*, classes.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	String isbn = request.getParameter("isbn");
	try {
		Connection conn = DBUtility.getConnection();
		String sql = "SELECT avg(rating) AS fRating FROM review WHERE ISBN=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, isbn);
		ResultSet result = stmt.executeQuery();
		double rating = 0;

		while (result.next()) {
			rating = result.getDouble("fRating");
			System.out.println(rating);
		}

		int rRating = (int) Math.round(rating);
		request.setAttribute("avgRating", rRating);
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	%>
</body>
</html>