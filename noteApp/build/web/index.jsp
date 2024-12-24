<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Notes App</title>
    <style>
        /* Reset default margin and padding */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Apply background color to the body */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f7f7f7;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        /* Container for the main content */
        .index-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #6c5ce7, #a29bfe);
            padding: 20px;
            text-align: center;
        }

        /* Content wrapper to center the text and buttons */
        .content-wrapper {
            background: #fff;
            padding: 40px 60px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h1 {
            color: #333;
            font-size: 2.5rem;
            margin-bottom: 20px;
        }

        .tagline {
            color: #555;
            font-size: 1.2rem;
            margin-bottom: 30px;
        }

        /* Style for buttons */
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .btn {
            display: inline-block;
            padding: 15px 30px;
            font-size: 1.1rem;
            text-decoration: none;
            border-radius: 25px;
            transition: background-color 0.3s, transform 0.3s;
            text-align: center;
            color: #fff;
        }

        .btn-primary {
            background-color: #6c5ce7;
        }

        .btn-primary:hover {
            background-color: #5a4dd3;
            transform: translateY(-3px);
        }

        .btn-secondary {
            background-color: #a29bfe;
        }

        .btn-secondary:hover {
            background-color: #8e8ae6;
            transform: translateY(-3px);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .content-wrapper {
                padding: 30px 40px;
            }

            h1 {
                font-size: 2rem;
            }

            .tagline {
                font-size: 1rem;
            }

            .btn {
                padding: 12px 24px;
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="index-container">
        <div class="content-wrapper">
            <h1>Welcome to the Notes App</h1>
            <p class="tagline">Manage your notes in a stylish and simple way. Login or Register to get started.</p>
            <div class="action-buttons">
                <a href="login.jsp" class="btn btn-primary">Login</a>
                <a href="register.jsp" class="btn btn-secondary">Register</a>
            </div>
        </div>
    </div>
</body>
</html>
