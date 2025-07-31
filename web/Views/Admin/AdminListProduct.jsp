<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link href="${pageContext.request.contextPath}/css/admin/style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div id="wrapper">
            <!-- Sidebar -->
            <%@include file="../Partials/Admin/Sidebar.jsp" %>
            <!-- Main Content -->
            <div id="page-content-wrapper">
                <!-- Navigation Bar in Page Content -->
                <nav class="navbar navbar-expand-lg navbar-dark bg-light border-bottom">
                    <div class="container-fluid">
                        <button class="btn btn-outline-success" id="menu-toggle"><i class="fas fa-bars"></i></button>
                        <h2 class="ms-3 text-dark">Dashboard</h2>

                        <button class="btn btn-outline-success ms-auto" id="dark-mode-toggle">
                            <a href="#" style="text-decoration: none; color: #87bbf2">
                                Hello, <c:out value="${sessionScope.user.fullName}" />!
                            </a>  
                        </button>
                    </div>
                </nav>
                <div class="main-content mt-5">
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
                    <h2 class="text-center">Danh sách tài khoản</h2>
                    <div class="d-flex justify-content-between mt-3 mb-3">
                        <a href="./createProduct" class="btn btn-primary add-account-btn">+ Create New Product</a>

                        <!-- Filter Form -->
                        <form method="GET" action="viewProductList" class="d-flex mb-3">
                            <input class="me-2"
                                   type="text" name="search" placeholder="Search by Name" value="${searchKeyword}">
                            <button class="btn btn-primary" type="submit">Search</button>
                        </form>

                    </div>
                    <div class="container-fluid mt-4">
                        <table class="table table-bordered table-hover" id="accountTable">
                            <thead class="table-light">
                                <tr>
                                    <th>Tên Sản Phẩm</th>
                                    <th>Giá Tiền</th>
                                    <th>Giảm giá</th>
                                    <th>Loại</th>
                                    <th>Ngày cập nhật</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="pro" items="${products}" varStatus="status">
                                    <tr>
                                        <td>${pro.name}</td>
                                        <td>${pro.price}</td>
                                        <td>${pro.discount}</td>
                                        <td>${pro.category.name}</td>
                                        <td>${pro.createdAt}</td>
                                        <td class="table-actions">
                                            <a href="${pageContext.request.contextPath}/updateProduct?id=${pro.id}" title="Cập nhật">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="green"
                                                     class="bi bi-pencil" viewBox="0 0 16 16">
                                                <path
                                                    d="M12.854.146a.5.5 0 0 1 .638.057l2.5 2.5a.5.5 0 0 1-.057.638l-10 10a.5.5 0 0 1-.233.13l-5 1.5a.5.5 0 0 1-.632-.632l1.5-5a.5.5 0 0 1 .13-.233l10-10zm1.415 3.207L11.207 1.793 2 11v2h2l8.854-8.854zM2.5 12.5v1h1l.5-.5H2.5z" />
                                                </svg>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/deleteProduct?id=${pro.id}" onclick="return confirm('Bạn có muốn xóa sản phẩm này không?')" title="Xóa">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="red" class="bi bi-trash"
                                                     viewBox="0 0 16 16">
                                                <path
                                                    d="M5.5 5.5v6h-1v-6h1zm3 0v6h-1v-6h1zm3 0v6h-1v-6h1zM14.5 4a.5.5 0 0 1 .5.5v.5H1v-.5a.5.5 0 0 1 .5-.5h12.5zM4.118 4l.405-1.607A.5.5 0 0 1 5 2h6a.5.5 0 0 1 .477.393L11.882 4H14v1H2V4h2.118zm1.415 10A1.5 1.5 0 0 0 7 14h2a1.5 1.5 0 0 0 1.467-1.607L9.882 6H6.118l-.415 6H4.883l-.415 6z" />
                                                </svg>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach> 
                            </tbody>
                        </table>

                        <!-- Pagination Start -->
                        <div class="pagination">
                            <c:if test="${currentPage > 1}">
                                <a class="page-link" href="viewProductList?page=${currentPage - 1}&search=${search}">Previous</a>
                            </c:if>
                            <a class="page-link" href="viewProductList?page=${currentPage + 1}&search=${search}">Next</a>
                        </div>
                        <!-- Pagination End -->
                    </div>
                </div>
            </div>  
        </div>
        <!-- Bootstrap JS và phụ thuộc -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
        <!-- Font Awesome JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
        <!-- Custom JS -->
        <script src="${pageContext.request.contextPath}/js/admin/admin.js"></script>
        <script src="${pageContext.request.contextPath}/js/admin/filterTable.js" type="text/javascript"></script> 
        <script>
                                                document.addEventListener('DOMContentLoaded', function () {
                                                    var successToast = new bootstrap.Toast(document.getElementById('successToast'));
                                                    successToast.show();
                                                });
        </script>
    </body>

</html>
