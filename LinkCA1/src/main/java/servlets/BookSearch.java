package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import classes.Book;
import classes.DBUtility;

/**
 * Servlet implementation class BookSearch
 */
@WebServlet("/BookSearch")
public class BookSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BookSearch() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String searchQuery = request.getParameter("searchQuery");
		String option = request.getParameter("option");
		if (searchQuery == null) {
			searchQuery = "";
		}

		// initialize values
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		try {
			connection = DBUtility.getConnection();
			String sql = "";

			// Assigning SQL statement based on option
			if (option.equals("isbn")) {
				sql += "SELECT * FROM booklist WHERE ISBN LIKE CONCAT('%', ?, '%')";
			} else if (option.equals("title")) {
				sql += "SELECT * FROM booklist WHERE title LIKE CONCAT('%', ?, '%')";
			}

			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, searchQuery);

			resultSet = statement.executeQuery();
			List<Book> bookList = new ArrayList<>(); // Assuming you have a Book class

			while (resultSet.next()) {

				// Calling result to add to object called Book
				String isbn = resultSet.getString("ISBN");
				String title = resultSet.getString("title");
				String date = resultSet.getString("date");
				String genre = resultSet.getString("genre");
				String description = resultSet.getString("description");
				String author = resultSet.getString("author");
				double price = resultSet.getDouble("price");
				int quantity = resultSet.getInt("quantity");
				String publisher = resultSet.getString("publisher");
				String publication = resultSet.getString("publication");
				String imageURL = resultSet.getString("imageURL");
				String rating = resultSet.getString("rating");

				Book book = new Book(isbn, date, genre, description, title, author, price, quantity, publisher,
						publication, imageURL, rating);
				bookList.add(book);
			}

			request.setAttribute("bookList", bookList);

			// Closing tags
			resultSet.close();
			statement.close();
			connection.close();
			// Forward the request to the JSP page
			RequestDispatcher dispatcher = request.getRequestDispatcher("bookInv.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
