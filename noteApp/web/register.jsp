<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
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

        /* Container for the register form */
        .register-container {
            background: #fff;
            padding: 40px 60px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 100%;
            max-width: 400px;
            box-sizing: border-box;
            animation: fadeIn 1.5s ease-out;
        }

        @keyframes fadeIn {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }

        h2 {
            color: #333;
            font-size: 2rem;
            margin-bottom: 20px;
            font-weight: 700;
            text-transform: uppercase;
        }

        .error-message {
            color: red;
            margin-bottom: 15px;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        input {
            padding: 15px;
            font-size: 1rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            width: 100%;
            margin-bottom: 10px;
            transition: border 0.3s ease;
        }

        input:focus {
            border-color: #6c5ce7;
            outline: none;
        }

        button {
            padding: 15px;
            background-color: #6c5ce7;
            color: white;
            font-size: 1.1rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }

        button:hover {
            background-color: #5a4dd3;
            transform: translateY(-3px);
        }

        p {
            color: #555;
            font-size: 1rem;
            margin-top: 20px;
        }

        a {
            color: #6c5ce7;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .register-container {
                padding: 30px 40px;
            }

            h2 {
                font-size: 1.8rem;
            }

            input, button {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h2>Register</h2>

        <% if ("emptyFields".equals(request.getParameter("error"))) { %>
            <div class="error-message">
                <p>Please fill in all the fields.</p>
            </div>
        <% } else if ("passwordMismatch".equals(request.getParameter("error"))) { %>
            <div class="error-message">
                <p>Passwords do not match. Please try again.</p>
            </div>
        <% } else if ("usernameExists".equals(request.getParameter("error"))) { %>
            <div class="error-message">
                <p>Username already exists. Please choose another one.</p>
            </div>
        <% } else if ("sqlError".equals(request.getParameter("error"))) { %>
            <div class="error-message">
                <p>An SQL error occurred: <%= request.getParameter("message") %></p>
            </div>
        <% } %>

        <form action="RegisterServlet" method="POST">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
            <button type="submit">Register</button>
        </form>

        <p>Already have an account? <a href="login.jsp">Login here</a></p>
    </div>
</body>
</html>
