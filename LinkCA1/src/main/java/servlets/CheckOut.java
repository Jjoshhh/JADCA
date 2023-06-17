package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import classes.DBUtility;

/**
 * Servlet implementation class CheckOut
 */
@WebServlet("/CheckOut")
public class CheckOut extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CheckOut() {
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

		// Initializing values
		String cookieValue = null;
		String cart_id = null;

		// Getting cookie value from the webpage
		Cookie[] cookies = request.getCookies();

		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("cartItemsCookie")) {
					cookieValue = (String) cookie.getValue();
					break;
				}
			}
		}
		
		// Splitting the cookie to get the cartID
		if (cookieValue != null) {
			String[] cookieValues = null;
			if (cookieValue.contains("#")) {
				cookieValues = cookieValue.split("#");
				cookieValue = cookieValues[0];
			}

			String[] getCartID = cookieValue.split("\\|");
			cart_id = getCartID[1];

			System.out.println(cart_id);
		}

		try {
			// Getting connection from DBUtility
			connection = DBUtility.getConnection();
			System.out.println("Updating Qty and Checkout");
			// Invoke methods
			removeFromInventory(connection, cart_id);
			int rowsAffected = deleteItems(connection, cart_id);
			removeCookies(rowsAffected, cookies, response);		
			
			response.sendRedirect(request.getContextPath() + "/Home.jsp?success=true");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// Method to delete from database and
	private int deleteItems(Connection connection, String cart_id) {
		// initialize values
		int rowsAffected = 0;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		try {
			// Delete statement for deleting records
			String clearCartQuery = "DELETE FROM order_items WHERE cart_id = ?";

			// Executing the statement
			preparedStatement = connection.prepareStatement(clearCartQuery);
			preparedStatement.setString(1, cart_id);
			
			// Execute query string
			rowsAffected = preparedStatement.executeUpdate();
			
			System.out.println("Rows affected: " + rowsAffected);
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (preparedStatement != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return rowsAffected;
	}
	
	private void removeFromInventory (Connection connection, String cart_id) {
		// initialize values
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		ResultSet resultSet1 = null;
		
		// Creating arraylist to store ISBN and quantity values
		ArrayList<String> ISBNList = new ArrayList<>();
		ArrayList<Integer> quantityList = new ArrayList<>();
		
		try {
			// Using cart_id to get all ISBN numbers and quantity
			String getValueQuery = "SELECT ISBN, quantity FROM order_items WHERE cart_id = ?";
			
			// Execute statement
			preparedStatement = connection.prepareStatement(getValueQuery);
			System.out.println("CartID:" + cart_id);
			preparedStatement.setString(1, cart_id);
			
			// Execute the query
			resultSet = preparedStatement.executeQuery();

			// Getting ISBN and Quantity
			while (resultSet.next()) {
				System.out.println("Hello from the inside");
				String getISBN = resultSet.getString("ISBN");
				int getQuantity = resultSet.getInt("quantity");
				
				// Adding to the arraylist
				ISBNList.add(getISBN);
				quantityList.add(getQuantity);
				
				for (String isbn : ISBNList) {
					System.out.println(isbn);
				}
				
				for (int quantity : quantityList) {
					System.out.println(quantity);
				}
			}
			
			// Loop through the list
			String updateQuery = "UPDATE booklist SET quantity = quantity - ? WHERE ISBN = ?";
			PreparedStatement preparedUpdateStatement = connection.prepareStatement(updateQuery);
			for (int i = 0; i < ISBNList.size(); i++) {
				preparedUpdateStatement.setInt(1, quantityList.get(i));
				preparedUpdateStatement.setString(2, ISBNList.get(i));
				preparedUpdateStatement.executeUpdate();
			}
			
			System.out.println("Update List");
			
		}catch (SQLException e) {
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
		}
	}
	
	/*
	 * private int[] getPurchaseItems (Connection connection, String ) {
	 * 
	 * }
	 */
	
	// Josh need to do this once cart_ID and customer_ID is up
	private void updateOrderList () {
		
	}
	
	// Remove the cookies once checkout
	private void removeCookies (int rowsAffected, Cookie[] cookies, HttpServletResponse response) {
		if (rowsAffected > 0) {
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("cartItemsCookie")) {
						// Force cookie to expire
						cookie.setValue("");
						cookie.setMaxAge(0);
						response.addCookie(cookie);
						break;
					}
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
