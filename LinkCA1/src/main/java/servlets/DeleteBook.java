package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import classes.DBUtility;

/**
 * Servlet implementation class DeleteBook
 */
@WebServlet("/DeleteBook")
public class DeleteBook extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteBook() {
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
		System.out.println(isbn);
		try {
			Connection conn = DBUtility.getConnection();
			String sql = "DELETE FROM booklist WHERE ISBN=?";
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, isbn);
			// Execute the SQL statement
			int rowsDeleted = statement.executeUpdate();

			// Close the resources
			statement.close();
			conn.close();

			if (rowsDeleted > 0) {
				// Deletion successful
				System.out.println("Deletion successful!");
				response.sendRedirect("bookInv.jsp?deleteStatus=true");
			} else {
				// No book found with the given ISBN
				System.out.println("Error. Please Try Again!");
				response.sendRedirect("bookInv.jsp?deleteStatus=fail");
			}

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
		// TODO Auto-generated method stub

	}

}
