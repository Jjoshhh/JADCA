package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import classes.Book;
import classes.DBUtility;

/**
 * Servlet implementation class UpdateBook
 */
@WebServlet("/UpdateBook")
public class UpdateBook extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateBook() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String isbn = request.getParameter("isbn");

		try {
			// Establish the database connection
			Connection conn = DBUtility.getConnection();

			// Prepare the SQL statement to retrieve the image based on ISBN
			String sql = "SELECT * FROM booklist WHERE ISBN=?";
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, isbn);

			// Execute the SQL statement and retrieve the result set
			ResultSet resultSet = statement.executeQuery();

			Book book = null;
			if (resultSet.next()) {
				// Calling result to add to object called Book
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

				book = new Book(isbn, date, genre, description, title, author, price, quantity, publisher, publication,
						imageURL);
			}

			request.setAttribute("updatingBook", book);
			RequestDispatcher dispatcher = request.getRequestDispatcher("AddBook");
		    dispatcher.forward(request, response);

			// Close the resources
			resultSet.close();
			statement.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}

}
