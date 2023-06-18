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

import classes.DBUtility;
import classes.User;

/**
 * Servlet implementation class GetUserDetails
 */
@WebServlet("/GetUserDetails")
public class AdminUserUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminUserUpdate() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String cus_id = request.getParameter("id");

			Connection conn = DBUtility.getConnection();
			String sql = "SELECT * FROM customer WHERE customer_id = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, cus_id);

			ResultSet results = stmt.executeQuery();
			User customer = null;

			while (results.next()) {
				String customerId = results.getString("customer_id");
				String fName = results.getString("first_name");
				String lName = results.getString("last_name");
				String password = results.getString("password");

				customer = new User(fName, lName, password, customerId);
			}

			if (customer != null) {
				request.setAttribute("customerD", customer);
				RequestDispatcher dispatcher = request.getRequestDispatcher("updateUser.jsp");
				dispatcher.forward(request, response);
			} else {
				System.out.println("Fail!");
				response.sendRedirect("bookInv.jsp");
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
		doGet(request, response);
	}

}
