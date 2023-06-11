package classes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtility {
	private static final String jdbcDriver = "com.mysql.jdbc.Driver";
	private static final String dbURL = "jdbc:mysql://localhost:3306/jad_ca";
	private static final String dbUsername = "root";
	private static final String dbPassword = "z9N3Eif7Y5";

	// setting up connection to the database
	public static Connection getConnection() {
		// initialize values
		Connection connection = null;

		try {
			// loading mysql driver
			Class.forName(jdbcDriver);
			connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
			System.out.print("alls good");
		}catch (ClassNotFoundException e) {
			System.out.println("Error: MySQL JDBC driver not found.");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("Error: Failed to connect to the database.");
			e.printStackTrace();
		}
		return connection;
	}

	// closing database connection
	public static void closeConnection(Connection connection) {
		if (connection != null) {
			try {
				connection.close();
				System.out.println("Database connection closed.");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
