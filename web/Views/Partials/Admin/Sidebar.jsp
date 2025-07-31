<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="bg-dark border-right" id="sidebar-wrapper">
            <div class="sidebar-heading text-center py-4 primary-text fs-4 fw-bold text-uppercase border-bottom">
                <i class="fas fa-user-shield me-2"></i>Admin
            </div>
            <div class="list-group list-group-flush">
                <a href="ViewAccountList" class="list-group-item list-group-item-action bg-dark text-white active">
                    <i class="fas fa-list me-2"></i>List Account
                </a>
                <a href="viewProductList" class="list-group-item list-group-item-action bg-dark text-white active">
                    <i class="fas fa-list me-2"></i>List Product
                </a>
                <a href="viewProductVariantList" class="list-group-item list-group-item-action bg-dark text-white active">
                    <i class="fas fa-list me-2"></i>List Product Variant
                </a>
                <a href="viewOrder" class="list-group-item list-group-item-action bg-dark text-white active">
                    <i class="fas fa-list me-2"></i>List Order
                </a>
                <a href="logout" class="list-group-item list-group-item-action bg-dark text-white">
                    <i class="fas fa-sign-out-alt me-2"></i>Log Out
                </a> 
            </div>
        </div>
    </body>
</html>
