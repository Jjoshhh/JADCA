package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classes.BookClass;
import classes.DBUtility;

/**
 * Servlet implementation class Books
 */
@WebServlet("/Books")
public class Books extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Books() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		// initialize values
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		
		// getting query parameter from the URL
		String getTitle = request.getParameter("title");
		response.getWriter().append(getTitle);
		
		try {	
			// getting the connection from DBUtility class
			connection = DBUtility.getConnection();
			
			// creating sql query to be executed
			String titleQuery = "SELECT bl.ISBN, bl.date, bl.genre, bl.description, bl.title, bl.author, bl.price, bl.quantity, bl.publisher, bl.publication, bl.imageURL, r.rating \r\n" + "FROM booklist as bl LEFT JOIN review as r ON bl.ISBN = r.ISBN WHERE title =	?";
			
			// creating the prepared statement
			statement = connection.prepareStatement(titleQuery);
			statement.setString(1, getTitle);
			
			resultSet = statement.executeQuery();
			
			while (resultSet.next()) {
				/*
				 * String ISBN = resultSet.getString("ISBN"); PrintWriter out1 =
				 * response.getWriter(); out1.println(ISBN); out1.close();
				 */
				
				  String title = resultSet.getString("title"); 
				  String imageURL = resultSet.getString("imageURL"); 
				  String ISBN = resultSet.getString("ISBN");
				  String releaseDate = resultSet.getString("date"); 
				  String publisher = resultSet.getString("publisher"); 
				  String description = resultSet.getString("description");
				  String genre =resultSet.getString("genre"); 
				  String author = resultSet.getString("author");
				  double price = resultSet.getDouble("price"); 
				  int quantity = resultSet.getInt("quantity");
				  int rating = resultSet.getInt("rating"); 
				  String publication = resultSet.getString("publication");
				  
				  // creating an arraylist to store 
				  ArrayList<BookClass> displayBookList = new ArrayList();
				  
				  // books instance
				  BookClass displayBooks = new BookClass(ISBN, releaseDate, genre, description, title, author, price, quantity, publisher, publication, imageURL, rating);
				  displayBookList.add(displayBooks);
				 
				 // setting session attributes
      			 HttpSession session = request.getSession();
      			 session.setAttribute("bookDetails", displayBookList);
      			 
      			 // redirect to book display page
      			 response.sendRedirect(request.getContextPath() + "/bookDisplay.jsp");
			}
			
		}catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (resultSet !=  null) {
				try {
					resultSet.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (statement != null) {
				try {
					statement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			DBUtility.closeConnection(connection);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);

	}

}
