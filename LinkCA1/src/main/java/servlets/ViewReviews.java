package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import classes.DBUtility;
import classes.Review;

/**
 * Servlet implementation class ViewReviews
 */
@WebServlet("/ViewReviews")
public class ViewReviews extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ViewReviews() {
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
			Connection conn = DBUtility.getConnection();
			String sql = "SELECT r.*, c.* FROM review r INNER JOIN customer c ON r.customer_id = c.customer_id WHERE ISBN=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, isbn);
			ResultSet result = stmt.executeQuery();

			ArrayList<Review> reviews = new ArrayList<Review>();

			while (result.next()) {
				String cus_id = result.getString("customer_id");
				int rating = result.getInt("customer_id");
				String reviewText = result.getString("review");
				String fName = result.getString("first_name");
				String lName = result.getString("last_name");
				String cusName = fName + " " + lName;
				Review review = new Review(cus_id, reviewText, rating, cusName);
				reviews.add(review);
			}
			request.setAttribute("Reviews", reviews);
			System.out.println(reviews);
			System.out.println("i am about to leave the servlet");
			response.sendRedirect(request.getContextPath() + "/bookDisplay.jsp");

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
