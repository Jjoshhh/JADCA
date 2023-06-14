package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tika.Tika;

import classes.DBUtility;

/**
 * Servlet implementation class DisplayImage
 */
@WebServlet("/DisplayImage")
public class DisplayImage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DisplayImage() {
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
			String sql = "SELECT imageURL FROM booklist WHERE ISBN=?";
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, isbn);
			System.out.println("------------------------" + isbn);
			// Execute the SQL statement and retrieve the result set
			ResultSet resultSet = statement.executeQuery();
			if (resultSet.next()) {
				// Retrieve the image data from the result set
				byte[] imageData = resultSet.getBytes("imageURL");

				// Set the content type of the response
				// Create a Tika instance
				Tika tika = new Tika();

				// Detect the image type from the image data
				String imageType = tika.detect(imageData);
				System.out.println("------------------------\n "+ imageType);
				// Set the content type based on the detected image type
				response.setContentType(imageType);

				// Write the image data to the response output stream
				OutputStream outputStream = response.getOutputStream();
				outputStream.write(imageData);
				outputStream.flush();
				outputStream.close();
			} else {
				// Load the default image data
				InputStream inputStream = getServletContext().getResourceAsStream("/img/placeholder_img.webp");

				response.setContentType("image/webp");

				// Write the default image data to the response output stream
				OutputStream outputStream = response.getOutputStream();
				byte[] buffer = new byte[4096];
				int bytesRead;
				while ((bytesRead = inputStream.read(buffer)) != -1) {
					outputStream.write(buffer, 0, bytesRead);
				}
				outputStream.flush();
				outputStream.close();
			}

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
	}
}
