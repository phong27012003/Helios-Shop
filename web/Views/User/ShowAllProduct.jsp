<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nhẫn Bạc Nam - Khẳng Định Sự Khác Biệt | Helios Jewels</title>
        <link rel="stylesheet" href="/css/nhanbac.css" />
        <link
            rel="icon"
            type="image/png"
            href="https://ext.same-assets.com/718871603/3418794103.png"
            />
        <style>
            /* Reset some defaults */
            html,
            body {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                background: #0c0f11;
                color: #fff;
                font-family: 'SVN-Futura', Arial, Helvetica, sans-serif;
            }

            /* Navbar */
            .navbar {
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 1.3rem 2.5rem 1.3rem 1.8rem;
                box-sizing: border-box;
                font-size: 1.08rem;
                background: #3c4146;
            }

            .nav-section {
                display: flex;
                align-items: center;
            }

            .nav-left .nav-link,
            .nav-right .nav-link {
                color: #fff;
                margin-right: 1.5rem;
                text-decoration: none;
                letter-spacing: 0.01em;
                font-weight: 400;
                transition: color 0.2s;
            }

            .nav-left .nav-link:last-child,
            .nav-right .nav-link:last-child {
                margin-right: 0;
            }

            .nav-link.nav-highlight {
                background: #ffc34a;
                color: #1a1717;
                font-weight: bold;
                border-radius: 3px;
                padding: 0.4rem 1.35rem;
                margin-right: 1.5rem;
                margin-left: 0.35rem;
                box-shadow: 0 3px 6px rgba(255, 195, 74, 0.08);
                transition: background 0.25s, color 0.25s;
            }

            .logo {
                font-family: 'Old English Text MT', 'Cinzel Decorative', serif;
                /* Placeholder: will setup custom gothic font*/
                font-size: 2.5rem;
                color: #fff;
                letter-spacing: 0.15em;
                text-transform: uppercase;
                text-align: center;
                font-weight: 600;
            }

            .nav-center {
                flex: 1;
                justify-content: center;
                display: flex;
            }

            .nav-section.nav-left {
                min-width: 380px;
            }

            .nav-section.nav-right {
                min-width: 390px;
                justify-content: flex-end;
                gap: 0.5rem;
            }

            .nav-icon img {
                vertical-align: middle;
                filter: brightness(95%);
            }

            .nav-icon.cart {
                position: relative;
                margin-left: 0.1rem;
            }

            .cart-count {
                position: absolute;
                top: -6px;
                right: -9px;
                background: #ffc34a;
                color: #cdb7b7;
                border-radius: 50%;
                font-size: 0.7rem;
                width: 18px;
                height: 18px;
                line-height: 18px;
                text-align: center;
                font-weight: bold;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            }

            .dropdown span {
                cursor: pointer;
                font-size: 1rem;
                margin-right: 1.7rem;
            }



            /* Dropdown menu for MENU */
            .menu-dropdown-wrapper {
                position: relative;
                display: inline-block;
            }

            .menu-main {
                position: relative;
                z-index: 40;
            }

            .menu-dropdown {
                display: none;
                position: absolute;
                left: 0;
                top: 100%;
                margin-top: 9px;
                min-width: 420px;
                max-width: 700px;
                background: #181a1b;
                color: #f7f7f5;
                border-radius: 12px;
                box-shadow: 0 14px 42px 0 rgba(20, 15, 12, 0.13);
                padding: 1.2rem 1.5rem 1.1rem 1.5rem;
                flex-direction: row;
                gap: 2.4rem;
                z-index: 39;
                animation: menuFadeIn .2s;
            }

            .menu-dropdown-wrapper:hover .menu-dropdown,
            .menu-dropdown-wrapper:focus-within .menu-dropdown {
                display: flex;
            }

            .menu-col {
                display: flex;
                flex-direction: column;
                min-width: 155px;
                padding-right: 7px;
            }

            .menu-header {
                color: #ffc34a;
                font-weight: bold;
                font-size: 1.02rem;
                margin-bottom: 4px;
                margin-top: 11px;
                letter-spacing: 0.02em;
            }

            .menu-col a {
                font-size: 1rem;
                color: #f7f7f5;
                text-decoration: none;
                padding: 4px 0 4px 2px;
                margin-bottom: 1px;
                border-radius: 5px;
                transition: background 0.18s, color 0.16s;
                cursor: pointer;
            }

            .menu-col a:hover {
                background: #25201b;
                color: #ffc34a;
            }

            @keyframes menuFadeIn {
                from {
                    opacity: 0;
                    transform: translateY(18px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            @media (max-width: 900px) {
                .menu-dropdown {
                    left: 0;
                    top: 100%;
                    min-width: 240px;
                    padding: 0.7rem 0.7rem 0.8rem 0.7rem;
                    gap: 0.6rem;
                }

                .menu-col {
                    min-width: 98px;
                }
            }

            .collection-header {
                text-align: center;
                margin-top: 2.5rem;
                margin-bottom: 2rem;
            }

            /* Tổng thể bố cục collection */
            .collection-layout {
                display: flex;
                flex-wrap: nowrap;
                gap: 20px;
            }

            /* Sidebar bên trái */
            .sidebar-filter {
                flex: 1 1 250px;
                max-width: 250px;
                background-color: #2e2525;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 2px 6px rgba(239, 236, 236, 0.1);
            }

            .filter-title {
                font-size: 1.4rem;
                font-weight: bold;
                margin-bottom: 15px;
                color: #eed6d6;
            }

            .filter-group {
                margin-bottom: 20px;
            }

            .filter-group-title {
                font-weight: 600;
                margin-bottom: 10px;
                color: #e3d2d2;
            }

            .filter-list {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .filter-link {
                display: block;
                padding: 6px 8px;
                color: #af9d9d;
                text-decoration: none;
                border-radius: 4px;
                transition: background-color 0.3s ease;
            }

            .filter-link:hover {
                background-color: #ddd;
                color: #000;
            }

            /* Product Grid bên phải */
            .product-grid {
                flex: 1 1 calc(100% - 280px);
                /* Trừ đi sidebar */
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
                gap: 20px;
            }

            /* Card sản phẩm */
            .product-card {
                background-color: #1f1c1c;
                border-radius: 12px;
                padding: 15px;
                text-align: center;
                transition: box-shadow 0.3s ease;
            }

            .product-card:hover {
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            .product-img-wrap img {
                width: 100%;
                height: auto;
                border-radius: 8px;
            }

            .product-title {
                font-size: 12px;
                margin: 10px 0;
                color: #c0a9a9;
            }

            .product-price-row {
                margin: 5px 0;
            }

            .product-price {
                font-size: 14px;
                font-weight: bold;
                color: #c0a9a9;
            }

            .product-rating {
                font-size: 0.9rem;
                color: #999;
                margin-bottom: 10px;
            }

            .product-actions button {
                margin: 5px;
                padding: 8px 12px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
            }

            .btn-ghost {
                background-color: #fff;
                border: 1px solid #ccc;
                color: #333;
            }

            .btn-ghost:hover {
                background-color: #eee;
            }

            .btn-main {
                background-color: #007bff;
                color: white;
            }

            .btn-main:hover {
                background-color: #0056b3;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .collection-layout {
                    flex-direction: column;
                }

                .sidebar-filter {
                    max-width: 100%;
                }

                .product-grid {
                    grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
                }
            }


            /* 3. Footer Styling */
            footer {
                background: #101011;
                color: #fff;
                padding-top: 2.8rem;
                padding-bottom: 0.7rem;
                margin-top: 0;
                width: 100vw;
            }

            .footer-inner {
                max-width: 1250px;
                margin: 0 auto;
                width: 95%;
            }

            .footer-cols {
                display: flex;
                flex-wrap: wrap;
                gap: 2.5rem;
                justify-content: space-between;
            }

            .footer-col {
                flex: 1 1 220px;
                min-width: 200px;
                margin-bottom: 2.6rem;
            }

            .footer-col h3 {
                font-size: 1.08rem;
                margin-bottom: 0.7rem;
                color: #ffc34a;
                font-weight: 600;
                letter-spacing: 0.04em;
            }

            .footer-col p {
                font-size: 1rem;
                margin: 5px 0 16px 0;
                color: #f0ece7;
            }

            .footer-col ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .footer-col li {
                margin-bottom: 0.45rem;
            }

            .footer-col a {
                color: #f7eadf;
                text-decoration: none;
                transition: color 0.2s;
            }

            .footer-col a:hover {
                color: #ffc34a;
            }

            .footer-social a {
                display: inline-block;
                margin-right: 0.6rem;
                margin-top: 0.2rem;
            }

            .footer-social img {
                height: 28px;
                width: 28px;
                filter: grayscale(0) brightness(0.96);
                transition: filter 0.2s;
            }

            .footer-social img:hover {
                filter: grayscale(0) brightness(1) drop-shadow(0 0 4px #ffc34a77);
            }

            /* Bottom Row */
            .footer-bottom {
                display: flex;
                align-items: center;
                justify-content: space-between;
                border-top: 1.5px solid #242526;
                padding-top: 1rem;
                padding-bottom: 0.3rem;
            }

            .footer-left {
                display: flex;
                align-items: center;
                gap: 1.1rem;
            }

            .footer-logo {
                vertical-align: middle;
            }

            .copyright {
                font-size: 1rem;
                opacity: 0.88;
                color: #bbb8ae;
            }

            .footer-links {
                gap: 1.5rem;
                display: flex;
            }

            .footer-links a {
                color: #fff;
                font-size: 1rem;
                text-decoration: none;
                opacity: 0.94;
                margin-left: 1rem;
                transition: color 0.17s, opacity 0.17s;
            }

            .footer-links a:hover {
                color: #ffc34a;
                opacity: 1;
            }

            /* Dropdown menu for MENU */
            .menu-dropdown-wrapper {
                position: relative;
                display: inline-block;
            }

            .menu-main {
                position: relative;
                z-index: 40;
            }

            .menu-dropdown {
                display: none;
                position: absolute;
                left: 0;
                top: 100%;
                margin-top: 9px;
                min-width: 420px;
                max-width: 700px;
                background: #181a1b;
                color: #f7f7f5;
                border-radius: 12px;
                box-shadow: 0 14px 42px 0 rgba(20, 15, 12, 0.13);
                padding: 1.2rem 1.5rem 1.1rem 1.5rem;
                flex-direction: row;
                gap: 2.4rem;
                z-index: 39;
                animation: menuFadeIn .2s;
            }

            .menu-dropdown-wrapper:hover .menu-dropdown,
            .menu-dropdown-wrapper:focus-within .menu-dropdown {
                display: flex;
            }

            .menu-col {
                display: flex;
                flex-direction: column;
                min-width: 155px;
                padding-right: 7px;
            }

            .menu-header {
                color: #ffc34a;
                font-weight: bold;
                font-size: 1.02rem;
                margin-bottom: 4px;
                margin-top: 11px;
                letter-spacing: 0.02em;
            }

            .menu-col a {
                font-size: 1rem;
                color: #f7f7f5;
                text-decoration: none;
                padding: 4px 0 4px 2px;
                margin-bottom: 1px;
                border-radius: 5px;
                transition: background 0.18s, color 0.16s;
                cursor: pointer;
            }

            .menu-col a:hover {
                background: #25201b;
                color: #ffc34a;
            }

            .pagination {
                display: flex;
                justify-content: center; /* Căn giữa ngang */
                align-items: center;
                gap: 8px; /* Khoảng cách giữa các nút */
                margin-top: 2rem;
                flex-wrap: wrap;
            }

            .page-link {
                display: inline-block;
                padding: 8px 12px;
                background-color: #f0f0f0;
                color: #333;
                border-radius: 5px;
                text-decoration: none;
                transition: all 0.2s ease-in-out;
            }

            .page-link:hover {
                background-color: #ddd;
            }

            .page-link.active {
                background-color: #333;
                color: #fff;
                font-weight: bold;
            }


            @media (max-width: 1020px) {
                .footer-cols {
                    flex-direction: column;
                    gap: 0.7rem;
                }

                .footer-bottom {
                    flex-direction: column;
                    gap: 0.5rem;
                    align-items: flex-start;
                }
            }

            @media (max-width: 650px) {

                .footer-inner {
                    width: 100vw;
                    padding: 0 1.5vw;
                }
            }


            @media (max-width: 900px) {
                .menu-dropdown {
                    left: 0;
                    top: 100%;
                    min-width: 240px;
                    padding: 0.7rem 0.7rem 0.8rem 0.7rem;
                    gap: 0.6rem;
                }

                .menu-col {
                    min-width: 98px;
                }
            }

            @media (max-width: 900px) {
                .navbar {
                    flex-direction: column;
                    padding: 1rem;
                }

                .nav-section.nav-left,
                .nav-section.nav-right {
                    min-width: auto;
                }

                .nav-center {
                    margin: 0.7rem 0 0.4rem 0;
                }
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <%@include file="../Partials/Header.jsp" %>

        <!-- Main Content -->
        <main>
            <section class="collection-header">
                <h1 class="collection-title">NHẪN BẠC NAM - KHẲNG ĐỊNH SỰ KHÁC BIỆT</h1>
                <p class="collection-desc">
                    Khám phá bộ sưu tập nhẫn bạc nam đẹp, chất liệu bạc cao cấp, đa dạng
                    kiểu dáng. Thiết kế độc nhất, tinh tế nâng tầm phong cách đàn ông
                    trưởng thành.
                </p>
            </section>
            <section class="product-grid-section">
                <div class="collection-layout">
                    <!--Filter-->
                    <aside class="sidebar-filter">
                        <h2 class="filter-title">Bộ lọc</h2>
                        <div class="filter-group">
                            <div class="filter-group-title">Khoảng giá</div>
                            <ul class="filter-list">
                                <li><a href="#" class="filter-link">0 - 499.000 VND</a></li>
                                <li>
                                    <a href="#" class="filter-link">500.000 - 999.000 VND</a>
                                </li>
                                <li>
                                    <a href="#" class="filter-link">1.000.000 - 1.499.000 VND</a>
                                </li>
                                <li>
                                    <a href="#" class="filter-link">1.500.000 - 1.999.000 VND</a>
                                </li>
                                <li><a href="#" class="filter-link">Trên 2.000.000 VND</a></li>
                            </ul>
                        </div>
                        <div class="filter-group">
                            <div class="filter-group-title">Loại đá</div>
                            <ul class="filter-list">
                                <li><a href="#" class="filter-link">Tiger Eye</a></li>
                                <li><a href="#" class="filter-link">Onyx</a></li>
                                <li><a href="#" class="filter-link">Opal</a></li>
                                <li><a href="#" class="filter-link">Turquoise</a></li>
                                <li>
                                    <a href="#" class="filter-link">Tiger Eye Vàng (Pre-order)</a>
                                </li>
                                <li>
                                    <a href="#" class="filter-link"
                                       >Tiger Eye Xanh đen (Pre-order)</a
                                    >
                                </li>
                            </ul>
                        </div>
                        <div class="filter-group">
                            <div class="filter-group-title">Tags</div>
                            <ul class="filter-list">
                                <li><a href="#" class="filter-link">Sale</a></li>
                                <li><a href="#" class="filter-link">Pre-Order</a></li>
                            </ul>
                        </div>
                    </aside>
                    <!--Product Grid-->
                    <div class="product-grid">
                        <c:forEach var="p" items="${products}">
                            <div class="product-card">
                                <div class="product-img-wrap">
                                    <img 
                                        src="${not empty p.imageUrls ? p.imageUrls[0] : 'default.jpg'}"
                                        alt="${p.name}"
                                        />
                                </div>
                                <h3 class="product-title">${p.name}</h3>
                                <div class="product-price-row">
                                    <span class="product-price"><fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/> VND</span>
                                </div>
                                <!--<div class="product-rating">★ 2 đánh giá</div>-->
                                <div class="product-actions">
                                    <button class="btn-ghost"><a href="productDetail?id=${p.id}" >Xem nhanh</a></button>   
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                </div>
            </section>
            <!-- Phân trang -->

            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a class="page-link" href="showAllProduct?page=${currentPage - 1}&search=${search}">Previous</a>
                </c:if>
                <a class="page-link" href="showAllProduct?page=${currentPage + 1}&search=${search}">Next</a>
            </div>
        </main>

        <!-- Footer -->
        <%@include file="../Partials/Footer.jsp" %>
    </body>
</html>
