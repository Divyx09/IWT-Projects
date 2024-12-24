import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class SessionCheck extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false); // Do not create a new session
        if (session != null && session.getAttribute("uname") != null) {
            String username = (String) session.getAttribute("uname");
            out.print(username); // Return the username
        } else {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // No active session
        }
    }
}
