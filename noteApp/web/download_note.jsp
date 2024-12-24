<%@ page import="java.util.*, java.sql.*, java.io.*, java.nio.charset.StandardCharsets" %>
<%
    String noteIdStr = request.getParameter("noteId");
    if (noteIdStr != null && !noteIdStr.isEmpty()) {
        int noteId = Integer.parseInt(noteIdStr);

        // Database connection setup
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String dbURL = "jdbc:mysql://localhost:3306/notes_app";
        String dbUser = "root";
        String dbPass = "";
        String sql = "SELECT * FROM notes WHERE note_id = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            ps = conn.prepareStatement(sql);
            ps.setInt(1, noteId);
            rs = ps.executeQuery();

            if (rs.next()) {
                String title = rs.getString("title");
                String content = rs.getString("content");

                // Set the response headers for file download
                response.setContentType("text/plain");
                response.setHeader("Content-Disposition", "attachment; filename=\"" + title.replaceAll("\\s", "_") + ".txt\"");
                response.setCharacterEncoding("UTF-8");

                // Write the note content to the output stream
                try (BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(response.getOutputStream(), StandardCharsets.UTF_8))) {
                    writer.write("Title: " + title + "\n\n");
                    writer.write(content);
                    writer.flush();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
