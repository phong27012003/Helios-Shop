<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>HELIOS - Create Account</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                background-color: #000;
                color: #fff;
                font-family: 'Segoe UI', sans-serif;
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .register-form {
                width: 100%;
                max-width: 500px;
                padding: 40px;
                background-color: #000;
            }
            .form-control {
                background-color: #000;
                color: #fff;
                border: 1px solid #444;
                border-radius: 0;
                padding: 15px;
                margin-bottom: 20px;
            }
            .form-control::placeholder {
                color: #888;
            }
            .btn-register {
                background-color: #f5a623;
                color: #000;
                border: none;
                padding: 15px;
                font-weight: 500;
            }
            .btn-register:hover {
                background-color: #e6991b;
            }
            .bottom-links {
                margin-top: 20px;
                text-align: center;
            }
            .bottom-links a {
                color: #f5a623;
                text-decoration: none;
            }
            .bottom-links a:hover {
                text-decoration: underline;
            }
            .error-border {
                border-color: red;
            }
            .error-message {
                color: red;
                font-size: 0.875em;
            }
        </style>
    </head>
    <body>
        <div class="register-form">

            <h2 class="text-center mb-4">Tạo Tài Khoản</h2>
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
            <div class="alert alert-danger">
                <%= errorMessage %>
            </div>
            <% } %>
            <form action="register" method="post" id="registerForm">
                <div class="mb-3">
                    <input type="text" name="fname" class="form-control" id="firstName" placeholder="Tên"
                           value="<%= request.getAttribute("fname") != null ? request.getAttribute("fname") : "" %>">
                    <div class="error-message">
                        <%= request.getAttribute("errorfNameMessage") != null ? request.getAttribute("errorfNameMessage") : "" %>
                    </div>
                </div>
                <div class="mb-3">
                    <input type="text" name="lname" class="form-control" id="lastName" placeholder="Họ"
                           value="<%= request.getAttribute("lname") != null ? request.getAttribute("lname") : "" %>">
                    <div class="error-message">
                        <%= request.getAttribute("errorlNameMessage") != null ? request.getAttribute("errorlNameMessage") : "" %>
                    </div>
                </div>
                <div class="mb-3">

                    <input type="email" name="email" class="form-control" id="email" placeholder="Email"
                           value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">
                    <div class="error-message">
                        <%= request.getAttribute("errorEmailMessage") != null ? request.getAttribute("errorEmailMessage") : "" %>
                    </div>
                </div>
                <div class="mb-3">

                    <input type="text" name="phone" class="form-control" id="phone" placeholder="Số điện thoại"
                           value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>">
                    <div class="error-message">
                        <%= request.getAttribute("errorPhoneMessage") != null ? request.getAttribute("errorPhoneMessage") : "" %>
                    </div>
                </div>
                <div class="mb-3 position-relative">

                    <input type="password" name="pass" class="form-control" id="password" placeholder="Nhập mật khẩu"
                           value="<%= request.getAttribute("password") != null ? request.getAttribute("password") : "" %>">
                    <div class="error-message">
                        <%= request.getAttribute("errorPasswordMessage") != null ? request.getAttribute("errorPasswordMessage") : "" %>
                    </div>
                </div>
                <div class="mb-3 position-relative">

                    <input type="password" name="confirmPassword" class="form-control" id="confirmPassword" placeholder="Xác nhận mật khẩu"
                           value="<%= request.getAttribute("confirmPassword") != null ? request.getAttribute("confirmPassword") : "" %>">
                    <div class="error-message">
                        <%= request.getAttribute("errorConfirmMessage") != null ? request.getAttribute("errorConfirmMessage") : "" %>
                    </div>
                </div>
                <button type="submit" name="btnRegister" class="btn btn-warning w-100" style="color: white">Register</button>
            </form>
            <a href="./login" class="btn btn-outline-secondary w-100 mt-3">Already have an account</a>

        </div>

        <!-- Bootstrap JS and Bootstrap Icons -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.js"></script>
      
    </body>
</html>
