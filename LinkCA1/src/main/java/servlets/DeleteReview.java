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
 * Servlet implementation class DeleteReview
 */
@WebServlet("/DeleteReview")
public class DeleteReview extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteReview() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String reviewID = request.getParameter("reviewID");

		try {
			Connection conn = DBUtility.getConnection();
			String sql = "DELETE FROM review WHERE review_id=?";

			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, reviewID);

			int rowsInsert = statement.executeUpdate();

			if (rowsInsert > 0) {
				System.out.println("Success");
				response.sendRedirect("Home.jsp?reviewDeleted=true");
			} else {
				System.out.println("Failure");
				response.sendRedirect("Home.jsp?reviewDeleted=false");
			}

			conn.close();
			statement.close();

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
