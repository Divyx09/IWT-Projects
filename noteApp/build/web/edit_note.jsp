<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Note</title>
    <style>
        /* Reset default margin and padding */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Body Styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 0 20px;
            animation: changeBackground 15s ease-in-out infinite;
            background: linear-gradient(135deg, #ff7a18, #af002d);
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

        /* Container for the form */
        .form-container {
            background: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            margin-top: 40px;
            box-sizing: border-box;
            animation: fadeIn 1.5s ease-out;
        }

        @keyframes fadeIn {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }

        h1 {
            color: #333;
            font-size: 2rem;
            margin-bottom: 20px;
            text-align: center;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #6c5ce7;
            color: white;
            text-decoration: none;
            font-size: 1rem;
            border-radius: 5px;
            transition: background-color 0.3s, transform 0.3s;
            font-weight: 600;
            margin-bottom: 20px; /* Spacing between back button and form */
        }

        .btn:hover {
            background-color: #5a4dd3;
            transform: translateY(-3px);
        }

        input, textarea {
            width: 100%;
            padding: 10px;
            font-size: 1rem;
            border-radius: 5px;
            margin: 10px 0;
            border: 1px solid #ccc;
        }

        textarea {
            resize: vertical;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .form-container {
                padding: 30px 40px;
            }

            h1 {
                font-size: 1.8rem;
            }

            input, textarea, button {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>

    <div class="form-container">
        <!-- Back Button to go back to notes list -->
        <a href="notes.jsp" class="btn">Back to Notes</a>

        <h1>Edit Your Note</h1>

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
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                ps = conn.prepareStatement(sql);
                ps.setInt(1, noteId);
                rs = ps.executeQuery();
                if (rs.next()) {
                    String title = rs.getString("title");
                    String content = rs.getString("content");
        %>

        <form action="edit_note.jsp" method="POST">
            <input type="hidden" name="noteId" value="<%= noteId %>" />
            
            <!-- Title input field -->
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" value="<%= title %>" required />
            
            <!-- Content input field -->
            <label for="content">Content:</label>
            <textarea id="content" name="content" rows="4" required><%= content %></textarea>
            
            <!-- Save Button -->
            <button type="submit" class="btn" name="action" value="save">Save Changes</button>
        </form>

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

            // Handle form submission to save the edited note
            String action = request.getParameter("action");
            if ("save".equals(action)) {
                String newTitle = request.getParameter("title");
                String newContent = request.getParameter("content");

                try {
                    Connection connSave = DriverManager.getConnection(dbURL, dbUser, dbPass);
                    String updateSQL = "UPDATE notes SET title = ?, content = ? WHERE note_id = ?";
                    PreparedStatement psUpdate = connSave.prepareStatement(updateSQL);
                    psUpdate.setString(1, newTitle);
                    psUpdate.setString(2, newContent);
                    psUpdate.setInt(3, noteId);
                    psUpdate.executeUpdate();
                    psUpdate.close();
                    connSave.close();

                    // Redirect to the notes list after saving changes
                    response.sendRedirect("notes.jsp");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>

</body>
</html>
