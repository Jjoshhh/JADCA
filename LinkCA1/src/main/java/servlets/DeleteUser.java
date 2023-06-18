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
 * Servlet implementation class DeleteUser
 */
@WebServlet("/DeleteUser")
public class DeleteUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession(false);
			String cus_id = (String) session.getAttribute("cus_id");
			
			Connection conn = DBUtility.getConnection();
			String sql = "DELETE from customer WHERE customer_id = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, cus_id);
			
			int rowsInserted = stmt.executeUpdate();
			
			if(rowsInserted > 0) {
				System.out.println("Success");
				response.sendRedirect("---.jsp?userUpdate=true");
			} else {
				System.out.println("Failure");
				response.sendRedirect("---.jsp?userUpdate=false");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
