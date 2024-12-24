<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Note Details</title>
    <style>
        /* Reset default margin and padding */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Apply background animation to body */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
            animation: changeBackground 15s ease-in-out infinite;
            background-color: #f8f9fa; /* Light background for better readability */
        }

        /* Keyframes for smooth background color change */
        @keyframes changeBackground {
            0% {
                background: linear-gradient(135deg, #ff7a18, #af002d);
            }
            25% {
                background: linear-gradient(135deg, #ff6a00, #d7007f);
            }
            50% {
                background: linear-gradient(135deg, #00b09b, #96c93d);
            }
            75% {
                background: linear-gradient(135deg, #ff4b1f, #1fddff);
            }
            100% {
                background: linear-gradient(135deg, #ff7a18, #af002d);
            }
        }

        /* Centering and styling the note detail container */
        .note-detail-container {
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            width: 100%;
            text-align: center;
        }

        h1 {
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 30px;
        }

        p {
            font-size: 1.1rem;
            color: #555;
            line-height: 1.8;
            margin-bottom: 20px;
        }

        a {
            text-decoration: none;
            color: #0984e3;
            font-size: 1.2rem;
            margin-top: 20px;
            display: inline-block;
        }

        a:hover {
            color: #74b9ff;
        }
    </style>
</head>
<body>
    <div class="note-detail-container">
        <%
            int noteId = Integer.parseInt(request.getParameter("noteId"));
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
        %>
                    <h1><%= title %></h1>
                    <p><%= content %></p>
                    <a href="notes.jsp">Back to Notes</a>
        <%
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
        %>
    </div>
</body>
</html>
