package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classes.CartItems;
import classes.DBUtility;

/**
 * Servlet implementation class RemoveBook
 */
@WebServlet("/RemoveBook")
public class RemoveBook extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RemoveBook() {
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

		// initialize values
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		// Getting the value of the ISBN parameter from the URL
		String removeISBN = request.getParameter("ISBN");

		// Iterate through all the cookies and get the retrieve the values
		Cookie[] cookies = request.getCookies();
		String cookieValue = null;
		String[] individualBooks = null;

		StringBuilder sb = new StringBuilder();

		// removing from cookies
		if (cookies != null) {
			// Iterate through the cookies and retrieve the values
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("cartItemsCookie")) {
					// Get the value of cookies
					cookieValue = cookie.getValue();
				}
			}

			individualBooks = cookieValue.split("#");

			// Iterate over book records
			for (String book : individualBooks) {
				if (!book.contains(removeISBN)) {
					// If current book does not match then append to the StringBuilder
					sb.append(book).append("#");
				}
			}

			// Remove any trailing # if it exist
			if (sb.length() > 0 && sb.charAt(sb.length() - 1) == '#') {
				sb.setLength(sb.length() - 1);
			}

			// Get the updated cookie value
			String updatedCookieValue = sb.toString();

			// Replace the with the new cookie
			Cookie newCookie = new Cookie("cartItemsCookie", updatedCookieValue);
			response.addCookie(newCookie);
		}

		// Deleting purchase record from the database
		try {
			// Getting connection from DBUtility
			connection = DBUtility.getConnection();

			// Invoke the delete records method
			deleteDbRecord(connection, removeISBN, individualBooks, response, request);
		} catch (Exception e) {
			e.printStackTrace();
		}

		response.sendRedirect(request.getContextPath() + "/DisplayItems.jsp");
	}

	public void deleteDbRecord(Connection connection, String ISBN, String[] individualBooks, HttpServletResponse response,
			HttpServletRequest request) {
		// initialize values
		HttpSession session = request.getSession();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		// Getting the cart_id of the customer
		String[] splitBookArr = individualBooks[0].split("\\|");
		String cartId = splitBookArr[1];

		try {
			// Creating an sql query for execution
			String deleteQuery = "DELETE FROM order_items WHERE ISBN = ? AND cart_id = ? ";

			// Execute the statement
			preparedStatement = connection.prepareStatement(deleteQuery);
			preparedStatement.setString(1, ISBN);
			preparedStatement.setString(2, cartId);

			// Execute the query string
			int rowsAffected = preparedStatement.executeUpdate();
			
			// Update the session with the new list	
			// getting the session details
		    List <CartItems> displayCartList = (List<CartItems>) session.getAttribute("ItemsToCheckout");
		    
		    // Using an iterator
		    Iterator<CartItems> iterator = displayCartList.iterator();
		    while(iterator.hasNext()) {
		    	CartItems cartList = iterator.next();
		    	if (ISBN.contains(cartList.getISBN())) {
		    		// Remove the book object with a matching ISBN
		    		iterator.remove();
		    		break;
		    	}
		    }
		    
			System.out.println("Rows affected: " + rowsAffected);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// closing everything
			if (resultSet != null) {
				try {
					resultSet.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (preparedStatement != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
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
