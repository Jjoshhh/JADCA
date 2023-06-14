package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLIntegrityConstraintViolationException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import classes.DBUtility;

/**
 * Servlet implementation class AddBook
 */
@WebServlet("/AddBook")
@MultipartConfig
public class AddBook extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddBook() {
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
		// Retrieve book details
		Part titlePart = request.getPart("title");
		String title = getStringFromPart(titlePart);

		Part ISBNPart = request.getPart("ISBN");
		String ISBN = getStringFromPart(ISBNPart);

		Part genrePart = request.getPart("genre");
		String genre = getStringFromPart(genrePart);

		Part descriptionPart = request.getPart("description");
		String description = getStringFromPart(descriptionPart);

		Part authorPart = request.getPart("author");
		String author = getStringFromPart(authorPart);

		Part pricePart = request.getPart("price");
		double price = Double.parseDouble(getStringFromPart(pricePart));

		Part quantityPart = request.getPart("quantity");
		int quantity = Integer.parseInt(getStringFromPart(quantityPart));

		Part publisherPart = request.getPart("publisher");
		String publisher = getStringFromPart(publisherPart);

		Part publicationPart = request.getPart("publication");
		String publication = getStringFromPart(publicationPart);

		try {
			// Initialize connection
			Connection conn = DBUtility.getConnection();

			// SQL Statement
			String sql = "INSERT INTO booklist (ISBN, genre, description, title, author, price, quantity, publisher, publication, imageURL) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			// Preparing parameters
			PreparedStatement statement = conn.prepareStatement(sql);

			// Set parameter values
			statement.setString(1, ISBN);
			statement.setString(2, genre);
			statement.setString(3, description);
			statement.setString(4, title);
			statement.setString(5, author);
			statement.setDouble(6, price);
			statement.setInt(7, quantity);
			statement.setString(8, publisher);
			statement.setString(9, publication);

			// To access outside for loop to close later on
			InputStream imageStream = null;

			Part imagePart = request.getPart("imageFile");
			if (imagePart != null) {
				// Get the input stream of the image
				imageStream = imagePart.getInputStream();
				statement.setBinaryStream(10, imageStream);
			}

			// Execute the SQL statement
			int rowsInserted = statement.executeUpdate();
			System.out.println(rowsInserted);
			if (rowsInserted > 0) {
				// Image inserted successfully
				System.out.println("Success!");
			} else {
				// Failed to insert image
				System.out.println("Failure!");
			}

			// Close the resources
			if (imageStream != null) {
				imageStream.close();
			}
			statement.close();
			conn.close();

		} catch (SQLIntegrityConstraintViolationException e) {

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	private String getStringFromPart(Part part) throws IOException {
		InputStream inputStream = part.getInputStream();
		byte[] bytes = new byte[inputStream.available()];
		inputStream.read(bytes);
		return new String(bytes);
	}

}
