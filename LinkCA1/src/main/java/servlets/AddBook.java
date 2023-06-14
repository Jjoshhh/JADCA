package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

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
	private String getStringFromPart(Part part) throws IOException {
		InputStream inputStream = part.getInputStream();
		byte[] bytes = new byte[inputStream.available()];
		inputStream.read(bytes);
		return new String(bytes);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Retrieve book details
		Part titlePart = request.getPart("title");
		String title = getStringFromPart(titlePart);

		Part isbnPart = request.getPart("ISBN");
		String isbn = getStringFromPart(isbnPart);

		Part authorPart = request.getPart("author");
		String author = getStringFromPart(authorPart);

		Part publisherPart = request.getPart("publisher");
		String publisher = getStringFromPart(publisherPart);

		Part publicationPart = request.getPart("publication");
		String publication = getStringFromPart(publicationPart);

		Part descriptionPart = request.getPart("description");
		String description = getStringFromPart(descriptionPart);

		Part genrePart = request.getPart("genre");
		String genre = getStringFromPart(genrePart);

		Part pricePart = request.getPart("price");
		String price = getStringFromPart(pricePart);

		Part quantityPart = request.getPart("quantity");
		String quantity = getStringFromPart(quantityPart);

		double priceFinal = 0;
		int quantityFinal = 0;
		if (price != null) {
			try {
				priceFinal = Double.parseDouble(price);
			} catch (NumberFormatException e) {
				// Handle parsing error if needed
				e.printStackTrace();
			}
		}

		if (quantity != null) {
			try {
				quantityFinal = Integer.parseInt(quantity);
			} catch (NumberFormatException e) {
				// Handle parsing error if needed
				e.printStackTrace();
			}
		}

		try {
			boolean isMultipart = ServletFileUpload.isMultipartContent(request);

			if (isMultipart) {
				// Create a factory for disk-based file items
				DiskFileItemFactory factory = new DiskFileItemFactory();

				// Create a new file upload handler
				ServletFileUpload upload = new ServletFileUpload(factory);

				// Parse the request to get file items
				List<FileItem> items = upload.parseRequest(request);
				System.out.println("test1");

				// Handling file image
				for (FileItem item : items) {
					if (!item.isFormField() && "imageFile".equals(item.getFieldName())) {
						// Get the input stream of the image
						InputStream imageStream = item.getInputStream();

						// Initialize connection
						Class.forName("com.mysql.jdbc.Driver");
						String jdbcUrl = "jdbc:mysql://localhost/jad_ca?user=root&password=GapingJaw@2005&serverTimezone=UTC";
						Connection conn = DriverManager.getConnection(jdbcUrl);

						// SQL Statement
						String sql = "INSERT INTO booklist (ISBN, genre, description, title, author, price, quantity, publisher, publication, imageURL) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

						// Preparing parameters
						PreparedStatement statement = conn.prepareStatement(sql);
						statement.setString(1, isbn);
						statement.setString(2, genre);
						statement.setString(3, description);
						statement.setString(4, title);
						statement.setString(5, author);
						statement.setDouble(6, priceFinal);
						statement.setInt(7, quantityFinal);
						statement.setString(8, publisher);
						statement.setString(9, publication);

						// Set the image parameter
						if (imageStream != null) {
							statement.setBinaryStream(10, imageStream);
							System.out.println("I set the image stream!");
						}

						System.out.println("I am about to execute!");
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

						break; // No need to process other items
					}
					System.out.println("test1");
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
