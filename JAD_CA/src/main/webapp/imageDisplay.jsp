<%@ page language="java" contentType="image/jpeg" pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedInputStream"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.OutputStream"%>
<%@ page import="java.sql.Blob"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    OutputStream outputStream = null;
    BufferedInputStream inputStream = null;

    try {
        // Establish the database connection
        Class.forName("com.mysql.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/jadca";
        String username = "root";
        String password = "GapingJaw@2005";
        conn = DriverManager.getConnection(jdbcUrl, username, password);

        // Prepare the SQL statement to retrieve the image
        String sql = "SELECT image FROM booklist WHERE title = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, 34); // Replace '1' with the actual record ID or parameter value

        // Execute the query
        rs = stmt.executeQuery();

        // If a result is found, retrieve the image data
        if (rs.next()) {
            Blob blob = rs.getBlob("image");
            
            if (blob != null) {
            	System.out.println(blob.toString());
            			
                inputStream = new BufferedInputStream(blob.getBinaryStream());
            }
        }

        // Set the response content type to indicate it's an image
        response.setContentType("image/jpeg");

        // Get the output stream from the response
        outputStream = response.getOutputStream();

        // Read the image data from the input stream and write it to the output stream
        byte[] buffer = new byte[4096];
        int bytesRead;
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }
    } catch (SQLException | ClassNotFoundException | IOException e) {
        e.printStackTrace();
    } finally {
        // Close the input stream, output stream, and database resources
        if (inputStream != null) {
            try {
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        if (outputStream != null) {
            try {
                outputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
