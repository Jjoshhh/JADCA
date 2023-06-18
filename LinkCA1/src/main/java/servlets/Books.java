package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classes.BookClass;
import classes.DBUtility;
import classes.Review;

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
		// initialize values
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		int customer_id = 1;

		// getting query parameter from the URL
		String getTitle = request.getParameter("title");
		String isbn = request.getParameter("isbn");

		response.getWriter().append(getTitle);

		// Getting arraylist returned from the method
		ArrayList<BookClass> displayBookList = getBookValues(connection, getTitle);
		// Getting bookmarks from the method
		ArrayList<BookClass> displayBookmark = getBookmark(connection, customer_id);
		ArrayList<Review> reviews = getReviews(isbn);

		// Setting session from request
		HttpSession session = request.getSession();
		session.setAttribute("bookDetails", displayBookList);
		session.setAttribute("Bookmark", displayBookmark);

		session.setAttribute("Reviews", reviews);

		// redirect to book display page
		response.sendRedirect(request.getContextPath() + "/bookDisplay.jsp");
	}

	// Getting bookmark values from the database
	private ArrayList<BookClass> getBookmark(Connection connection, int customer_id) {
		// initialize values
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		// Getting connection from the database
		connection = DBUtility.getConnection();

		// Creating an arraylist to store
		ArrayList<BookClass> displayBookmark = new ArrayList();

		// Getting connection from the database
		connection = DBUtility.getConnection();

		try {
			String bookmarkQuery = "SELECT bl.ISBN, bl.ImageURL, bl.title, bl.price FROM booklist as bl INNER JOIN bookmark as bm ON bl.ISBN = bm.ISBN WHERE bm.customer_id = ?";

			// creating the prepared statement
			preparedStatement = connection.prepareStatement(bookmarkQuery);
			preparedStatement.setInt(1, customer_id);

			// Executing the query
			resultSet = preparedStatement.executeQuery();

			// Looping through resultSet and setting it in arraylist
			while (resultSet.next()) {
				String imageURL = resultSet.getString("ImageURL");
				String title = resultSet.getString("title");
				double price = resultSet.getDouble("price");
				String isbn = resultSet.getString("ISBN");
				// BookClass instance
				BookClass bookmark = new BookClass(imageURL, title, price, isbn);

				// Adding object to the arraylist
				displayBookmark.add(bookmark);
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
			if (preparedStatement != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return displayBookmark;
	}

	private ArrayList<BookClass> getBookValues(Connection connection, String title) {
		// initialize values
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		// Creating an arraylist to store
		ArrayList<BookClass> displayBookList = new ArrayList();

		// Getting connection from the database
		connection = DBUtility.getConnection();

		try {
			// creating sql query to be executed
			String titleQuery = "SELECT bl.ISBN, bl.date, bl.genre, bl.description, bl.title, bl.author, bl.price, bl.quantity, bl.publisher, bl.publication, bl.imageURL, avg(r.rating) AS ratin\r\n"
					+ " FROM booklist as bl LEFT JOIN review as r ON bl.ISBN = r.ISBN WHERE title = ?";

			// creating the prepared statement
			preparedStatement = connection.prepareStatement(titleQuery);
			preparedStatement.setString(1, title);

			// Executing the query
			resultSet = preparedStatement.executeQuery();

			// Looping through resultSet and setting it in arraylist
			while (resultSet.next()) {
				String imageURL = resultSet.getString("imageURL");
				String ISBN = resultSet.getString("ISBN");
				String releaseDate = resultSet.getString("date");
				String publisher = resultSet.getString("publisher");
				String description = resultSet.getString("description");
				String genre = resultSet.getString("genre");
				String author = resultSet.getString("author");
				double price = resultSet.getDouble("price");
				int quantity = resultSet.getInt("quantity");
				int rating = resultSet.getInt("ratin");
				String publication = resultSet.getString("publication");

				// books instance
				BookClass displayBooks = new BookClass(ISBN, releaseDate, genre, description, title, author, price,
						quantity, publisher, publication, imageURL, rating);

				// Adding object to the arraylist
				displayBookList.add(displayBooks);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("-------------------");
		System.out.println(displayBookList.size());
		System.out.println("-------------------");
		return displayBookList;
	}

	private ArrayList<Review> getReviews(String isbn) {
		ArrayList<Review> reviews = new ArrayList<Review>();
		try {
			Connection conn = DBUtility.getConnection();
			String sql = "SELECT r.*, c.* FROM review r INNER JOIN customer c ON r.customer_id = c.customer_id WHERE ISBN=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, isbn);
			ResultSet result = stmt.executeQuery();

			while (result.next()) {
				// To collate average rating
				int rating = result.getInt("rating");
				String review_id = result.getString("review_id");
				String cus_id = result.getString("customer_id");
				String reviewText = result.getString("review");
				String fName = result.getString("first_name");
				String lName = result.getString("last_name");
				String cusName = fName + " " + lName;

				System.out.println("--------------------------------------------");
				System.out.println("I just queried from MYSQL where rating is " + rating);
				System.out.println("--------------------------------------------");

				// Addding to arraylist
				if (cus_id != null && cusName != null && reviewText != null) {
					Review review = new Review(reviewText, rating, review_id, cusName);
					reviews.add(review);
				}
			}

			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reviews;
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
