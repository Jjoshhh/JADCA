package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/bro")
public class AccountCreation extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AccountCreation() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String first_name = request.getParameter("firstName");
            String last_name = request.getParameter("lastName");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");

            Class.forName("com.mysql.jdbc.Driver");
            String connURL = "jdbc:mysql://localhost/jadca?user=root&password=GapingJaw@2005&serverTimezone=UTC";
            Connection conn = DriverManager.getConnection(connURL);
            Statement stmt = conn.createStatement();

            String sqlStr = "INSERT INTO customer (first_name, last_name, username, password, email, role_name) VALUES (?,?,?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sqlStr);
            pstmt.setString(1, first_name);
            pstmt.setString(2, last_name);
            pstmt.setString(3, username);
            pstmt.setString(4, password);
            pstmt.setString(5, email);
            pstmt.setString(6, "customer");

            pstmt.executeUpdate();

            response.sendRedirect(request.getContextPath() + "/login.jsp");

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
