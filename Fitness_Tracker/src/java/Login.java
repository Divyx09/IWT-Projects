import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class Login extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get login details from the request
        String username = request.getParameter("u1");
        String password = request.getParameter("u2");

        try {
            // Load and register JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql:///fit?useSSL=false&allowPublicKeyRetrieval=true", "root", "root");

            // Create SQL query
            String query = "SELECT * FROM Users WHERE UNAME=? AND UPASS=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, username);
            pstmt.setString(2, password);

            // Execute query
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // Valid credentials: Create a session and redirect to tracker.html
               HttpSession session = request.getSession();
                session.setAttribute("uname", username); // Set username in session
                session.setMaxInactiveInterval(30 * 60); // Optional: Set session timeout to 30 minutes
                response.sendRedirect("tracker.html"); // Redirect to tracker.html
            } else {
                // Invalid credentials: Show error message
                out.println("<html><body>");
                out.println("<h3 style='color: red;'>Invalid username or password!</h3>");
                out.println("<a href='login.html'>Try again</a>");
                out.println("</body></html>");
            }

            // Close connection
            con.close();
        } catch (Exception e) {
            // Handle exceptions
            out.println("<html><body>");
            out.println("<h3 style='color: red;'>Error: " + e.getMessage() + "</h3>");
            out.println("</body></html>");
        }

        out.close();
    }
}
