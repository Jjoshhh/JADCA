package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import classes.Book;
import classes.DBUtility;

/**
 * Servlet implementation class UpdateBook
 */
@WebServlet("/UpdateBook")
@MultipartConfig
public class UpdateBook extends HttpServlet {
	private static final long serialVersionUID = 1L;
	// Variable the whole servlet can use
	private Book book = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateBook() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String isbn = request.getParameter("isbn");

		try {
			// Establish the database connection
			Connection conn = DBUtility.getConnection();

			// Prepare the SQL statement to retrieve the image based on ISBN
			String sql = "SELECT * FROM booklist WHERE ISBN=?";
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, isbn);

			// Execute the SQL statement and retrieve the result set
			ResultSet resultSet = statement.executeQuery();

			if (resultSet.next()) {
				// Calling result to add to object called Book
				String title = resultSet.getString("title");
				String date = resultSet.getString("date");
				String genre = resultSet.getString("genre");
				String description = resultSet.getString("description");
				String author = resultSet.getString("author");
				double price = resultSet.getDouble("price");
				int quantity = resultSet.getInt("quantity");
				String publisher = resultSet.getString("publisher");
				String publication = resultSet.getString("publication");
				String imageURL = resultSet.getString("imageURL");

				book = new Book(isbn, date, genre, description, title, author, price, quantity, publisher, publication,
						imageURL);
			}

			request.setAttribute("updatingBook", book);
			RequestDispatcher dispatcher = request.getRequestDispatcher("AddBook");
			dispatcher.forward(request, response);

			// Close the resources
			resultSet.close();
			statement.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

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

		Part imagePart = request.getPart("imageFile");
		InputStream imageStream = imagePart.getInputStream();
		// For testing later on
		String testStream = getStringFromPart(imagePart);
		
		try {
			// Initialize connection
			Connection conn = DBUtility.getConnection();
			// SQL Statement
			String sql = "UPDATE booklist SET ";

			// Parameters list
			List<Object> parameters = new ArrayList<>();

			// Lest no updates
			boolean updatesMade = false;

			// Check if the genre is updated
			if (!genre.equals(book.getGenre())) {
				sql += "genre = ?, ";
				parameters.add(genre);
				updatesMade = true;
			}

			// Check if the description is updated
			if (!description.equals(book.getDescription())) {
				sql += "description = ?, ";
				parameters.add(description);
				updatesMade = true;
			}

			// Check if the title is updated
			if (!title.equals(book.getTitle())) {
				sql += "title = ?, ";
				parameters.add(title);
				updatesMade = true;
			}

			// Check if the author is updated
			if (!author.equals(book.getAuthor())) {
				sql += "author = ?, ";
				parameters.add(author);
				updatesMade = true;
			}

			// Check if the price is updated
			if (price != book.getPrice()) {
				sql += "price = ?, ";
				parameters.add(price);
				updatesMade = true;
			}

			// Check if the quantity is updated
			if (quantity != book.getQuantity()) {
				sql += "quantity = ?, ";
				parameters.add(quantity);
				updatesMade = true;
			}

			// Check if the publisher is updated
			if (!publisher.equals(book.getPublisher())) {
				sql += "publisher = ?, ";
				parameters.add(publisher);
				updatesMade = true;
			}

			// Check if the publication is updated
			if (!publication.equals(book.getPublication())) {
				sql += "publication = ?, ";
				parameters.add(publication);
				updatesMade = true;
			}
			
			if (!testStream.equals(book.getImageURL())) {
				sql += "imageURL = ?, ";
				parameters.add(imageStream);
				updatesMade = true;
			}

			if (updatesMade) {
				// Remove the trailing comma and space from the SQL statement
				sql = sql.substring(0, sql.length() - 2);

				// Add the WHERE clause
				sql += " WHERE ISBN = ?;";

				// Append the ISBN parameter
				parameters.add(ISBN);

				// Preparing parameters
				PreparedStatement statement = conn.prepareStatement(sql);

				for (int i = 0; i < parameters.size(); i++) {
					statement.setObject(i + 1, parameters.get(i));
				}

				// Execute the SQL statement
				int rowsInserted = statement.executeUpdate();
				System.out.println(rowsInserted);
				if (rowsInserted > 0) {
					System.out.println("Success!");
				} else {
					System.out.println("Failure!");
				}

				// Close the resources
				if (imageStream != null) {
					imageStream.close();
				}
				statement.close();
				conn.close();
			} else {

			}

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
