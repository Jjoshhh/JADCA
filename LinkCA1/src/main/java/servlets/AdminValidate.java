package servlets;

import java.sql.*;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classes.BookClass;
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
			String adminQuery = "SELECT password FROM admin WHERE email = ?";

			// creating prepared statement
			statement = connection.prepareStatement(adminQuery);
			statement.setString(1, getEmail);

			resultSet = statement.executeQuery();

			PrintWriter out = response.getWriter();
			
			Boolean found = false;

			while (resultSet.next()) {
				String password = resultSet.getString("password");
				if(getPassword.equals(password)) {
					found = true;
					
					// setting http attribute
					HttpSession session = request.getSession();
					
					// setting admin role
					session.setAttribute("userRole", "admin");
				}
			}
			if (!found) {
				response.sendRedirect(request.getContextPath() + "/Home.jsp?errCode=invalidLogin"); 
			}else {
				// redirect admin user
				/* response.sendRedirect(request.getContextPath() + "/bookDisplay.jsp"); */
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
