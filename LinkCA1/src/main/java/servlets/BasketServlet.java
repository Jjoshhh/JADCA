
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

import classes.CartItems;
import classes.DBUtility;

/**
 * Servlet implementation class BasketServlet
 */
@WebServlet("/BasketServlet")
public class BasketServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BasketServlet() {
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

		// Getting the input for the URL query parameter
		String ISBN = request.getParameter("ISBN");
		String Cart_id = null;
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		
		Cookie[] cookies = request.getCookies();
		for (Cookie c: cookies) {
			if(c.getName().equals("cart_id")) {
				Cart_id = (String) c.getValue();
			}
		}

		// initialize values
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		try {
			// Checking for existing items
			// Getting connection from DBUtility
			connection = DBUtility.getConnection();

			// Invoke compare method
			boolean duplicates = duplicatesCheck(connection, ISBN, Cart_id);

			if (!duplicates) {
				// Insert records into the database
				insertRecords(connection, ISBN, Cart_id, quantity);
			} else {
				updateRecords(connection, ISBN, Cart_id, quantity);
			}

			// Creating cookie to be sent out
			getCookieObj(connection, Cart_id, response, request);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private boolean duplicatesCheck(Connection connection, String ISBN, String Cart_id) {
		// initialize values
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		boolean hasDuplicates = false;

		try {
			// creating the sql query for execution
			String checkCartQuery = "SELECT IF ((SELECT COUNT(*) FROM jad_ca.order_items i WHERE i.ISBN = ? AND i.cart_id = ?) > 0, True, False)";

			// Executing statement
			preparedStatement = connection.prepareStatement(checkCartQuery);
			preparedStatement.setString(1, ISBN);
			preparedStatement.setString(2, Cart_id);

			// executing the query
			resultSet = preparedStatement.executeQuery();

			// getting boolean result
			if (resultSet.next()) {
				hasDuplicates = resultSet.getBoolean(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return hasDuplicates;
	}

	private void updateRecords(Connection connection, String ISBN, String Cart_id, int quantity) {
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		int currentQuantity = 0;
		int newQuantity = 0;

		try {
			// Select statement to check current quantity
			String checkQuantity = "SELECT quantity FROM order_items WHERE ISBN = ? AND cart_id = ?";

			// Executing statement
			preparedStatement = connection.prepareStatement(checkQuantity);
			preparedStatement.setString(1, ISBN);
			preparedStatement.setString(2, Cart_id);

			// executing the query
			resultSet = preparedStatement.executeQuery();

			// getting current quantity
			while (resultSet.next()) {
				currentQuantity = resultSet.getInt(1);
			}

			// new quantity
			newQuantity = currentQuantity + quantity;

			// Update new quantity
			String updateQuantity = "UPDATE order_items SET quantity = ? WHERE ISBN = ? AND cart_id = ?";

			// Executing statement
			preparedStatement = connection.prepareStatement(updateQuantity);
			preparedStatement.setInt(1, newQuantity);
			preparedStatement.setString(2, ISBN);
			preparedStatement.setString(3, Cart_id);

			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private void insertRecords(Connection connection, String ISBN, String Cart_id, int quantity) {
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		try {
			// Implementing logic if no duplicate records
			String newItemQuery = "INSERT INTO order_items (ISBN, cart_id, quantity) VALUES (?, ?, ?)";

			// Executing statement
			preparedStatement = connection.prepareStatement(newItemQuery);
			preparedStatement.setString(1, ISBN);
			preparedStatement.setString(2, Cart_id);
			preparedStatement.setInt(3, quantity);

			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private void getCookieObj(Connection connection, String Cart_id, HttpServletResponse response,
			HttpServletRequest request) {
		// Initialize variables
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		ArrayList<CartItems> cartItemsList = new ArrayList<>();

		try {
			// Getting all values for the cartID
			String sqlCart_ID = "SELECT oi.ISBN, oi.cart_id, bl.title, bl.imageURL, bl.price FROM order_items as oi INNER JOIN booklist as bl ON oi.ISBN = bl.ISBN WHERE oi.cart_id = ?";

			// Executing statement
			preparedStatement = connection.prepareStatement(sqlCart_ID);
			preparedStatement.setString(1, Cart_id);

			// executing the query
			resultSet = preparedStatement.executeQuery();

			// getting current quantity
			while (resultSet.next()) {
				String ISBN = resultSet.getString("ISBN");
				String cart_id = resultSet.getString("cart_id");
				String title = resultSet.getString("title");
				String imageURL = resultSet.getString("imageURL");
				double price = resultSet.getDouble("price");
				
				// converting title to no spacing
				String replacedTitle = title.replace(" ", "_");

				// Creating new cart object
				CartItems newCart = new CartItems(ISBN, cart_id, replacedTitle, imageURL, price);

				// Adding to an arraylist
				cartItemsList.add(newCart);
			}

			// converting arraylist to string
			StringBuilder sb = new StringBuilder();
			for (CartItems cartItem : cartItemsList) {
				sb.append(cartItem.getISBN()).append("|").append(cartItem.getCart_id()).append("|")
						.append(cartItem.getTitle()).append("|").append("").append("|")
						.append(cartItem.getPrice()).append("#");
			}

			String cartItemsString = sb.toString();
			System.out.println("CART ITEMS STRING: " + cartItemsString);

			// remove trailing #
			if (cartItemsString.endsWith("#")) {
				cartItemsString = cartItemsString.substring(0, cartItemsString.length() - 1);
			}

			// creating cookie and setting lifespan
			Cookie cartCookie = new Cookie("cartItemsCookie", cartItemsString);
			cartCookie.setMaxAge(24 * 60 * 60);
			System.out.println("Hello");
			
			// adding cookie to response
			response.addCookie(cartCookie);
			
			// Redirect back to the page
			response.sendRedirect(request.getContextPath() + "/bookDisplay.jsp?transaction=true"); 


		// remember to add back IOException e
		} catch (SQLException | IOException e) {
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
