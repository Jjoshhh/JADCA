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
import javax.servlet.http.HttpSession;

import classes.DBUtility;
import classes.User;

/**
 * Servlet implementation class UpdateUser
 */
@WebServlet("/UpdateUser")
public class UpdateUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateUser() {
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
			HttpSession session = request.getSession(false);
			String cus_id = (String) session.getAttribute("cus_id");

			Connection conn = DBUtility.getConnection();
			String sql = "SELECT * FROM customer WHERE customer_id = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, cus_id);

			ResultSet results = stmt.executeQuery();
			User customer = null;

			while (results.next()) {
				String fName = results.getString("first_name");
				String lName = results.getString("last_name");
				String password = results.getString("password");

				customer = new User(fName, lName, password);
			}
			
			if (customer != null) {
				request.setAttribute("customerDetails", customer);
				System.out.println(customer.getfName() + "I AM WORKING");

			    RequestDispatcher dispatcher = request.getRequestDispatcher("ViewMemberDetails.jsp");
			    dispatcher.forward(request, response);
				System.out.println("Success going to view members");
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
		try {
			HttpSession session = request.getSession(false);
			String fName = request.getParameter("fName");
			String lName = request.getParameter("lName");
			String password = request.getParameter("password");
			String cus_id = (String) session.getAttribute("cus_id");

			Connection conn = DBUtility.getConnection();
			String sql = "UPDATE customer SET first_name = ?, last_name = ?, password = ? WHERE customer_id = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, fName);
			stmt.setString(2, lName);
			stmt.setString(3, password);
			stmt.setString(4, cus_id);

			int rowsInserted = stmt.executeUpdate();

			if (rowsInserted > 0) {
				System.out.println("Success");
				response.sendRedirect("Home.jsp?userUpdate=true");
			} else {
				System.out.println("Failure");
				response.sendRedirect("Home.jsp?userUpdate=false");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
