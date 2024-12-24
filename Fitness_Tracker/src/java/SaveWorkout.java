import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class SaveWorkout extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        // Retrieve parameters from the form
        String username = request.getParameter("username"); // Logged-in username
        String workoutName = request.getParameter("workoutName"); // Workout name
        String duration = request.getParameter("duration"); // Duration in HH:MM:SS format

        out.println("<html>");
        out.println("<body>");
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection to the database
            Connection con = DriverManager.getConnection("jdbc:mysql:///fit?useSSL=false", "root", "root");

            // SQL query to insert workout history
            String query = "INSERT INTO workout_history (username, workout_name, duration) VALUES (?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(query);

            // Set parameters for the prepared statement
            pstmt.setString(1, username);
            pstmt.setString(2, workoutName);
            pstmt.setString(3, duration);

            // Execute the update
            int result = pstmt.executeUpdate();

            if (result > 0) {
                out.println("<h3>Workout saved successfully!</h3>");
            } else {
                out.println("<h3>Failed to save the workout. Please try again.</h3>");
            }

            // Redirect back to the workout tracker page (optional)
            response.sendRedirect("tracker.html");

            // Close the connection
            con.close();

        } catch (Exception e) {
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        }

        out.println("</body>");
        out.println("</html>");
        out.close();
    }
}
