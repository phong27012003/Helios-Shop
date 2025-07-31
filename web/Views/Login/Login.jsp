<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>HELIOS - Đăng nhập</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css">
        <style>
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
        <!-- Header -->
        <%@include file="../Partials/Header.jsp" %>
        <!-- Hiển thị Toast thông báo nếu có -->
        <c:if test="${not empty param.successMessage}">
            <div class="toast align-items-center text-bg-success border-0 position-fixed top-0 end-0 p-3" role="alert" aria-live="assertive" aria-atomic="true" id="successToast" style="z-index: 9999; color: #87bbf2">
                <div class="d-flex">
                    <div class="toast-body" style="color: red">
                        ${param.successMessage}
                    </div>
                    <button type="button" class="btn-close btn-close-black me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        </c:if>
        <div class="form-container">
            <h2 class="text-center mb-4">Đăng Nhập</h2>
            <!-- Display General Error Messages -->
            <c:if test="${not empty loginError}">
                <div class="alert alert-danger mb-3" style="border-radius: 20px">
                    ${loginError}
                </div>
            </c:if>
            <c:if test="${not empty exceptionError}">
                <div class="alert alert-danger mb-3" style="border-radius: 20px">
                    ${exceptionError}
                </div>
            </c:if>
            <c:if test="${not empty emailError}">
                <div class="alert alert-danger mb-3 error-message" style="border-radius: 20px">${emailError}</div>
            </c:if>
            <c:if test="${not empty emailFormatError}">
                <div class="alert alert-danger mb-3 error-message" style="border-radius: 20px">${emailFormatError}</div>
            </c:if>
            <c:if test="${not empty passwordError}">
                <div class="alert alert-danger mb-3 error-message" style="border-radius: 20px">${passwordError}</div>
            </c:if>
            <!-- Login Form -->
            <form action="${pageContext.request.contextPath}/login" method="POST" >
                <div class="mb-3">
                    <input type="text" name="emailOrPhone" class="form-control" placeholder="Email" value="${param.emailOrPhone}">
                </div>
                <div class="mb-3">
                    <input type="password" name="password" class="form-control" placeholder="Mật khẩu">
                </div>
                <div class="mb-3 d-flex justify-content-between">
                    <span id="togglePassword" onclick="togglePasswordVisibility()">👁 Show Password️</span>
                    <a href="forgotPassword" class="login-links">Quên mật khẩu?</a>
                </div>
                <button type="submit" name="submit" class="btn btn-login w-100"> Đăng nhập </button>
            </form>
            <div class="mt-4 text-center login-links">
                <a href="register">Tạo tài khoản</a> | <a href="homePage">Quay lại cửa hàng</a>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/js/login/login.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
        <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            var successToast = new bootstrap.Toast(document.getElementById('successToast'));
                            successToast.show();
                        });
        </script>
        <!-- Footer -->
        <%@include file="../Partials/Footer.jsp" %>
    </body>
</html>
