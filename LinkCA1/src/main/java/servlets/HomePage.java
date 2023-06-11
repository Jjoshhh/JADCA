package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpSession;

import classes.BookClass;
import classes.DBUtility;

import javax.persistence.criteria.Root;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.*;

//import com.cloudinary.*;

/**
 * Servlet implementation class HomePage
 */

@WebServlet("/HomePage")
public class HomePage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HomePage() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		// initialize values
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;

		try {
			// getting a connection from DBUtility class
			connection = DBUtility.getConnection();
			System.out.print(connection);
			PrintWriter out = response.getWriter();
			out.println("Some information on the browser...");

			String sqlStr = "SELECT * FROM booklist";
			
			// processing query
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sqlStr);
			
			// creating a arrayList for request attributes
			List<BookClass> bookList = new ArrayList<>();

			// Retrieve data from resultSet
			while (resultSet.next()) {
				String imageURL = resultSet.getString("imageURL");
				String title = resultSet.getString("title");
				double price = resultSet.getDouble("price");

				// creating bookClass instance
				BookClass bookclass = new BookClass(imageURL, title, price);

				// adding the bookClass to the list
				bookList.add(bookclass);
			}	
			
			// session
			HttpSession session = request.getSession();
			
			// set the dataList as an attribute in session object
			session.setAttribute("bookList", bookList);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (resultSet != null) {
				try {
					resultSet.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (statement != null) {
				try {
					statement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			DBUtility.closeConnection(connection);
		}
	}
}
