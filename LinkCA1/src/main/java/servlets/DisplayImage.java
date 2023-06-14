package servlets;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		String isbn = request.getParameter("ISBN");

		try {
			// Establish the database connection
			Class.forName("com.mysql.jdbc.Driver");
			String jdbcUrl = "jdbc:mysql://localhost:3306/jadca?user=root&password=GapingJaw@2005&serverTimezone=UTC";
			Connection conn = DriverManager.getConnection(jdbcUrl);

			// Prepare the SQL statement to retrieve the image based on ISBN
			String sql = "SELECT image FROM booklist WHERE ISBN=?";
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, "022206676-8");

			// Execute the SQL statement and retrieve the result set
			ResultSet resultSet = statement.executeQuery();
			if (resultSet.next()) {
				// Retrieve the image data from the result set
				byte[] imageData = resultSet.getBytes("image");

				// Set the content type of the response
				response.setContentType("image/jpeg"); // Adjust the content type based on your image type

				// Write the image data to the response output stream
				OutputStream outputStream = response.getOutputStream();
				outputStream.write(imageData);
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
