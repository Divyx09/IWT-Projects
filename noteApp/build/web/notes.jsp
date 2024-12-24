<%@ page import="java.util.*, java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notes</title>
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

        /* Container for Notes */
        .notes-container {
            background: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 1000px;
            text-align: center;
            margin-top: 50px;
            box-sizing: border-box;
            animation: fadeIn 1.5s ease-out;
        }

        @keyframes fadeIn {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }

        h1 {
            font-size: 2.8rem;
            color: #333;
            margin-bottom: 30px;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
            text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.1);
            border-bottom: 2px solid #333; /* Adding the underline */
            padding-bottom: 10px; /* Adds space between the text and the underline */
        }

        /* Button Styles */
        .btn {
            display: inline-block;
            padding: 14px 28px;
            background-color: #6c5ce7;
            color: white;
            text-decoration: none;
            font-size: 1.3rem;
            border-radius: 8px;
            transition: background-color 0.3s ease, transform 0.2s ease-in-out;
            text-transform: uppercase;
            font-weight: 600;
        }

        .btn:hover {
            background-color: #5a4dd3;
            transform: translateY(-4px);
        }

        /* Back Button Styles */
        .back-btn {
            position: absolute;
            top: 20px;
            left: 20px;
            background-color: #ff7a18;
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            transition: background-color 0.3s ease, transform 0.2s ease-in-out;
            animation: changeButtonColor 15s ease-in-out infinite;
        }

        @keyframes changeButtonColor {
            0% {
                background-color: #ff7a18;
            }
            25% {
                background-color: #ff6a00;
            }
            50% {
                background-color: #00b09b;
            }
            75% {
                background-color: #ff4b1f;
            }
            100% {
                background-color: #ff7a18;
            }
        }

        .back-btn:hover {
            background-color: #af002d;
            transform: translateY(-3px);
        }

        /* Notes List Styling */
        .notes-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }

        /* Individual Note Item */
        .note-item {
            background-color: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-align: left;
            position: relative;
            overflow: hidden;
            box-sizing: border-box;
        }

        .note-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.05);
            z-index: -1;
            transition: all 0.3s ease;
        }

        .note-item:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
        }

        .note-item h3 {
            font-size: 1.9rem;
            color: #333;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .note-item p {
            font-size: 1.1rem;
            color: #555;
            margin-bottom: 20px;
            line-height: 1.6;
        }

        .note-item a,
        .note-item form button {
            background-color: #0984e3;
            color: white;
            font-size: 1.1rem;
            padding: 8px 16px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease-in-out;
            margin-top: 10px;
            font-weight: 600;
        }

        .note-item a:hover,
        .note-item form button:hover {
            background-color: #74b9ff;
            transform: translateY(-3px);
        }

        /* Form styling for buttons (Edit, Delete, Download) */
        form {
            border: 2px solid #e3e3e3;
            padding: 15px;
            margin-top: 10px;
            border-radius: 8px;
            background-color: #f7f7f7;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        form button {
            background: linear-gradient(45deg, #6c5ce7, #0984e3);
            border-radius: 8px;
            color: white;
            font-weight: 600;
            padding: 12px 24px;
            border: none;
            transition: all 0.3s ease-in-out;
            margin-right: 10px;
        }

        form button:hover {
            background: linear-gradient(45deg, #5a4dd3, #74b9ff);
            transform: translateY(-3px);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .notes-container {
                padding: 30px 20px;
            }

            h1 {
                font-size: 2rem;
            }

            .notes-list {
                grid-template-columns: 1fr;
                gap: 20px;
            }
        }
    </style>
</head>
<body>

    <!-- Back Button -->
    <a href="index.jsp" class="back-btn">Back</a>

    <div class="notes-container">
        <h1>Your Notes</h1>
        <a href="new_note.jsp" class="btn">Create New Note</a>

        <div class="notes-list">
            <!-- Loop through notes and display them -->
            <%
                // Database connection setup
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                String dbURL = "jdbc:mysql://localhost:3306/notes_app";
                String dbUser = "root";
                String dbPass = "";
                String sql = "SELECT * FROM notes";

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                    ps = conn.prepareStatement(sql);
                    rs = ps.executeQuery();

                    while (rs.next()) {
                        int noteId = rs.getInt("note_id");
                        String title = rs.getString("title");
                        String content = rs.getString("content");
            %>
            <div class="note-item">
                <h3><a href="note_detail.jsp?noteId=<%= noteId %>"><%= title %></a></h3>
                <p><%= content.length() > 100 ? content.substring(0, 100) + "..." : content %></p>
                
                <!-- Edit Button -->
                <form action="notes.jsp" method="POST" style="display:inline-block;">
                    <input type="hidden" name="noteId" value="<%= noteId %>" />
                    <button type="submit" name="action" value="edit">Edit</button>
                </form>
                
                <!-- Delete Button -->
                <form action="notes.jsp" method="POST" onsubmit="return confirm('Are you sure you want to delete this note?');" style="display:inline-block;">
                    <input type="hidden" name="noteId" value="<%= noteId %>" />
                    <button type="submit" name="action" value="delete">Delete</button>
                </form>

                <!-- Download Button -->
                <form action="download_note.jsp" method="POST" style="display:inline-block;">
                    <input type="hidden" name="noteId" value="<%= noteId %>" />
                    <button type="submit" name="action" value="download">Download</button>
                </form>
            </div>
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
    </div>

    <%
        // Handle note actions (edit and delete)
        String action = request.getParameter("action");
        String noteIdStr = request.getParameter("noteId");

        if (noteIdStr != null && !noteIdStr.isEmpty()) {
            int noteId = Integer.parseInt(noteIdStr);

            if ("delete".equals(action)) {
                // Deleting note
                try {
                    Connection connDel = DriverManager.getConnection(dbURL, dbUser, dbPass);
                    String deleteSQL = "DELETE FROM notes WHERE note_id = ?";
                    PreparedStatement psDel = connDel.prepareStatement(deleteSQL);
                    psDel.setInt(1, noteId);
                    psDel.executeUpdate();
                    psDel.close();
                    connDel.close();

                    // Redirect to reload the page after deletion
                    response.sendRedirect("notes.jsp");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else if ("edit".equals(action)) {
                // Handle edit action and show form to edit the note
                response.sendRedirect("edit_note.jsp?noteId=" + noteId);
            } else if ("download".equals(action)) {
                // Trigger the download logic
                response.sendRedirect("download_note.jsp?noteId=" + noteId);
            }
        }
    %>
</body>
</html>
