package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classes.DBUtility;

/**
 * Servlet implementation class AdminValidate
 */
@WebServlet("/AdminValidate")
public class AdminValidate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminValidate() {
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

		// getting query parameters from the URL
		String getEmail = request.getParameter("email");
		String getPassword = request.getParameter("password");

		try {
			// getting the connection from DBUtility class
			connection = DBUtility.getConnection();

			// creating the sql query to be executed
			String adminQuery = "SELECT password, role_name FROM admin WHERE email = ?";

			// creating prepared statement
			statement = connection.prepareStatement(adminQuery);
			statement.setString(1, getEmail);

			resultSet = statement.executeQuery();

			PrintWriter out = response.getWriter();

			Boolean found = false;

			while (resultSet.next()) {
				String password = resultSet.getString("password");
				String userRole = resultSet.getString("role_name");
				if (getPassword.equals(password)) {
					found = true;
					HttpSession session = request.getSession();
					// setting admin role
					session.setAttribute("userRole", "admin");
				}
			}
			if (!found) {
				response.sendRedirect(request.getContextPath() + "/Home.jsp?errCode=invalidLogin");
			} else {
				response.sendRedirect("bookInv.jsp");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (resultSet != null) {
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

	// Method to generate random string
	static String RandGeneratedStr(int l) {

		String AlphaNumericStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvxyz0123456789";
		StringBuilder s = new StringBuilder(l);

		int i;
		for (i = 0; i < l; i++) {
			int ch = (int) (AlphaNumericStr.length() * Math.random());
			s.append(AlphaNumericStr.charAt(ch));
		}

		return s.toString();

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
