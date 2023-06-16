package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classes.DBUtility;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Login() {
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
		// TODO Auto-generated method stub
		try {
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			// Initialize MySQL connection
			Connection conn = DBUtility.getConnection();
			
			// Verifying username and password
			String sqlStr = "SELECT * FROM customer WHERE email=? AND password=?";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1, email);
			pstmt.setString(2, password);

			ResultSet resultSet = pstmt.executeQuery();

			if (resultSet.next()) {
				String userRole = resultSet.getString("role_name");
				String cus_id = resultSet.getString("customer_id");
				
				System.out.println(cus_id);
				String cart = cus_id + RandGeneratedStr(10);
				System.out.println(cart);

				HttpSession session = request.getSession();
				session.setAttribute("userRole", userRole);
				session.setAttribute("cus_id", cus_id);
				// setting session to expiry in 30 mins
				session.setMaxInactiveInterval(30 * 60);

				Cookie cart_id = new Cookie("cart_id", cus_id);

				cart_id.setMaxAge(30 * 60);
				response.addCookie(cart_id);
				response.sendRedirect("Home.jsp");
			} else {
				response.sendRedirect("login.jsp?errCode=invalidLogin");
			}

			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// Method to generate random string
	static String RandGeneratedStr(int l)

	{

		// a list of characters to choose from in form of a string

		String AlphaNumericStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvxyz0123456789";

		// creating a StringBuffer size of AlphaNumericStr

		StringBuilder s = new StringBuilder(l);

		int i;

		for (i = 0; i < l; i++) {

			// generating a random number using math.random()

			int ch = (int) (AlphaNumericStr.length() * Math.random());

			// adding Random character one by one at the end of s

			s.append(AlphaNumericStr.charAt(ch));

		}

		return s.toString();

	}
}
