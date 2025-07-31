<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>FU House Finder - Forgot Password</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css">

        <style>
            .error-border {
                border-color: red;
            }
            .error-message {
                color: red;
                font-size: 0.875em;
            }

            body {
                background-color: #000;
                color: #fff;
                font-family: 'Segoe UI', sans-serif;
            }
            .header-top {
                background: #f5a623;
                padding: 5px 15px;
                font-size: 14px;
                display: flex;
                justify-content: space-between;
            }
            .navbar-custom {
                background: #000;
                border-bottom: 1px solid #333;
            }
            .navbar-custom .nav-link,
            .navbar-custom .navbar-brand {
                color: #fff;
            }
            .navbar-custom .nav-link:hover,
            .navbar-custom .navbar-brand:hover {
                color: #f5a623;
            }
            .form-container {
                max-width: 500px;
                margin: 80px auto;
                background-color: #111;
                padding: 40px;
                border-radius: 10px;
                border: 1px solid #333;
            }
            .form-control {
                background: #000;
                color: #fff;
                border: 1px solid #444;
            }
            .form-control::placeholder {
                color: #888;
            }
            .btn-login {
                background-color: #f5a623;
                color: #000;
                border: none;
            }
            .btn-login:hover {
                background-color: #e6991b;
            }
            .login-links a {
                color: #f5a623;
                text-decoration: none;
            }
            .login-links a:hover {
                text-decoration: underline;
            }

        </style>
    </head>
    <body>
        <div class="form-container">

            <h2 class="text-center mb-4">Forgot Password</h2>
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
            <div class="alert alert-danger">
                <%= errorMessage %>
            </div>
            <% } %>
            <form action="forgotPassword" method="post" id="forgotPasswordForm">
                <div class="mb-3">
                    <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                    <input type="email" name="email" class="form-control" id="email" placeholder="Enter your email" 
                           value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required>
                    <div class="error-message">
                        <%= request.getAttribute("errorEmailMessage") != null ? request.getAttribute("errorEmailMessage") : "" %>
                    </div>
                </div>
                <button type="submit" class="btn btn-warning w-100" style="color: white">Send Reset Link</button>
            </form>
            <a href="./login" class="btn btn-outline-secondary w-100 mt-3">Back to Login</a>


        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
