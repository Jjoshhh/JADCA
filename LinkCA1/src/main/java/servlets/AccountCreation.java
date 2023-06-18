package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import classes.DBUtility;

/**
 * Servlet implementation class AccountCreation
 */
@WebServlet("/AccountCreation")
public class AccountCreation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccountCreation() {
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
            String first_name = request.getParameter("firstName");
            String last_name = request.getParameter("lastName");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");

            Connection conn = DBUtility.getConnection();
            Statement stmt = conn.createStatement();

            String sqlStr = "INSERT INTO customer (first_name, last_name, username, password, email, role_name) VALUES (?,?,?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sqlStr);
            pstmt.setString(1, first_name);
            pstmt.setString(2, last_name);
            pstmt.setString(3, username);
            pstmt.setString(4, password);
            pstmt.setString(5, email);
            pstmt.setString(6, "customer");

            pstmt.executeUpdate();

            response.sendRedirect(request.getContextPath() + "/login.jsp");

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
	}

}
