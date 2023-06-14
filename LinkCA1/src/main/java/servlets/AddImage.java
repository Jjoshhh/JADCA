package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class AddImage
 */
@WebServlet("/AddImage")
public class AddImage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddImage() {
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
		String isbn = request.getParameter("ISBN");

		try {
	        // Check if the request is a multi-part request
	        boolean isMultipart = ServletFileUpload.isMultipartContent(request);

	        if (isMultipart) {
	            // Create a factory for disk-based file items
	            DiskFileItemFactory factory = new DiskFileItemFactory();

	            // Create a new file upload handler
	            ServletFileUpload upload = new ServletFileUpload(factory);

	            // Parse the request to get file items
	            List<FileItem> items = upload.parseRequest(request);

	            for (FileItem item : items) {
	                if (!item.isFormField() && "imageFile".equals(item.getFieldName())) {
	                    // Get the input stream of the image
	                    InputStream imageStream = item.getInputStream();

	                    // Establish the database connection
	                    Class.forName("com.mysql.jdbc.Driver");
	                    String jdbcUrl = "jdbc:mysql://localhost:3306/jadca?user=root&password=GapingJaw@2005&serverTimezone=UTC";
	                    Connection conn = DriverManager.getConnection(jdbcUrl);

	                    // Prepare the SQL statement
	                    String sql = "UPDATE booklist SET image = ? WHERE ISBN=?";
	                    PreparedStatement statement = conn.prepareStatement(sql);

	                    // Set the ISBN parameter
	                    statement.setString(2, "022206676-8");

	                    // Set the image parameter
	                    if (imageStream != null) {
	                        statement.setBinaryStream(1, imageStream);
	                    }

	                    // Execute the SQL statement
	                    int rowsInserted = statement.executeUpdate();
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
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
}
