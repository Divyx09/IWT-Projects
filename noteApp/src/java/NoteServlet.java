/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/NoteServlet")
public class NoteServlet extends HttpServlet {

    // Display Notes or Add/Edit Note
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("username") != null) {
            String username = (String) session.getAttribute("username");

            try (Connection conn = DatabaseConnection.getConnection()) {
                String query = "SELECT * FROM users WHERE username = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, username);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        int userId = rs.getInt("user_id");

                        // Fetch notes for this user
                        String noteQuery = "SELECT * FROM notes WHERE user_id = ? ORDER BY created_at DESC";
                        try (PreparedStatement noteStmt = conn.prepareStatement(noteQuery)) {
                            noteStmt.setInt(1, userId);
                            ResultSet noteRs = noteStmt.executeQuery();
                            request.setAttribute("notes", noteRs);
                            RequestDispatcher dispatcher = request.getRequestDispatcher("notes.jsp");
                            dispatcher.forward(request, response);
                        }
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("notes.jsp?error=true");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    // Add new or Edit existing note
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String noteId = request.getParameter("noteId");

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("username") != null) {
            String username = (String) session.getAttribute("username");

            try (Connection conn = DatabaseConnection.getConnection()) {
                String query = "SELECT * FROM users WHERE username = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, username);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        int userId = rs.getInt("user_id");

                        // If noteId is present, it's an update; otherwise, a new note is being created
                        if (noteId != null && !noteId.isEmpty()) {
                            // Update existing note
                            String updateQuery = "UPDATE notes SET title = ?, content = ? WHERE note_id = ? AND user_id = ?";
                            try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                                updateStmt.setString(1, title);
                                updateStmt.setString(2, content);
                                updateStmt.setInt(3, Integer.parseInt(noteId)); // Use the noteId from the form
                                updateStmt.setInt(4, userId);
                                updateStmt.executeUpdate();
                            }
                        } else {
                            // Insert new note
                            String insertQuery = "INSERT INTO notes (user_id, title, content) VALUES (?, ?, ?)";
                            try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                                insertStmt.setInt(1, userId);
                                insertStmt.setString(2, title);
                                insertStmt.setString(3, content);
                                insertStmt.executeUpdate();
                            }
                        }

                        response.sendRedirect("notes.jsp"); // Redirect to the notes page
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("notes.jsp?error=true");
            }
        } else {
            response.sendRedirect("login.jsp"); // Redirect to login if not logged in
        }
    }
}
