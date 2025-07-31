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
                            <a href="./showAllProduct" style="text-decoration: none; color: #87bbf2">
                                Quay về trang bán hàng
                            </a>  
                        </button>
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
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h2 class="text-center m-0 flex-grow-1">Danh sách chi tiết đơn hàng</h2>
                        <form action="viewOrderItem" method="post">
                            <input type="hidden" value="${orderId}" id="id" name ="id"/>
                            <c:choose>
                                <c:when test="${status == 2}">
                                    <button class="btn btn-outline-success ms-auto opacity-50" disabled>
                                        Completed
                                    </button>
                                </c:when>
                                <c:when test="${status == 1}">
                                    <button class="btn btn-outline-success ms-auto">
                                        Shipping
                                    </button>
                                </c:when>
                                <c:when test="${status == 0}">
                                    <button class="btn btn-outline-success ms-auto">
                                        Pending
                                    </button>
                                </c:when>
                            </c:choose>

                        </form>
                    </div>

                    <!--                    <div class="d-flex justify-content-between mt-3 mb-3">
                                            <a href="./createAccount" class="btn btn-primary add-account-btn">+ Create New Account</a>
                    
                                             Filter Form 
                                            <form method="GET" action="ViewAccountList" class="d-flex mb-3">
                                                <input class="me-2"
                                                       type="text" name="search" placeholder="Search by Name" value="${searchKeyword}">
                                                <button class="btn btn-primary" type="submit">Search</button>
                                            </form>
                    
                                        </div>-->
                    <div class="container-fluid mt-4">
                        <table class="table table-bordered table-hover" id="orderItemTable">
                            <thead class="table-light">
                                <tr>
                                    <th>STT</th>
                                    <th>Order Item ID</th>
                                    <th>Product Name</th>
                                    <th>Quantity</th>
                                    <th>Price at Purchase</th>
                                    <th>Order ID</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="oi" items="${orderItemList}" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td>${oi.id}</td>
                                        <td>${oi.products.name}</td> <!-- hoặc ${oi.productName} nếu bạn dùng String -->
                                        <td>${oi.quantity}</td>
                                        <td>${oi.priceAtPurchase}</td>
                                        <td>${oi.order.id}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <!-- Pagination Start -->
                        <nav aria-label="Phân trang">
                            <ul class="pagination justify-content-center">
                                <!-- Nút Previous -->
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/viewAccountList?page=${currentPage - 1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo; Previous</span>
                                        </a>
                                    </li>
                                </c:if>
                                <c:if test="${currentPage == 1}">
                                    <li class="page-item disabled">
                                        <span class="page-link" aria-label="Previous">
                                            <span aria-hidden="true">&laquo; Previous</span>
                                        </span>
                                    </li>
                                </c:if>

                                <!-- Các số trang -->
                                <c:forEach var="i" begin="1" end="${totalPage}">
                                    <c:choose>
                                        <c:when test="${i == currentPage}">
                                            <li class="page-item active"><span class="page-link">${i}</span></li>
                                            </c:when>
                                            <c:otherwise>
                                            <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/viewAccountList?page=${i}">${i}</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>

                                <!-- Nút Next -->
                                <c:if test="${currentPage < totalPage}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/viewAccountList?page=${currentPage + 1}" aria-label="Next">
                                            <span aria-hidden="true">Next &raquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                                <c:if test="${currentPage == totalPage}">
                                    <li class="page-item disabled">
                                        <span class="page-link" aria-label="Next">
                                            <span aria-hidden="true">Next &raquo;</span>
                                        </span>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
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
