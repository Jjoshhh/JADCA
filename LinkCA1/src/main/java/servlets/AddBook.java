package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddBook
 */
@WebServlet("/AddBook")
public class AddBook extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddBook() {
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
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Retrieve book details
		String isbn = request.getParameter("ISBN");
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		String genre = request.getParameter("genre");
		String description = request.getParameter("description");
		String publication = request.getParameter("publication");
		String publisher = request.getParameter("publisher");
		double price = Double.parseDouble(request.getParameter("price"));
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		String imageURL = request.getParameter("imageURL");

		// Initialize SQL
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String connURL = "jdbc:mysql://localhost/jadca?user=root&password=GapingJaw@2005&serverTimezone=UTC";
			Connection conn = DriverManager.getConnection(connURL);

			String sql = "INSERT INTO booklist (isbn, genre, description, title, author, price, quantity, publisher, publication, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, isbn);
			statement.setString(2, genre);
			statement.setString(3, description);
			statement.setString(4, title);
			statement.setString(5, author);
			statement.setDouble(6, price);
			statement.setInt(7, quantity);
			statement.setString(8, publisher);
			statement.setString(9, publication);
			statement.setString(10, imageURL);

			int rowsInserted = statement.executeUpdate();
			if (rowsInserted > 0) {
				// Forward the request to the JSP page
				response.sendRedirect("addBook.jsp?status=success");
			} else {

			}
			// Closing tags
			statement.close();
			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
