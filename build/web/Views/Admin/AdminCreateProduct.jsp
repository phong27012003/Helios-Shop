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
                    <form action="${pageContext.request.contextPath}/createProduct" method="post" enctype="multipart/form-data">
                        <c:if test="${not empty successMessage}">
                            <div class="alert alert-success" role="alert">${successMessage}</div>
                        </c:if>

                        <!-- Name -->
                        <div class="mb-3">
                            <label for="name" class="form-label">Product Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="name" name="name" placeholder="Enter product name"
                                   value="${param.name != null ? param.name : ''}" required>
                        </div>

                        <!-- Description -->
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="3"
                                      placeholder="Enter product description">${param.description}</textarea>
                        </div>

                        <!-- Price -->
                        <div class="mb-3">
                            <label for="price" class="form-label">Price (VND) <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="price" name="price" placeholder="Enter price"
                                   value="${param.price}" required>
                        </div>

                        <!-- Discount -->
                        <div class="mb-3">
                            <label for="discount" class="form-label">Discount (%)</label>
                            <input type="number" class="form-control" id="discount" name="discount" placeholder="Enter discount"
                                   step="0.01" value="${param.discount}">
                        </div>

                        <!-- Category -->
                        <div class="mb-3">
                            <label for="categoryId" class="form-label">Category <span class="text-danger">*</span></label>
                            <select class="form-select" id="categoryId" name="categoryId" required>
                                <option value="">-- Select Category --</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}" <c:if test="${param.categoryId != null && param.categoryId == (cat.id)}">selected</c:if>>${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Upload Images -->
                        <div class="mb-3">
                            <label for="images" class="form-label">Upload Images</label>
                            <input type="file" class="form-control" id="images" name="images" multiple accept="image/*">
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
