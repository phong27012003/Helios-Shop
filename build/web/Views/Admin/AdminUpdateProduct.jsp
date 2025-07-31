<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Update Product</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h1 class="text-center mb-4">Update Product</h1>

            <form action="updateProduct" method="post" enctype="multipart/form-data" class="row g-3">
                <!-- ID ẩn -->
                <input type="hidden" name="id" value="${product.id}" />

                <!-- Tên sản phẩm -->
                <div class="col-md-6">
                    <label for="name">Product Name:</label>
                    <input type="text" class="form-control" name="name" id="name" value="${product.name}" required>
                </div>

                <!-- Giá -->
                <div class="col-md-6">
                    <label for="price">Price:</label>
                    <input type="number" class="form-control" name="price" id="price" value="${product.price}" required>
                </div>

                <!-- Giảm giá -->
                <div class="col-md-6">
                    <label for="discount">Discount (%):</label>
                    <input type="number" step="0.01" class="form-control" name="discount" id="discount" value="${product.discount}">
                </div>

                <!-- Mô tả -->
                <div class="col-md-12">
                    <label for="description">Description:</label>
                    <textarea class="form-control" name="description" id="description" rows="4">${product.description}</textarea>
                </div>

                <!-- Danh mục -->
                <div class="col-md-6">
                    <label for="categoryId">Category:</label>
                    <select class="form-select" name="categoryId" id="categoryId" required>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.id}" ${cat.id == product.category.id ? 'selected' : ''}>${cat.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Ảnh sản phẩm -->
                <div class="col-md-12">
                    <label for="images">Upload Images:</label>
                    <input type="file" class="form-control" name="images" id="images" multiple>
                </div>

                <!-- Hiển thị ảnh hiện tại -->
                <div class="col-md-12">
                    <label>Current Images:</label><br>
                    <c:forEach var="img" items="${product.imageUrls}">
                        <img src="${pageContext.request.contextPath}/${img}" alt="Product Image" width="100" class="me-2 mb-2"/>
                    </c:forEach>
                </div>

                <!-- Nút submit -->
                <div class="col-12 text-center">
                    <button type="submit" class="btn btn-primary px-4 py-2">Update Product</button>
                </div>
            </form>
        </div>
    </body>
</html>
