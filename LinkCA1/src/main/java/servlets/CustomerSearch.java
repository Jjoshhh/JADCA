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

import classes.DBUtility;
import classes.User;

/**
 * Servlet implementation class CustomerSearch
 */
@WebServlet("/CustomerSearch")
public class CustomerSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CustomerSearch() {
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
			if (option.equals("customer_id")) {
				sql += "SELECT * FROM customer WHERE customer_id LIKE CONCAT('%', ?, '%')";
			} else if (option.equals("firstName")) {
				sql += "SELECT * FROM customer WHERE first_name LIKE CONCAT('%', ?, '%')";
			} else if (option.equals("lastName")) {
				sql += "SELECT * FROM customer WHERE last_name LIKE CONCAT('%', ?, '%')";
			}


			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, searchQuery);

			resultSet = statement.executeQuery();
			List<User> cusList = new ArrayList<>(); 

			while (resultSet.next()) {
				String customerId = resultSet.getString("customer_id");
				String fName = resultSet.getString("first_name");
				String lName = resultSet.getString("last_name");
				String password = resultSet.getString("password");

				User u = new User(fName, lName, password, customerId);
				cusList.add(u);
			}

			request.setAttribute("cusList", cusList);

			// Closing tags
			resultSet.close();
			statement.close();
			connection.close();
			RequestDispatcher dispatcher = request.getRequestDispatcher("customerInv.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
