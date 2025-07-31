<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Product</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/admin/style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div id="wrapper">
            <%@include file="../Partials/Admin/Sidebar.jsp" %>

            <div id="page-content-wrapper">
                <!-- Navbar -->
                <nav class="navbar navbar-expand-lg navbar-dark bg-light border-bottom">
                    <div class="container-fluid">
                        <button class="btn btn-outline-success" id="menu-toggle"><i class="fas fa-bars"></i></button>
                        <h2 class="ms-3 text-dark">Dashboard</h2>
                        <button class="btn btn-outline-success ms-auto" id="dark-mode-toggle">
                            <a href="admin_profile" style="text-decoration: none; color: #87bbf2">
                                Hello, <c:out value="${sessionScope.user.fullName}" />!
                            </a>
                        </button>
                    </div>
                </nav>

                <!-- Breadcrumb -->
                <nav aria-label="breadcrumb" class="mt-3">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="viewProductList">List Product</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Create Product</li>
                    </ol>
                </nav>

                <!-- Main Content -->
                <div class="container mt-4 mb-5">
                    <h2>Create New Product</h2>
                    <form action="${pageContext.request.contextPath}/createProductVariant" method="post" enctype="multipart/form-data">
                        <c:if test="${not empty successMessage}">
                            <div class="alert alert-success" role="alert">${successMessage}</div>
                        </c:if>
                         <!-- Name product -->
                        <div class="mb-3">
                            <label for="ProductID" class="form-label">Tên sản phẩm <span class="text-danger">*</span></label>
                            <select class="form-select" id="ProductID" name="ProductID" required>
                                <option value="">-- Select Product --</option>
                                <c:forEach var="pro" items="${products}">
                                    <option value="${pro.id}" <c:if test="${param.productID != null && param.productID == (pro.id)}">selected</c:if>>${pro.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Color -->
                        <div class="mb-3">
                            <label for="color" class="form-label">Màu sắc <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="color" name="color" placeholder="Enter product color"
                                   value="${param.color != null ? param.color : ''}" required>
                        </div>

                        <!-- Description -->
                        <div class="mb-3">
                            <label for="size" class="form-label">Kích cỡ</label>
                            <input type="number" class="form-control" id="size" name="size" placeholder="Enter product size"
                                   value="${param.size != null ? param.size : ''}" required>
                        </div>

                        <!-- Price -->
                        <div class="mb-3">
                            <label for="quantity" class="form-label">Số lượng trong kho <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="quantity" name="quantity" placeholder="Enter quantity"
                                   value="${param.quantity}" required>
                        </div>

                        <!-- Submit -->
                        <button type="submit" class="btn btn-primary w-100">Create Product</button>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/admin/admin.js"></script>
    </body>
</html>
