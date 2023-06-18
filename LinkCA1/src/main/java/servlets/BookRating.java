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

/**
 * Servlet implementation class BookRating
 */
@WebServlet("/BookRating")
public class BookRating extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BookRating() {
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
			String sql = "SELECT avg(rating) AS fRating FROM review WHERE ISBN=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, isbn);
			ResultSet result = stmt.executeQuery();
			double rating = 0;

			while (result.next()) {
				rating = result.getDouble("fRating");
				System.out.println(rating);
			}

			int rRating = (int) Math.round(rating);
			request.setAttribute("avgRating", rRating);
			
			// Send back to file 
			RequestDispatcher dispatcher = request.getRequestDispatcher("/starRating.jsp");
			dispatcher.forward(request, response);
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
