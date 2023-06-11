package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
 * Servlet implementation class DisplayItems
 */
@WebServlet("/DisplayItems")
public class DisplayItems extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DisplayItems() {
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

		String cookieValue = null;

		// get all the cookies sent by the client
		Cookie[] cookies = request.getCookies();

		if (cookies != null) {
			// Iterate over cookies array
			for (Cookie cookie : cookies) {
				// check for the correct cookie name
				if (cookie.getName().equals("cartItemsCookie")) {
					// Get the value of cookies
					cookieValue = cookie.getValue();

					PrintWriter out = response.getWriter();
					out.println(cookieValue);
				}
			}

			// Splitting to get each individual cookie
			String[] bookValues = cookieValue.split("#");

			// Create an array to store the ISBN numbers
			// Creating an array with equal length
			String[] ISBNArray = new String[bookValues.length];

			// Looping through bookValues and extracting the ISBN numbers
			for (int i = 0; i < bookValues.length; i++) {
				String bookValue = bookValues[i];

				// Throw into another array and split by |
				String[] getISBN = bookValue.split("\\|");

				// Getting the ISBN number at index 0
				String ISBN = getISBN[0];

				// Storing ISBN numbers in the array
				ISBNArray[i] = ISBN;
			}

			// Create an arraylist to be sent in the session
			List<CartItems> ItemsList = new ArrayList<>();

			// initialize values
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			ResultSet resultSet = null;

			// Iterating over each ISBN
			for (String ISBN : ISBNArray) {
				try {
					// getting connection from DBUtility
					connection = DBUtility.getConnection();

					// Create the preparedStatement for the select statement
					String cartQuery = "SELECT oi.ISBN, oi.quantity, bl.title, bl.price, bl.imageURL FROM order_items AS oi INNER JOIN booklist AS bl On oi.ISBN = bl.ISBN WHERE oi.ISBN = ?";

					// Executing statement
					preparedStatement = connection.prepareStatement(cartQuery);
					preparedStatement.setString(1, ISBN);

					resultSet = preparedStatement.executeQuery();

					// getting the boolean result
					while (resultSet.next()) {
						String dbISBN = resultSet.getString("ISBN");
						String dbTitle = resultSet.getString("title");
						int dbQuantity = resultSet.getInt("quantity");
						double dbPrice = resultSet.getDouble("price");
						String dbImageURL = resultSet.getString("imageURL");

						// Create a new cart object
						CartItems displayCartItems = new CartItems(dbImageURL, dbTitle, dbISBN, dbPrice, dbQuantity);

						// Adding cart object to the list
						ItemsList.add(displayCartItems);
					}
					
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
			
			
			HttpSession session = request.getSession();
			session.setAttribute("ItemsToCheckout", ItemsList);
			PrintWriter out1 = response.getWriter();
			out1.println(session);
			
			// Redirect back to the page
			response.sendRedirect(request.getContextPath() + "/DisplayItems.jsp"); 
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
