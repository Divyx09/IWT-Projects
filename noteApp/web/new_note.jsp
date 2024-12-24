<%@ page import="java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create/Edit Note</title>
    <style>
        /* Reset default margin and padding */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Apply background animation to body */
        body {
            font-family: 'Arial', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
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

        /* Back Button Styling */
        .back-btn {
            position: absolute;
            top: 20px;
            left: 20px;
            background-color: #6c5ce7;
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            transition: background-color 0.3s ease, transform 0.2s ease-in-out;
        }

        .back-btn:hover {
            background-color: #5a4dd3;
            transform: translateY(-3px);
        }

        /* Container for the create note form */
        .note-form-container {
            background: #fff;
            padding: 50px 70px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 100%;
            max-width: 600px;
        }

        h1 {
            color: #333;
            font-size: 2.5rem;
            margin-bottom: 30px;
            font-weight: 600;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        input, textarea {
            padding: 18px;
            font-size: 1.2rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            width: 100%;
            margin-bottom: 10px;
            resize: vertical;
            transition: border-color 0.3s ease;
        }

        textarea {
            height: 300px; /* Increased height for the textarea */
        }

        input:focus, textarea:focus {
            border-color: #6c5ce7;
            outline: none;
        }

        button {
            padding: 18px;
            background-color: #6c5ce7;
            color: white;
            font-size: 1.2rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s ease;
        }

        button:hover {
            background-color: #5a4dd3;
            transform: translateY(-3px);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .note-form-container {
                padding: 30px 40px;
            }

            h1 {
                font-size: 2rem;
            }

            input, textarea, button {
                font-size: 1rem;
            }
        }

    </style>
</head>
<body>
    <!-- Back Button -->
    <a href="notes.jsp" class="back-btn">Back</a>

    <div class="note-form-container">
        <h1>${noteId != null ? 'Edit Note' : 'Create New Note'}</h1>
        <form action="NoteServlet" method="POST">
            <input type="hidden" name="noteId" value="${noteId}" /> <!-- Hidden input for noteId -->
            <input type="text" name="title" placeholder="Note Title" value="${note != null ? note.title : ''}" required style="height: 50px;" /> <!-- Prefilled for editing, title box larger -->
            <textarea name="content" placeholder="Write your note here..." required style="height: 300px;">${note != null ? note.content : ''}</textarea> <!-- Prefilled for editing, content box larger -->
            <button type="submit">${noteId != null ? 'Update Note' : 'Save Note'}</button> <!-- Change button text based on action -->
        </form>
    </div>
</body>
</html>
