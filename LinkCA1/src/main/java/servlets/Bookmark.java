package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
 * Servlet implementation class Bookmark
 */
@WebServlet("/Bookmark")
public class Bookmark extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Bookmark() {
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
		Connection connection = DBUtility.getConnection();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		// Getting the parameter values
		String ISBN = request.getParameter("ISBN");
		String btnStatus = request.getParameter("status");
		System.out.print(btnStatus);

		// Getting session from request
		HttpSession session = request.getSession();

		// Retrieve data from the session
		List<BookClass> bookList = (List<BookClass>) session.getAttribute("bookList");

		// Invoke method
		toggleIcon(connection, btnStatus, ISBN);
		
		// ?search=&genre=#body
		response.sendRedirect(request.getContextPath() + "/Home.jsp");
	}
	
	private void toggleIcon(Connection connection, String btnStatus, String ISBN) {
		// initialize values
		PreparedStatement preparedStatement = null;
		String toggleQuery = null;
		ResultSet resultSet = null;
		int customer_id = 1;
		
		try {
			if (btnStatus.equals("unchecked")) {
				toggleQuery = "INSERT INTO bookmark (ISBN, customer_id) VALUES (?, ?)";
			} else {
				toggleQuery = "DELETE FROM bookmark WHERE ISBN = ? AND customer_id = ?";
			}

			System.out.println(customer_id);
			// Execute the query
			preparedStatement = connection.prepareStatement(toggleQuery);
			preparedStatement.setString(1, ISBN);
			preparedStatement.setInt(2, customer_id);

			// Execute query string
			preparedStatement.executeUpdate();

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
