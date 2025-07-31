<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Chi tiết sản phẩm - Helios</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: 'Arial', sans-serif;
            }

            body {
                background-color: #000;
                color: #fff;
            }

            .container {
                display: flex;
                padding: 40px;
                max-width: 1300px;
                margin: auto;
                gap: 50px;
            }

            .image-gallery {
                flex: 1;
            }

            .image-gallery img {
                width: 100%;
                border-radius: 5px;
            }

            .thumbnail-list {
                display: flex;
                flex-direction: column;
                gap: 10px;
                margin-top: 20px;
            }

            .thumbnail-list img {
                width: 60px;
                height: 60px;
                border-radius: 4px;
                cursor: pointer;
            }

            .product-info {
                flex: 1;
            }

            .product-title {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .price {
                font-size: 22px;
                color: #f7a600;
                margin: 10px 0;
            }

            .rating {
                margin: 10px 0;
            }

            .stock {
                margin: 10px 0;
                color: #ccc;
            }

            .quantity {
                display: flex;
                gap: 10px;
                margin: 20px 0;
            }

            .quantity input {
                width: 50px;
                text-align: center;
            }

            .btn-main,
            .btn-secondary {
                padding: 12px 20px;
                border: none;
                cursor: pointer;
                margin-bottom: 10px;
                width: 100%;
                font-size: 16px;
            }

            .btn-main {
                background-color: #f7a600;
                color: black;
            }

            .btn-secondary {
                background-color: #222;
                color: white;
            }

            .tabs {
                margin-top: 30px;
            }

            .tab-item {
                background-color: #111;
                padding: 15px;
                border-bottom: 1px solid #333;
                cursor: pointer;
            }

            .description {
                margin: 30px auto;
                max-width: 1000px;
            }

            .description p {
                margin-bottom: 10px;
                color: #ccc;
            }

            .size-select, .color-select {
                background-color: #222;
                color: white;
                border: 1px solid #444;
                border-radius: 4px;
                padding: 8px 12px;
                margin: 8px 0;
                font-size: 14px;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .size-select:hover, .color-select:hover {
                border-color: #f7a600;
            }

            .size-select:focus, .color-select:focus {
                outline: none;
                border-color: #f7a600;
                box-shadow: 0 0 0 2px rgba(247, 166, 0, 0.2);
            }

            /* Style cho option */
            .size-select option, .color-select option {
                background-color: #333;
                color: white;
                padding: 8px;
            }

            /* Label style */
            label {
                display: block;
                margin-top: 15px;
                color: #ccc;
                font-size: 14px;
            }

            /* Container cho select để có layout đẹp */
            .select-container {
                margin-bottom: 15px;
            }
        </style>
    </head>

    <body>
        <!-- Header -->
        <%@include file="../Partials/Header.jsp" %>

        <div class="container">

            <div class="image-gallery">
                <img 
                    src="${not empty product.imageUrls ? product.imageUrls[0] : 'default.jpg'}"
                    alt="${product.name}"
                    />
            </div>

            <div class="product-info">
                <form method="post" action="productDetail">
                    <input hidden value="${product.id}" id="id" name="id" />
                    <div class="product-title">${product.name}</div>
                    <div class="price"><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> VND</div>
                    <div class="rating">★★★★★ 6 đánh giá</div>
                    <div>Size vòng tay</div>
                    <div>Size vòng tay</div>
                    <div class="stock">Size 18cm | Size 21cm</div>
                    <div class="select-container">
                        <label for="braceletSize">Chọn size:</label>
                        <select name="braceletSize" id="braceletSize" class="size-select">
                            <c:forEach var="c" items="${sizeList}">
                                <option value="${c}">${c} cm</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="select-container">
                        <label for="braceletColor">Chọn màu:</label>
                        <select name="braceletColor" id="braceletColor" class="color-select">
                            <c:forEach var="c" items="${colorList}">
                                <option value="${c}">${c}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="stock">5 trong kho</div>

                    <div class="description">
                        <p><strong>Bảo hành:</strong> Theo chính sách bảo hành và nhận đánh sáng sản phẩm trọn đời</p>
                        <p><strong>Mô tả:</strong> ${product.description}</p>
                    </div>

                    <button class="btn-secondary">Thêm vào giỏ hàng</button>
                    <button class="btn-main">Mua ngay</button>
                </form>


                <p style="margin-top: 15px; font-size: 13px; color: #aaa">
                    Đối với các khách đặt ngoài size, chúng tôi cần một thời gian để nghiên cứu, cánh để đảm bảo chất lượng đầu ra của sản phẩm. Do đó, thời gian pre-order có thể lên tới 12 - 14 ngày!
                </p>

                <div class="tabs">
                    <div class="tab-item">Thông tin sản phẩm</div>
                    <div class="tab-item">Chính sách bảo hành</div>
                    <div class="tab-item">Hướng dẫn bảo quản sản phẩm</div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <%@include file="../Partials/Footer.jsp" %>
    </body>

</html>

