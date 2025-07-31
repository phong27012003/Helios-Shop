<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>FU House Finder - Reset Password</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Boxicons for Icons -->
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
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
        <!-- Main -->
        <div class="form-container">
            <h2 class="text-center mb-4">Đặt lại mật khẩu của bạn</h3>

                <form action="${pageContext.request.contextPath}/resetPassword" method="post" >
                    <div class="mb-4">
                        <c:if test="${not empty message}">
                            <div class="message">${message}</div>
                        </c:if>
                    </div>
                    <!-- Verification Code -->
                    <div class="mb-4">
                        <label for="code" class="fw-bold">Verification Code <span class="text-danger">*</span></label>
                        <div class="input-group mt-2">
                            <span class="input-group-text bg-light border-0"><i class='bx bx-user fs-4'></i></span>
                            <input type="text" name="code" id="code" placeholder="Enter Code" class="form-control border-0"
                                   value="<c:out value='${param.code}'/>">
                        </div>
                        <c:if test="${not empty messageCode}">
                            <div class="message">${messageCode}</div>
                        </c:if>
                    </div>

                    <!-- New Password -->
                    <div class="mb-4">
                        <label for="newPassword" class="fw-bold">New Password <span class="text-danger">*</span></label>
                        <div class="input-group mt-2">
                            <span class="input-group-text bg-light border-0"><i class='bx bx-lock fs-4'></i></span>
                            <input type="password" name="newPassword" id="newPassword" placeholder="New Password" class="form-control border-0"
                                   value="<c:out value='${param.newPassword}'/>">
                        </div>
                        <c:if test="${not empty messageNewPassword}">
                            <div class="message">${messageNewPassword}</div>
                        </c:if>
                        <c:if test="${not empty messagePattern}">
                            <div class="message">${messagePattern}</div>
                        </c:if>
                    </div>

                    <!-- Confirm New Password -->
                    <div class="mb-4">
                        <label for="confirmPassword" class="fw-bold">Confirm New Password <span class="text-danger">*</span></label>
                        <div class="input-group mt-2">
                            <span class="input-group-text bg-light border-0"><i class='bx bx-lock fs-4'></i></span>
                            <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Confirm Password" class="form-control border-0"
                                   value="<c:out value='${param.confirmPassword}'/>">
                        </div>
                        <c:if test="${not empty messageConfirmPassword}">
                            <div class="message">${messageConfirmPassword}</div>
                        </c:if>
                        <c:if test="${not empty messageMatchPassword}">
                            <div class="message">${messageMatchPassword}</div>
                        </c:if>
                    </div>

                    <!-- Submit Button -->
                    <div class="d-grid mt-4">
                        <button type="submit" name="btnreset" class="btn btn-login" style="border-radius: 15px">Submit</button>
                    </div>
                    <div class="mt-4 text-center login-links">
                        <a href="homePage">Quay lại cửa hàng</a>
                    </div>
                </form>
        </div>
        <!-- Footer -->
        <%@include file="../Partials/Footer.jsp" %>
    </body>
</html>
