package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classes.DBUtility;

/**
 * Servlet implementation class AddReview
 */
@WebServlet("/AddReview")
public class AddReview extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddReview() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String isbn = request.getParameter("isbn");
		String review = request.getParameter("description");
		int rating = Integer.parseInt(request.getParameter("rating"));
		
		HttpSession session = request.getSession(false);
		
		/* String cus_id = (String) session.getAttribute("cus_id"); */
		String cus_id = "1";
		
		System.out.println(isbn);
		System.out.println(rating);
		System.out.println(review);
		
		try {
			Connection conn = DBUtility.getConnection();
			String sql = "INSERT INTO review (customer_id, ISBN, review, rating) VALUES (?,?,?,?)";
			
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, cus_id);
			statement.setString(2, isbn);
			statement.setString(3, review);
			statement.setInt(4, rating);
			
			int rowsInsert = statement.executeUpdate();
			
			if(rowsInsert > 0) {
				System.out.println("Success");
				response.sendRedirect("Home.jsp?reviewAdded=true");
			} else {
				System.out.println("Failure");
				response.sendRedirect("Home.jsp?reviewAdded=false");
			}
			
			conn.close();
			statement.close();
			
		} catch(Exception e ) {
			e.printStackTrace();
		}
		
	}

}
